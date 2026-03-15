import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/toprak_model.dart';
import '../services/firebase_service.dart';
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
      appBar: AppBar(
        title: const Text('Toprak Türleri'),
        backgroundColor: Colors.brown,
      ),
      body: FutureBuilder<List<ToprakModel>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 40,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Veriler alınırken bir hata oluştu.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _future = FirebaseService.instance.getToprakTurleri();
                        });
                      },
                      child: const Text('Tekrar dene'),
                    ),
                  ],
                ),
              ),
            );
          }

          final liste = snapshot.data ?? [];
          if (liste.isEmpty) {
            return const Center(
              child: Text('Henüz toprak türü eklenmemiş.'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: liste.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final t = liste[index];
              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ToprakDetaySayfasi.routeName,
                      arguments: t,
                    );
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: CachedNetworkImage(
                        imageUrl: t.resimUrl,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => Container(
                          color: Colors.brown.shade100,
                          child: const Icon(
                            Icons.terrain,
                            color: Colors.brown,
                          ),
                        ),
                        placeholder: (_, __) => Container(
                          color: Colors.brown.shade50,
                          child: const Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    t.ad,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Renk: ${t.renk}'),
                      Text('pH: ${t.phAralik}'),
                    ],
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

