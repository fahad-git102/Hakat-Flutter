import 'package:cloud_firestore/cloud_firestore.dart';

class WhispersModel {
  final String? date;
  final String? description;
  final String? title;
  final String? id;
  final String? uid;
  final List<String>? cards;

  WhispersModel({
    this.date,
    this.id,
    this.description,
    this.title,
    this.uid,
    this.cards,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'description': description,
      'title': title,
      'uid': uid,
      'cards': cards,
    };
  }

  factory WhispersModel.fromDoc(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return WhispersModel(
      id: doc.id, // 👈 capture the doc id here
      date: map['date'] as String?,
      description: map['description'] as String?,
      title: map['title'] as String?,
      uid: map['uid'] as String?,
      cards: map['cards'] != null ? List<String>.from(map['cards']) : null,
    );
  }

  factory WhispersModel.fromMap(Map<String, dynamic> map) {
    return WhispersModel(
      date: map['date'] != null ? map['date'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      cards: map['cards'] != null
          ? List<String>.from(map['cards'] as List)
          : null,
    );
  }
}
