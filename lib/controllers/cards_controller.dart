import 'package:get/get.dart';

import '../models/new_cards.dart';
import '../services/firestore_services/oracle_card_service.dart';

class CardsController extends GetxController{
  final OracleCardService _service = OracleCardService();

  RxList<OracleCard> cards = <OracleCard>[].obs;

  @override
  void onInit() {
    super.onInit();
    cards.bindStream(_service.getCards());
  }
}