import 'package:cloud_firestore/cloud_firestore.dart';

class OracleCard {
  final String? title;
  final List<String>? keywords;
  final String? description;
  final String? shadowWisdom;
  final String? mantra;
  final String? image;
  final String? id;
  final String? group;
  final String? callToIntuition;
  final String? sigilActivation;

  const OracleCard({
    this.title,
    this.group,
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
      group: map.containsKey('group')&& map['group']!=null?map['group'] as String?:null,
      keywords: (map['keywords'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      description: map['description'] as String?,
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
      group: map.containsKey('group')&& map['group']!=null?map['group'] as String?:null,
      keywords: (map['keywords'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      description: map['description'] as String?,
      shadowWisdom: map['shadowWisdom'] as String?,
      mantra: map['mantra'] as String?,
      image: map['image'] as String?,
      callToIntuition: map['callToIntuition'] as String?,
      sigilActivation: map['sigilActivation'] as String?,
    );
  }
}
