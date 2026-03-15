import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/bitki_model.dart';
import '../services/firebase_service.dart';

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
      appBar: AppBar(
        title: const Text('Bitki Rehberi'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 56,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final k = _kategoriler[index];
                final secili = _seciliKategori == k['id'];
                return ChoiceChip(
                  label: Text(k['ad'] ?? ''),
                  selected: secili,
                  selectedColor: Colors.green,
                  labelStyle: TextStyle(
                    color: secili ? Colors.white : Colors.black,
                  ),
                  onSelected: (_) {
                    setState(() {
                      _seciliKategori = k['id']!;
                    });
                  },
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemCount: _kategoriler.length,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<BitkiModel>>(
              future: _future,
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
                var liste = snapshot.data ?? [];
                if (_seciliKategori != 'tumu') {
                  liste = liste
                      .where(
                        (b) => b.kategori == _seciliKategori,
                      )
                      .toList();
                }
                if (liste.isEmpty) {
                  return const Center(
                    child: Text('Seçili kategori için bitki bulunamadı.'),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: liste.length,
                  itemBuilder: (context, index) {
                    final b = liste[index];
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: SizedBox(
                              height: 110,
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
                                      width: 20,
                                      height: 20,
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
                                const SizedBox(height: 8),
                                Text(
                                  'Ekim: ${b.ekimZamani}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Hasat: ${b.hasatZamani}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

