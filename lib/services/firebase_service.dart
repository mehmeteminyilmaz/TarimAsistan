import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/bitki_model.dart';
import '../models/toprak_model.dart';

class FirebaseService {
  FirebaseService._();

  static final FirebaseService instance = FirebaseService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ToprakModel>> getToprakTurleri() async {
    try {
      final snapshot = await _firestore.collection('toprak_turleri').get();
      return snapshot.docs
          .map(
            (d) => ToprakModel.fromMap(d.id, d.data()),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<ToprakModel?> getToprakDetay(String id) async {
    try {
      final doc = await _firestore.collection('toprak_turleri').doc(id).get();
      if (!doc.exists) return null;
      return ToprakModel.fromMap(doc.id, doc.data() ?? {});
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BitkiModel>> getUygunBitkiler(String toprakId) async {
    try {
      final snapshot = await _firestore
          .collection('bitkiler')
          .where('uygun_topraklar', arrayContains: toprakId)
          .get();
      return snapshot.docs
          .map(
            (d) => BitkiModel.fromMap(d.id, d.data()),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BitkiModel>> getAllBitkiler() async {
    try {
      final snapshot = await _firestore.collection('bitkiler').get();
      return snapshot.docs
          .map(
            (d) => BitkiModel.fromMap(d.id, d.data()),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}

