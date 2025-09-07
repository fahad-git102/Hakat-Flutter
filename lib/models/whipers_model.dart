class WhispersModel {
  final String? date;
  final String? description;
  final String? title;
  final String? uid;
  final List<String>? cards;

  WhispersModel({
    this.date,
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
