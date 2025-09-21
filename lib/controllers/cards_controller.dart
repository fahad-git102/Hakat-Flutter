import 'package:get/get.dart';

import '../models/new_cards.dart';
import '../services/firestore_services/oracle_card_service.dart';

class CardsController extends GetxController{
  final OracleCardService _service = OracleCardService();
  RxString selectedGroup = "INNER CIRCLE".obs;
  RxList<OracleCard> cards = <OracleCard>[].obs;

  @override
  void onInit() {
    super.onInit();
    cards.bindStream(_service.getCards());
  }

  List<OracleCard> get filteredCards {
    if (selectedGroup.value.isEmpty) return cards;
    return cards.where((card) => card.group == selectedGroup.value).toList();
  }
}