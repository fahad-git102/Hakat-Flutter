import 'package:hakat/models/whipers_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class WhispersService {
  final _db = FirebaseFirestore.instance;

  Stream<List<WhispersModel>> getWhispers(String uid) {
    return _db.collection('Whispers')
        .where('uid', isEqualTo: uid)
        .snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return WhispersModel.fromDoc(doc);
      }).toList();
    });
  }
  Future<void> deleteWhisper(String whisperId) async {
    await _db.collection("Whispers").doc(whisperId).delete();
  }
}