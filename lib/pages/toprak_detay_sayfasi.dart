import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/bitki_model.dart';
import '../models/toprak_model.dart';
import '../services/firebase_service.dart';
import '../ui/app_ui.dart';

class ToprakDetaySayfasi extends StatefulWidget {
  static const String routeName = '/toprak-detay';

  final ToprakModel toprak;

  const ToprakDetaySayfasi({
    super.key,
    required this.toprak,
  });

  @override
  State<ToprakDetaySayfasi> createState() => _ToprakDetaySayfasiState();
}

class _ToprakDetaySayfasiState extends State<ToprakDetaySayfasi> {
  late Future<List<BitkiModel>> _bitkiFuture;

  @override
  void initState() {
    super.initState();
    _bitkiFuture =
        FirebaseService.instance.getUygunBitkiler(widget.toprak.id);
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.toprak;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F9F4),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            elevation: 0,
            backgroundColor: TarimUi.clay,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 48, bottom: 14, right: 12),
              title: Text(
                t.ad,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'toprak_thumb_${t.id}',
                    child: CachedNetworkImage(
                      imageUrl: t.resimUrl,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Container(
                        color: TarimUi.clay,
                        child: const Icon(
                          Icons.terrain_rounded,
                          color: Colors.white54,
                          size: 80,
                        ),
                      ),
                      placeholder: (_, __) => Container(
                        color: const Color(0xFF8D6E63),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white54,
                          ),
                        ),
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.15),
                          Colors.black.withValues(alpha: 0.55),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TarimSurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TarimSectionTitle(
                          title: 'Temel özellikler',
                          icon: Icons.analytics_rounded,
                        ),
                        _OzellikSatiri(
                          ikon: Icons.palette_rounded,
                          baslik: 'Renk',
                          deger: t.renk,
                          renk: TarimUi.clay,
                        ),
                        _OzellikSatiri(
                          ikon: Icons.science_rounded,
                          baslik: 'pH aralığı',
                          deger: t.phAralik,
                          renk: TarimUi.leaf,
                        ),
                        _OzellikSatiri(
                          ikon: Icons.water_drop_rounded,
                          baslik: 'Su tutma',
                          deger: t.suTutma,
                          renk: TarimUi.sky,
                        ),
                        _OzellikSatiri(
                          ikon: Icons.air_rounded,
                          baslik: 'Havalanma',
                          deger: t.havalanma,
                          renk: Colors.teal.shade700,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  TarimSurfaceCard(
                    child: Text(
                      t.ozellikler,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TarimSurfaceCard(
                          borderColor: Colors.green.shade100,
                          child: _ListeKutu(
                            baslik: 'Avantajlar',
                            baslikIcon: Icons.check_circle_rounded,
                            baslikColor: Colors.green.shade700,
                            satirIcon: Icons.check_rounded,
                            satirColor: Colors.green.shade600,
                            maddeler: t.avantajlar,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TarimSurfaceCard(
                          borderColor: Colors.orange.shade100,
                          child: _ListeKutu(
                            baslik: 'Dikkat',
                            baslikIcon: Icons.warning_amber_rounded,
                            baslikColor: Colors.orange.shade800,
                            satirIcon: Icons.remove_rounded,
                            satirColor: Colors.orange.shade700,
                            maddeler: t.dezavantajlar,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const TarimSectionTitle(
                    title: 'Bu toprakta yetişen bitkiler',
                    icon: Icons.local_florist_rounded,
                  ),
                  SizedBox(
                    height: 200,
                    child: FutureBuilder<List<BitkiModel>>(
                      future: _bitkiFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: TarimUi.leaf,
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Bitkiler yüklenirken hata oluştu.'),
                          );
                        }
                        final bitkiler = snapshot.data ?? [];
                        if (bitkiler.isEmpty) {
                          return TarimEmptyState(
                            icon: Icons.grass_rounded,
                            message: 'Bu toprak için örnek bitki yok.',
                          );
                        }
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: bitkiler.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final b = bitkiler[index];
                            return SizedBox(
                              width: 148,
                              child: TarimSurfaceCard(
                                padding: EdgeInsets.zero,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(TarimUi.radiusLg),
                                      ),
                                      child: SizedBox(
                                        height: 96,
                                        child: CachedNetworkImage(
                                          imageUrl: b.resimUrl,
                                          fit: BoxFit.cover,
                                          errorWidget: (_, __, ___) =>
                                              Container(
                                            color: TarimUi.sage
                                                .withValues(alpha: 0.4),
                                            child: const Icon(
                                              Icons.grass_rounded,
                                              color: TarimUi.forest,
                                              size: 40,
                                            ),
                                          ),
                                          placeholder: (_, __) => Container(
                                            color: TarimUi.cream,
                                            child: const Center(
                                              child: SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: TarimUi.leaf,
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
                                              fontSize: 13,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OzellikSatiri extends StatelessWidget {
  const _OzellikSatiri({
    required this.ikon,
    required this.baslik,
    required this.deger,
    required this.renk,
  });

  final IconData ikon;
  final String baslik;
  final String deger;
  final Color renk;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: renk.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(ikon, size: 20, color: renk),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  baslik,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade600,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  deger,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ListeKutu extends StatelessWidget {
  const _ListeKutu({
    required this.baslik,
    required this.baslikIcon,
    required this.baslikColor,
    required this.satirIcon,
    required this.satirColor,
    required this.maddeler,
  });

  final String baslik;
  final IconData baslikIcon;
  final Color baslikColor;
  final IconData satirIcon;
  final Color satirColor;
  final List<String> maddeler;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(baslikIcon, color: baslikColor, size: 20),
            const SizedBox(width: 6),
            Text(
              baslik,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: baslikColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...maddeler.map(
          (a) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(satirIcon, size: 16, color: satirColor),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    a,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.35,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
