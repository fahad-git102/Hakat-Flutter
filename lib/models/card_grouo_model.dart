import 'new_cards.dart';

class CardGroupModel {
  final String title;
  String group;

  CardGroupModel({
    required this.title,
    this.group = "",
  });
}

List<CardGroupModel> convertToCardGroupModels(List<OracleCard> oracleCards) {
  return oracleCards
      .map((card) => CardGroupModel(
    title: card.title ?? "",
    group: "",
  ))
      .toList();
}
