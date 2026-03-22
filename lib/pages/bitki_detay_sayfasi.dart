import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../data/yerel_ornek_veriler.dart';
import '../models/bitki_model.dart';
import '../models/toprak_model.dart';
import '../ui/app_ui.dart';
import 'toprak_detay_sayfasi.dart';

class BitkiDetaySayfasi extends StatelessWidget {
  static const String routeName = '/bitki-detay';

  const BitkiDetaySayfasi({super.key, required this.bitki});

  final BitkiModel bitki;

  static String _kategoriEtiket(String k) {
    switch (k.toLowerCase()) {
      case 'sebze':
        return 'Sebze';
      case 'meyve':
        return 'Meyve';
      case 'tahil':
        return 'Tahıl';
      case 'agac':
        return 'Ağaç';
      default:
        return k.isEmpty ? 'Bitki' : k;
    }
  }

  @override
  Widget build(BuildContext context) {
    final b = bitki;
    final cozulmusTopraklar = b.uygunTopraklar
        .map((id) => YerelOrnekVeriler.toprakById(id))
        .whereType<ToprakModel>()
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F9F4),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            elevation: 0,
            backgroundColor: TarimUi.forest,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 48, bottom: 14, right: 12),
              title: Text(
                b.ad,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  shadows: [
                    Shadow(color: Colors.black45, blurRadius: 8),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'bitki_img_${b.id}',
                    child: CachedNetworkImage(
                      imageUrl: b.resimUrl,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Container(
                        color: TarimUi.mint,
                        child: const Icon(
                          Icons.grass_rounded,
                          color: Colors.white54,
                          size: 80,
                        ),
                      ),
                      placeholder: (_, __) => Container(
                        color: TarimUi.leaf,
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
                          Colors.black.withValues(alpha: 0.1),
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
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              TarimUi.leaf.withValues(alpha: 0.9),
                              TarimUi.mint,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: TarimUi.softShadow,
                        ),
                        child: Text(
                          _kategoriEtiket(b.kategori),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TarimSurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TarimSectionTitle(
                          title: 'Yetişme bilgileri',
                          icon: Icons.calendar_month_rounded,
                        ),
                        _InfoTile(
                          icon: Icons.science_rounded,
                          label: 'pH ihtiyacı',
                          value: b.phIhtiyaci,
                          color: TarimUi.leaf,
                        ),
                        _InfoTile(
                          icon: Icons.water_drop_rounded,
                          label: 'Su ihtiyacı',
                          value: b.suIhtiyaci,
                          color: TarimUi.sky,
                        ),
                        _InfoTile(
                          icon: Icons.agriculture_rounded,
                          label: 'Ekim zamanı',
                          value: b.ekimZamani,
                          color: TarimUi.earth,
                        ),
                        _InfoTile(
                          icon: Icons.inventory_2_rounded,
                          label: 'Hasat zamanı',
                          value: b.hasatZamani,
                          color: Colors.deepOrange.shade700,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  if (b.uygunTopraklar.isNotEmpty) ...[
                    const TarimSectionTitle(
                      title: 'Uygun topraklar',
                      icon: Icons.landscape_rounded,
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ...cozulmusTopraklar.map((t) {
                          return ActionChip(
                            avatar: Icon(
                              Icons.terrain_rounded,
                              size: 18,
                              color: TarimUi.clay,
                            ),
                            label: Text(t.ad),
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                            backgroundColor: Colors.white,
                            side: BorderSide(
                                color: TarimUi.sage.withValues(alpha: 0.6)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                ToprakDetaySayfasi.routeName,
                                arguments: t,
                              );
                            },
                          );
                        }),
                        ...b.uygunTopraklar.where((id) {
                          return YerelOrnekVeriler.toprakById(id) == null;
                        }).map((id) {
                          return Chip(
                            label: Text(
                              id.replaceAll('_', ' '),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            backgroundColor: Colors.grey.shade200,
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Toprak adına dokunarak detay sayfasına gidebilirsiniz.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (b.bakimIpuclari.isNotEmpty) ...[
                    TarimSurfaceCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TarimSectionTitle(
                            title: 'Bakım ipuçları',
                            icon: Icons.lightbulb_outline_rounded,
                          ),
                          ...b.bakimIpuclari.map(
                            (ipuc) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    margin: const EdgeInsets.only(top: 6),
                                    decoration: const BoxDecoration(
                                      color: TarimUi.leaf,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      ipuc,
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1.45,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade600,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
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
