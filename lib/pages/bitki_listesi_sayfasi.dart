import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/bitki_model.dart';
import '../services/firebase_service.dart';
import '../ui/app_ui.dart';
import 'bitki_detay_sayfasi.dart';

class BitkiListesiSayfasi extends StatefulWidget {
  static const String routeName = '/bitki-listesi';

  const BitkiListesiSayfasi({super.key});

  @override
  State<BitkiListesiSayfasi> createState() => _BitkiListesiSayfasiState();
}

class _BitkiListesiSayfasiState extends State<BitkiListesiSayfasi> {
  late Future<List<BitkiModel>> _future;
  String _seciliKategori = 'tumu';

  final List<Map<String, String>> _kategoriler = const [
    {'id': 'tumu', 'ad': 'Tümü'},
    {'id': 'sebze', 'ad': 'Sebze'},
    {'id': 'meyve', 'ad': 'Meyve'},
    {'id': 'tahil', 'ad': 'Tahıl'},
    {'id': 'agac', 'ad': 'Ağaç'},
  ];

  @override
  void initState() {
    super.initState();
    _future = FirebaseService.instance.getAllBitkiler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TarimGradientAppBar(
        title: 'Bitki Rehberi',
        colors: [
          TarimUi.forest,
          TarimUi.leaf,
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: TarimUi.pageBackground(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TarimSurfaceCard(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                child: SizedBox(
                  height: 44,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    physics: const BouncingScrollPhysics(),
                    itemCount: _kategoriler.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final k = _kategoriler[index];
                      final secili = _seciliKategori == k['id'];
                      return FilterChip(
                        selected: secili,
                        showCheckmark: false,
                        label: Text(k['ad'] ?? ''),
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: secili ? Colors.white : TarimUi.forest,
                        ),
                        selectedColor: TarimUi.leaf,
                        backgroundColor: TarimUi.cream,
                        side: BorderSide(
                          color: secili
                              ? TarimUi.leaf
                              : Colors.grey.shade300,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onSelected: (_) {
                          setState(() => _seciliKategori = k['id']!);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<BitkiModel>>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: TarimUi.leaf),
                    );
                  }
                  if (snapshot.hasError) {
                    return TarimEmptyState(
                      icon: Icons.error_outline_rounded,
                      message: 'Bitkiler yüklenirken hata oluştu.',
                    );
                  }
                  var liste = snapshot.data ?? [];
                  if (_seciliKategori != 'tumu') {
                    liste = liste
                        .where((b) => b.kategori == _seciliKategori)
                        .toList();
                  }
                  if (liste.isEmpty) {
                    return const TarimEmptyState(
                      icon: Icons.search_off_rounded,
                      message: 'Bu kategoride bitki bulunamadı.\nBaşka bir filtre seçin.',
                    );
                  }

                  return RefreshIndicator(
                    color: TarimUi.leaf,
                    onRefresh: () async {
                      setState(() {
                        _future =
                            FirebaseService.instance.getAllBitkiler();
                      });
                      await _future;
                    },
                    child: GridView.builder(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: liste.length,
                    itemBuilder: (context, index) {
                      final b = liste[index];
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius:
                              BorderRadius.circular(TarimUi.radiusLg),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              BitkiDetaySayfasi.routeName,
                              arguments: b,
                            );
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(TarimUi.radiusLg),
                              color: Colors.white.withValues(alpha: 0.95),
                              border: Border.all(
                                color: TarimUi.sage.withValues(alpha: 0.45),
                              ),
                              boxShadow: TarimUi.softShadow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(TarimUi.radiusLg - 1),
                                    ),
                                    child: Hero(
                                      tag: 'bitki_img_${b.id}',
                                      child: CachedNetworkImage(
                                        imageUrl: b.resimUrl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        errorWidget: (_, __, ___) => Container(
                                          color: TarimUi.sage.withValues(
                                              alpha: 0.35),
                                          child: const Icon(
                                            Icons.grass_rounded,
                                            color: TarimUi.forest,
                                            size: 48,
                                          ),
                                        ),
                                        placeholder: (_, __) => Container(
                                          color: TarimUi.cream,
                                          child: const Center(
                                            child: SizedBox(
                                              width: 24,
                                              height: 24,
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
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 8, 10, 10),
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
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: TarimUi.leaf
                                                .withValues(alpha: 0.12),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            b.kategori.toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: TarimUi.forest,
                                              letterSpacing: 0.3,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          'Ekim: ${b.ekimZamani}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                        Text(
                                          'Hasat: ${b.hasatZamani}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey.shade600,
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
                      );
                    },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
