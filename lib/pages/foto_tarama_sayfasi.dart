import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/ai_service.dart';
import '../services/firebase_service.dart';
import 'sonuc_sayfasi.dart';

class FotoTaramaSayfasi extends StatefulWidget {
  static const String routeName = '/foto-tarama';

  const FotoTaramaSayfasi({super.key});

  @override
  State<FotoTaramaSayfasi> createState() => _FotoTaramaSayfasiState();
}

class _FotoTaramaSayfasiState extends State<FotoTaramaSayfasi> {
  final ImagePicker _picker = ImagePicker();
  bool _loading = false;

  Future<void> _secVeAnalizEt(ImageSource kaynak) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final picked = await _picker.pickImage(source: kaynak, imageQuality: 80);
      if (picked == null) return;

      if (!mounted) return;
      setState(() => _loading = true);

      messenger.showSnackBar(
        const SnackBar(
          content: Text('Toprağınız analiz ediliyor...'),
        ),
      );

      final sonuc = await AIService.instance.analizEt(picked.path);

      if (!(sonuc['basarili'] == true)) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(sonuc['hata']?.toString() ?? 'Analiz sırasında hata oluştu'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final toprakId = sonuc['toprak_id']?.toString() ?? '';
      final toprak = await FirebaseService.instance.getToprakDetay(toprakId);

      if (!mounted) return;

      if (toprak == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Toprak detayları bulunamadı.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      Navigator.pushNamed(
        context,
        SonucSayfasi.routeName,
        arguments: SonucSayfasiArgs(
          imageFile: File(picked.path),
          toprak: toprak,
          guvenYuzdesi: (sonuc['guven'] as num?)?.toDouble() ?? 0.0,
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('İşlem sırasında bir hata oluştu.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fotoğrafla Tanı'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt,
                size: 60,
                color: Colors.blue.shade600,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Toprak analizi için fotoğraf çekin veya galeriden seçin.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            const Text(
              '• Toprağa yakın çekim yapın\n• Işıklandırmanın iyi olduğundan emin olun\n• Bitki, taş vb. nesneleri mümkün olduğunca kadrajdan çıkarın',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            if (_loading)
              Column(
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('Toprağınız analiz ediliyor...'),
                ],
              )
            else
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text(
                        'Kamera ile Çek',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () => _secVeAnalizEt(ImageSource.camera),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      icon: const Icon(Icons.photo_library),
                      label: const Text(
                        'Galeriden Seç',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () => _secVeAnalizEt(ImageSource.gallery),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

