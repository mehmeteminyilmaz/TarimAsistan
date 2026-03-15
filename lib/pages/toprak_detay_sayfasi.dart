import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/bitki_model.dart';
import '../models/toprak_model.dart';
import '../services/firebase_service.dart';

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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: Colors.brown,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(t.ad),
              background: CachedNetworkImage(
                imageUrl: t.resimUrl,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => Container(
                  color: Colors.brown.shade200,
                  child: const Center(
                    child: Icon(
                      Icons.terrain,
                      color: Colors.white,
                      size: 64,
                    ),
                  ),
                ),
                placeholder: (_, __) => Container(
                  color: Colors.brown.shade100,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Temel Özellikler',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _ozellikSatiri(
                            ikon: Icons.palette,
                            baslik: 'Renk',
                            deger: t.renk,
                          ),
                          _ozellikSatiri(
                            ikon: Icons.science,
                            baslik: 'pH Aralığı',
                            deger: t.phAralik,
                          ),
                          _ozellikSatiri(
                            ikon: Icons.water_drop,
                            baslik: 'Su Tutma',
                            deger: t.suTutma,
                          ),
                          _ozellikSatiri(
                            ikon: Icons.air,
                            baslik: 'Havalanma',
                            deger: t.havalanma,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    t.ozellikler,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Avantajlar',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                ...t.avantajlar.map(
                                  (a) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.check,
                                          size: 16,
                                          color: Colors.green,
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            a,
                                            style:
                                                const TextStyle(fontSize: 13),
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
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      color: Colors.orange,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Dezavantajlar',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                ...t.dezavantajlar.map(
                                  (d) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.check,
                                          size: 16,
                                          color: Colors.orange,
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            d,
                                            style:
                                                const TextStyle(fontSize: 13),
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Bu toprakta yetişen bitkiler',
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final b = bitkiler[index];
                            return SizedBox(
                              width: 140,
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
                                          errorWidget: (_, __, ___) =>
                                              Container(
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
                                                child:
                                                    CircularProgressIndicator(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            'Kategori: ${b.kategori}',
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
          ),
        ],
      ),
    );
  }

  Widget _ozellikSatiri({
    required IconData ikon,
    required String baslik,
    required String deger,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            ikon,
            size: 20,
            color: Colors.brown,
          ),
          const SizedBox(width: 8),
          Text(
            '$baslik: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(deger),
          ),
        ],
      ),
    );
  }
}

