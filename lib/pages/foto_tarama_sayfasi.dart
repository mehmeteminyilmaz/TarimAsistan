import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/ai_service.dart';
import '../services/firebase_service.dart';
import '../ui/app_ui.dart';
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
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TarimUi.radiusMd),
          ),
          content: const Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text('Toprağınız analiz ediliyor…'),
              ),
            ],
          ),
          backgroundColor: TarimUi.forest,
        ),
      );

      final sonuc = await AIService.instance.analizEt(picked.path);

      if (!(sonuc['basarili'] == true)) {
        if (!mounted) return;
        messenger.hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              sonuc['hata']?.toString() ?? 'Analiz sırasında hata oluştu',
            ),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      final toprakId = sonuc['toprak_id']?.toString() ?? '';
      final toprak = await FirebaseService.instance.getToprakDetay(toprakId);

      if (!mounted) return;
      messenger.hideCurrentSnackBar();

      if (toprak == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Toprak detayları bulunamadı.'),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
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
      messenger.hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('İşlem sırasında bir hata oluştu.'),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
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
      appBar: const TarimGradientAppBar(
        title: 'Fotoğrafla Tanı',
        colors: [
          Color(0xFF1565C0),
          Color(0xFF0D47A1),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: TarimUi.pageBackground(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TarimSurfaceCard(
                padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF42A5F5),
                            Color(0xFF1565C0),
                          ],
                        ),
                        boxShadow: TarimUi.glowShadow(const Color(0xFF1565C0)),
                      ),
                      child: const Icon(
                        Icons.document_scanner_rounded,
                        size: 56,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Toprağını saniyeler içinde analiz et',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: TarimUi.forest,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Net, yakın ve iyi ışıklı bir fotoğraf en iyi sonucu verir.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TarimSurfaceCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TarimSectionTitle(
                      title: 'İpuçları',
                      icon: Icons.tips_and_updates_rounded,
                    ),
                    _TipRow(
                      icon: Icons.center_focus_strong_rounded,
                      text: 'Toprağa yakın çekim; kadrajda mümkün olduğunca sadece toprak olsun.',
                    ),
                    _TipRow(
                      icon: Icons.wb_sunny_rounded,
                      text: 'Gölgesiz, doğal ışık tercih edin.',
                    ),
                    _TipRow(
                      icon: Icons.hide_image_rounded,
                      text: 'Taş, yaprak gibi nesneler sonucu zorlaştırabilir.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              if (_loading)
                const Column(
                  children: [
                    CircularProgressIndicator(color: TarimUi.sky),
                    SizedBox(height: 12),
                    Text(
                      'Yapay zeka analiz ediyor…',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: TarimUi.forest,
                      ),
                    ),
                  ],
                )
              else ...[
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: TarimUi.sky,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(TarimUi.radiusMd),
                      ),
                    ),
                    icon: const Icon(Icons.photo_camera_rounded, size: 22),
                    label: const Text(
                      'Kamera ile çek',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: () => _secVeAnalizEt(ImageSource.camera),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: TarimUi.forest,
                      side: const BorderSide(color: TarimUi.leaf, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(TarimUi.radiusMd),
                      ),
                    ),
                    icon: const Icon(Icons.photo_library_rounded),
                    label: const Text(
                      'Galeriden seç',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: () => _secVeAnalizEt(ImageSource.gallery),
                  ),
                ),
              ],
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _TipRow extends StatelessWidget {
  const _TipRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: TarimUi.sky),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                height: 1.35,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
