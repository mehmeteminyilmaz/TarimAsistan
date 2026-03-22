import 'package:flutter/material.dart';

import '../ui/app_ui.dart';
import 'bitki_listesi_sayfasi.dart';
import 'foto_tarama_sayfasi.dart';
import 'toprak_listesi_sayfasi.dart';

class AnaSayfa extends StatefulWidget {
  static const String routeName = '/';

  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final pad = MediaQuery.paddingOf(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: TarimUi.heroGreen,
              ),
            ),
          ),
          Positioned(
            top: -size.width * 0.15,
            right: -size.width * 0.2,
            child: _GlowBlob(
              diameter: size.width * 0.65,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          Positioned(
            bottom: size.height * 0.35,
            left: -size.width * 0.25,
            child: _GlowBlob(
              diameter: size.width * 0.5,
              color: TarimUi.sage.withValues(alpha: 0.12),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: TarimUi.softShadow,
                        ),
                        child: const Icon(
                          Icons.eco_rounded,
                          color: TarimUi.leaf,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tarım Asistan',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.5,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Toprağını tanı, verimini artır',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.88),
                                fontSize: 14,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              children: [
                                _HeroChip(
                                  icon: Icons.auto_awesome_rounded,
                                  label: 'Akıllı analiz',
                                ),
                                _HeroChip(
                                  icon: Icons.spa_rounded,
                                  label: 'Bitki önerileri',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: pad.top > 20 ? 16 : 20),
                  Text(
                    'Ne yapmak istersin?',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _FeatureTile(
                          gradient: const [
                            Color(0xFF8D6E63),
                            Color(0xFF5D4037),
                          ],
                          icon: Icons.terrain_rounded,
                          title: 'Toprak Türleri',
                          subtitle:
                              'pH, su tutma ve havalanma — tek dokunuşla keşfet.',
                          badge: 'Rehber',
                          onTap: () => Navigator.pushNamed(
                            context,
                            ToprakListesiSayfasi.routeName,
                          ),
                        ),
                        const SizedBox(height: 14),
                        _FeatureTile(
                          gradient: const [
                            Color(0xFF1976D2),
                            Color(0xFF0D47A1),
                          ],
                          icon: Icons.photo_camera_rounded,
                          title: 'Fotoğrafla Tanı',
                          subtitle:
                              'Toprağının fotoğrafını çek; yapay zeka ile tahmin al.',
                          badge: 'AI',
                          onTap: () => Navigator.pushNamed(
                            context,
                            FotoTaramaSayfasi.routeName,
                          ),
                        ),
                        const SizedBox(height: 14),
                        _FeatureTile(
                          gradient: const [
                            Color(0xFF2E7D32),
                            Color(0xFF1B5E20),
                          ],
                          icon: Icons.grass_rounded,
                          title: 'Bitki Rehberi',
                          subtitle:
                              'Hangi toprakta hangi ürün — filtrele ve planla.',
                          badge: 'Liste',
                          onTap: () => Navigator.pushNamed(
                            context,
                            BitkiListesiSayfasi.routeName,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
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

class _GlowBlob extends StatelessWidget {
  const _GlowBlob({required this.diameter, required this.color});

  final double diameter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: Colors.white.withValues(alpha: 0.95)),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.95),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({
    required this.gradient,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.onTap,
  });

  final List<Color> gradient;
  final IconData icon;
  final String title;
  final String subtitle;
  final String badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(TarimUi.radiusXl),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(TarimUi.radiusXl),
            color: Colors.white.withValues(alpha: 0.97),
            boxShadow: TarimUi.softShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: gradient,
                    ),
                    boxShadow: TarimUi.glowShadow(gradient.last),
                  ),
                  child: Icon(icon, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.3,
                                color: Color(0xFF1B1B1B),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: gradient),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              badge,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.35,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
