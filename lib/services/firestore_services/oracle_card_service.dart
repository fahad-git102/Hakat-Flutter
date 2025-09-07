import '../../models/new_cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OracleCardService {
  final _db = FirebaseFirestore.instance;

  Stream<List<OracleCard>> getCards() {
    return _db.collection('oracle_cards').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return OracleCard.fromMap(doc.data());
      }).toList();
    });
  }
}