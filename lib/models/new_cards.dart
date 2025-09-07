class OracleCard {
  final String? title;
  final List<String>? keywords;
  final String? description;
  final String? shadowWisdom;
  final String? mantra;
  final String? image;
  final String? callToIntuition;
  final String? sigilActivation;

  const OracleCard({
    this.title,
    this.keywords,
    this.description,
    this.shadowWisdom,
    this.mantra,
    this.image,
    this.callToIntuition,
    this.sigilActivation,
  });

  factory OracleCard.fromMap(Map<String, dynamic> map) {
    return OracleCard(
      title: map['title'] as String?,
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
