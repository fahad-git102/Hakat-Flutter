import 'dart:convert';

import '../../models/new_cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OracleCardService {
  final _db = FirebaseFirestore.instance;
  var json;

  Stream<List<OracleCard>> getCards() {
    return _db.collection('oracle_cards').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return OracleCard.fromDoc(doc);
      }).toList();
    });
  }

  Future<String> getCardsJson() async {
    final snapshot = await FirebaseFirestore.instance.collection('oracle_cards').get();

    final List<Map<String, dynamic>> data = snapshot.docs.map((doc) {
      return OracleCard.fromDoc(doc).toJson();
    }).toList();

    json = jsonEncode(data);
    print(json);
    return json;
  }


}