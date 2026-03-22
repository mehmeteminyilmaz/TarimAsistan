import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../data/yerel_ornek_veriler.dart';
import '../models/bitki_model.dart';
import '../models/toprak_model.dart';

class FirebaseService {
  FirebaseService._();

  static final FirebaseService instance = FirebaseService._();

  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  bool get _firebaseHazir {
    try {
      return Firebase.apps.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<List<ToprakModel>> getToprakTurleri() async {
    if (!_firebaseHazir) {
      return List<ToprakModel>.from(YerelOrnekVeriler.topraklar);
    }
    try {
      final snapshot = await _firestore.collection('toprak_turleri').get();
      if (snapshot.docs.isEmpty) {
        return List<ToprakModel>.from(YerelOrnekVeriler.topraklar);
      }
      return snapshot.docs
          .map((d) => ToprakModel.fromMap(d.id, d.data()))
          .toList();
    } catch (_) {
      return List<ToprakModel>.from(YerelOrnekVeriler.topraklar);
    }
  }

  Future<ToprakModel?> getToprakDetay(String id) async {
    if (!_firebaseHazir) {
      return YerelOrnekVeriler.toprakById(id);
    }
    try {
      final doc =
          await _firestore.collection('toprak_turleri').doc(id).get();
      if (!doc.exists) {
        return YerelOrnekVeriler.toprakById(id);
      }
      return ToprakModel.fromMap(doc.id, doc.data() ?? {});
    } catch (_) {
      return YerelOrnekVeriler.toprakById(id);
    }
  }

  Future<List<BitkiModel>> getUygunBitkiler(String toprakId) async {
    if (!_firebaseHazir) {
      return YerelOrnekVeriler.bitkilerByToprak(toprakId);
    }
    try {
      final snapshot = await _firestore
          .collection('bitkiler')
          .where('uygun_topraklar', arrayContains: toprakId)
          .get();
      if (snapshot.docs.isEmpty) {
        return YerelOrnekVeriler.bitkilerByToprak(toprakId);
      }
      return snapshot.docs
          .map((d) => BitkiModel.fromMap(d.id, d.data()))
          .toList();
    } catch (_) {
      return YerelOrnekVeriler.bitkilerByToprak(toprakId);
    }
  }

  Future<List<BitkiModel>> getAllBitkiler() async {
    if (!_firebaseHazir) {
      return List<BitkiModel>.from(YerelOrnekVeriler.bitkiler);
    }
    try {
      final snapshot = await _firestore.collection('bitkiler').get();
      if (snapshot.docs.isEmpty) {
        return List<BitkiModel>.from(YerelOrnekVeriler.bitkiler);
      }
      return snapshot.docs
          .map((d) => BitkiModel.fromMap(d.id, d.data()))
          .toList();
    } catch (_) {
      return List<BitkiModel>.from(YerelOrnekVeriler.bitkiler);
    }
  }
}
