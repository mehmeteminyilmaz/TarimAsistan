import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/bitki_model.dart';
import '../models/toprak_model.dart';
import '../services/firebase_service.dart';
import 'toprak_detay_sayfasi.dart';

class SonucSayfasiArgs {
  final File imageFile;
  final ToprakModel toprak;
  final double guvenYuzdesi;

  SonucSayfasiArgs({
    required this.imageFile,
    required this.toprak,
    required this.guvenYuzdesi,
  });
}

class SonucSayfasi extends StatefulWidget {
  static const String routeName = '/sonuc';

  final SonucSayfasiArgs? args;

  const SonucSayfasi({super.key, this.args});

  @override
  State<SonucSayfasi> createState() => _SonucSayfasiState();
}

class _SonucSayfasiState extends State<SonucSayfasi> {
  late ToprakModel _toprak;
  late File _imageFile;
  late double _guven;
  late Future<List<BitkiModel>> _bitkiFuture;

  @override
  void initState() {
    super.initState();
    final a = widget.args;
    if (a == null) {
      // Güvenlik için basit bir geri dönüş
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
      return;
    }
    _toprak = a.toprak;
    _imageFile = a.imageFile;
    _guven = a.guvenYuzdesi;
    _bitkiFuture = FirebaseService.instance.getUygunBitkiler(_toprak.id);
  }

  @override
  Widget build(BuildContext context) {
    // args null ise boş Scaffold dön
    if (widget.args == null) {
      return const Scaffold();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analiz Sonucu'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                _imageFile,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.shade400,
                    Colors.green.shade700,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Toprağınız Tespit Edildi!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '%${_guven.toStringAsFixed(1)} güven',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _toprak.ad,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _hizliOzellikKart(
                        ikon: Icons.science,
                        baslik: 'pH',
                        deger: _toprak.phAralik,
                      ),
                      const SizedBox(width: 8),
                      _hizliOzellikKart(
                        ikon: Icons.water_drop,
                        baslik: 'Su',
                        deger: _toprak.suTutma,
                      ),
                      const SizedBox(width: 8),
                      _hizliOzellikKart(
                        ikon: Icons.air,
                        baslik: 'Havalanma',
                        deger: _toprak.havalanma,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          ToprakDetaySayfasi.routeName,
                          arguments: _toprak,
                        );
                      },
                      child: const Text('Detaylı Bilgileri Gör'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Önerilen Bitkiler',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 180,
              child: FutureBuilder<List<BitkiModel>>(
                future: _bitkiFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Bitkiler yüklenirken hata oluştu.'),
                    );
                  }
                  final bitkiler = snapshot.data ?? [];
                  if (bitkiler.isEmpty) {
                    return const Center(
                      child: Text('Bu toprak için kayıtlı bitki yok.'),
                    );
                  }
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: bitkiler.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final b = bitkiler[index];
                      return SizedBox(
                        width: 150,
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                child: SizedBox(
                                  height: 90,
                                  width: double.infinity,
                                  child: CachedNetworkImage(
                                    imageUrl: b.resimUrl,
                                    fit: BoxFit.cover,
                                    errorWidget: (_, __, ___) => Container(
                                      color: Colors.green.shade100,
                                      child: const Icon(
                                        Icons.grass,
                                        color: Colors.green,
                                      ),
                                    ),
                                    placeholder: (_, __) => Container(
                                      color: Colors.green.shade50,
                                      child: const Center(
                                        child: SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      b.ad,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      b.kategori,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _hizliOzellikKart({
    required IconData ikon,
    required String baslik,
    required String deger,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(
              ikon,
              color: Colors.green,
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              baslik,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              deger,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

