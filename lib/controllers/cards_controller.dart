import 'dart:math';
import 'package:get/get.dart';
import '../models/new_cards.dart';
import '../services/firestore_services/oracle_card_service.dart';
import 'chaos_controller.dart';

class CardsController extends GetxController {
  final OracleCardService _service = OracleCardService();
  final chaosController = Get.find<ChaosController>();

  RxString selectedGroup = "INNER CIRCLE".obs;
  RxList<OracleCard> allCards = <OracleCard>[].obs;
  RxList<OracleCard> cards = <OracleCard>[].obs;
  Rx<OracleCard?> jokerCard = Rx<OracleCard?>(null);

  @override
  void onInit() {
    super.onInit();
    allCards.bindStream(_service.getCards());
    everAll([allCards, chaosController.chaosActive], (_) {
      _applyChaosFilter();
    });
  }

  void _applyChaosFilter() {
    // if (chaosController.chaosActive.value) {
    //   cards.value = List.from(allCards);
    // } else {
    jokerCard.value = allCards.firstWhereOrNull(
      (c) => c.id == 'IKhXMSAyFWfRmkdsetHh',
    );
    cards.value = allCards
        .where((c) => c.id != 'IKhXMSAyFWfRmkdsetHh')
        .toList();
    // }
  }

  List<OracleCard> get filteredCards {
    if (selectedGroup.value.isEmpty) return cards;
    return cards.where((card) => card.group == selectedGroup.value).toList();
  }

  void shuffleCards() {
    cards.shuffle(Random());
    update();
  }
}
