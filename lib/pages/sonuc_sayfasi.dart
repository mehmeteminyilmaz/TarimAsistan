import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/bitki_model.dart';
import '../models/toprak_model.dart';
import '../services/firebase_service.dart';
import '../ui/app_ui.dart';
import 'bitki_detay_sayfasi.dart';
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
    if (widget.args == null) {
      return const Scaffold();
    }

    return Scaffold(
      appBar: const TarimGradientAppBar(
        title: 'Analiz sonucu',
        colors: [
          TarimUi.mint,
          TarimUi.forest,
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: TarimUi.pageBackground(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(TarimUi.radiusLg),
                  boxShadow: TarimUi.softShadow,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(TarimUi.radiusLg),
                  child: Stack(
                    children: [
                      Image.file(
                        _imageFile,
                        height: 240,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        left: 12,
                        top: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.45),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.photo_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Analiz görseli',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF40916C),
                      Color(0xFF1B4332),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(TarimUi.radiusXl),
                  boxShadow: TarimUi.glowShadow(TarimUi.forest),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.verified_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Toprağın tespit edildi',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _toprak.ad,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            '%${_guven.toStringAsFixed(0)}',
                            style: const TextStyle(
                              color: TarimUi.forest,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _MiniStat(
                          ikon: Icons.science_rounded,
                          baslik: 'pH',
                          deger: _toprak.phAralik,
                        ),
                        const SizedBox(width: 8),
                        _MiniStat(
                          ikon: Icons.water_drop_rounded,
                          baslik: 'Su',
                          deger: _toprak.suTutma,
                        ),
                        const SizedBox(width: 8),
                        _MiniStat(
                          ikon: Icons.air_rounded,
                          baslik: 'Hava',
                          deger: _toprak.havalanma,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: TarimUi.forest,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(TarimUi.radiusMd),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            ToprakDetaySayfasi.routeName,
                            arguments: _toprak,
                          );
                        },
                        child: const Text(
                          'Detaylı bilgileri gör',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const TarimSectionTitle(
                title: 'Önerilen bitkiler',
                icon: Icons.eco_rounded,
              ),
              SizedBox(
                height: 200,
                child: FutureBuilder<List<BitkiModel>>(
                  future: _bitkiFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: TarimUi.leaf),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Bitkiler yüklenirken hata oluştu.'),
                      );
                    }
                    final bitkiler = snapshot.data ?? [];
                    if (bitkiler.isEmpty) {
                      return const TarimEmptyState(
                        icon: Icons.grass_rounded,
                        message: 'Bu toprak için önerilen bitki yok.',
                      );
                    }
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: bitkiler.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final b = bitkiler[index];
                        return SizedBox(
                          width: 152,
                          child: TarimSurfaceCard(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                BitkiDetaySayfasi.routeName,
                                arguments: b,
                              );
                            },
                            padding: EdgeInsets.zero,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(TarimUi.radiusLg),
                                  ),
                                  child: SizedBox(
                                    height: 96,
                                    child: Hero(
                                      tag: 'bitki_img_${b.id}',
                                      child: CachedNetworkImage(
                                        imageUrl: b.resimUrl,
                                        fit: BoxFit.cover,
                                        errorWidget: (_, __, ___) => Container(
                                          color: TarimUi.sage
                                              .withValues(alpha: 0.4),
                                          child: const Icon(
                                            Icons.grass_rounded,
                                            color: TarimUi.forest,
                                          ),
                                        ),
                                        placeholder: (_, __) => Container(
                                          color: TarimUi.cream,
                                          child: const Center(
                                            child: SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: TarimUi.leaf,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        b.ad,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        b.kategori,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w600,
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
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.ikon,
    required this.baslik,
    required this.deger,
  });

  final IconData ikon;
  final String baslik;
  final String deger;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.25),
          ),
        ),
        child: Column(
          children: [
            Icon(ikon, color: Colors.white, size: 18),
            const SizedBox(height: 4),
            Text(
              baslik,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              deger,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
