import 'package:flutter/material.dart';

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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade400,
            Colors.green.shade800,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.agriculture,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Tarım Asistan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Toprağını tanı, verimini artır',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: size.width * 0.9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _AnaMenuKart(
                            renk: Colors.brown.shade400,
                            ikon: Icons.terrain,
                            baslik: 'Toprak Türleri',
                            aciklama:
                                'Toprak türlerini inceleyin, pH ve özelliklerini görün.',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ToprakListesiSayfasi.routeName);
                            },
                          ),
                          const SizedBox(height: 16),
                          _AnaMenuKart(
                            renk: Colors.blue.shade500,
                            ikon: Icons.camera_alt,
                            baslik: 'Fotoğrafla Tanı',
                            aciklama:
                                'Toprağınızın fotoğrafını çekerek analiz edin.',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, FotoTaramaSayfasi.routeName);
                            },
                          ),
                          const SizedBox(height: 16),
                          _AnaMenuKart(
                            renk: Colors.green.shade600,
                            ikon: Icons.grass,
                            baslik: 'Bitki Rehberi',
                            aciklama:
                                'Hangi toprakta hangi bitkiler yetişir keşfedin.',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, BitkiListesiSayfasi.routeName);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnaMenuKart extends StatelessWidget {
  final Color renk;
  final IconData ikon;
  final String baslik;
  final String aciklama;
  final VoidCallback onTap;

  const _AnaMenuKart({
    required this.renk,
    required this.ikon,
    required this.baslik,
    required this.aciklama,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: renk.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  ikon,
                  color: renk,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      baslik,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      aciklama,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

