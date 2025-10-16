import 'package:cloud_firestore/cloud_firestore.dart';

class OracleCard {
  final String? title;
  final List<String>? keywords;
  final String? description;
  final String? shadowWisdom;
  final String? mantra;
  final String? image;
  final String? id;
  final String? credits;
  final String? group;
  final String? sigilUrl;
  final String? callToIntuition;
  final String? sigilActivation;

  const OracleCard({
    this.title,
    this.group,
    this.credits,
    this.sigilUrl,
    this.id,
    this.keywords,
    this.description,
    this.shadowWisdom,
    this.mantra,
    this.image,
    this.callToIntuition,
    this.sigilActivation,
  });

  factory OracleCard.fromDoc(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return OracleCard(
      id: doc.id,
      title: map['title'] as String?,
      group: map.containsKey('group') && map['group'] != null
          ? map['group'] as String?
          : null,
      keywords: (map['keywords'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      description: map['description'] as String?,
      sigilUrl: map.containsKey('sigil_url') && map['sigil_url'] != null
          ? map['sigil_url'] as String?
          : null,
      credits: map['credits'] as String?,
      shadowWisdom: map['shadowWisdom'] as String?,
      mantra: map['mantra'] as String?,
      image: map['image'] as String?,
      callToIntuition: map['callToIntuition'] as String?,
      sigilActivation: map['sigilActivation'] as String?,
    );
  }

  factory OracleCard.fromMap(Map<String, dynamic> map) {
    return OracleCard(
      title: map['title'] as String?,
      group: map.containsKey('group') && map['group'] != null
          ? map['group'] as String?
          : null,
      keywords: (map['keywords'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      description: map['description'] as String?,
      sigilUrl: map.containsKey('sigil_url') && map['sigil_url'] != null
          ? map['sigil_url'] as String?
          : null,
      credits: map['credits'] as String?,
      shadowWisdom: map['shadowWisdom'] as String?,
      mantra: map['mantra'] as String?,
      image: map['image'] as String?,
      callToIntuition: map['callToIntuition'] as String?,
      sigilActivation: map['sigilActivation'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'group': group,
      'credits': credits,
      'keywords': keywords,
      'description': description,
      'sigil_url': sigilUrl,
      'shadowWisdom': shadowWisdom,
      'mantra': mantra,
      'image': image,
      'callToIntuition': callToIntuition,
      'sigilActivation': sigilActivation,
    };
  }
}
