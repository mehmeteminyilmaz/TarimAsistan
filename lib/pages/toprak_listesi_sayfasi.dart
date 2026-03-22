import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/toprak_model.dart';
import '../services/firebase_service.dart';
import '../ui/app_ui.dart';
import 'toprak_detay_sayfasi.dart';

class ToprakListesiSayfasi extends StatefulWidget {
  static const String routeName = '/toprak-listesi';

  const ToprakListesiSayfasi({super.key});

  @override
  State<ToprakListesiSayfasi> createState() => _ToprakListesiSayfasiState();
}

class _ToprakListesiSayfasiState extends State<ToprakListesiSayfasi> {
  late Future<List<ToprakModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = FirebaseService.instance.getToprakTurleri();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: const TarimGradientAppBar(
        title: 'Toprak Türleri',
        colors: [
          Color(0xFF6D4C41),
          Color(0xFF5D4037),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: TarimUi.pageBackground(),
        child: FutureBuilder<List<ToprakModel>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: TarimUi.leaf,
                ),
              );
            }
            if (snapshot.hasError) {
              return TarimEmptyState(
                icon: Icons.cloud_off_rounded,
                message: 'Veriler alınırken bir sorun oluştu.\nİnternetinizi kontrol edip tekrar deneyin.',
                action: FilledButton.icon(
                  onPressed: () {
                    setState(() {
                      _future = FirebaseService.instance.getToprakTurleri();
                    });
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: TarimUi.forest,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(TarimUi.radiusMd),
                    ),
                  ),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Tekrar dene'),
                ),
              );
            }

            final liste = snapshot.data ?? [];
            if (liste.isEmpty) {
              return const TarimEmptyState(
                icon: Icons.landscape_rounded,
                message: 'Henüz toprak türü eklenmemiş.',
              );
            }

            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              itemCount: liste.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final t = liste[index];
                return TarimSurfaceCard(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ToprakDetaySayfasi.routeName,
                      arguments: t,
                    );
                  },
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Hero(
                        tag: 'toprak_thumb_${t.id}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(TarimUi.radiusMd),
                          child: SizedBox(
                            width: 88,
                            height: 88,
                            child: CachedNetworkImage(
                              imageUrl: t.resimUrl,
                              fit: BoxFit.cover,
                              errorWidget: (_, __, ___) => Container(
                                color: const Color(0xFFD7CCC8),
                                child: const Icon(
                                  Icons.terrain_rounded,
                                  color: TarimUi.clay,
                                  size: 40,
                                ),
                              ),
                              placeholder: (_, __) => Container(
                                color: const Color(0xFFEFEBE9),
                                child: const Center(
                                  child: SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: TarimUi.clay,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.ad,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(height: 6),
                            _InfoLine(
                              icon: Icons.palette_rounded,
                              text: t.renk,
                              color: TarimUi.clay,
                            ),
                            const SizedBox(height: 4),
                            _InfoLine(
                              icon: Icons.science_rounded,
                              text: 'pH ${t.phAralik}',
                              color: TarimUi.leaf,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.grey.shade400,
                        size: 28,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    required this.icon,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              height: 1.25,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ],
    );
  }
}
