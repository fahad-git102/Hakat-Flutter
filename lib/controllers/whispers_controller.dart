import 'package:get/get.dart';
import 'package:hakat/models/whipers_model.dart';
import 'package:hakat/services/firestore_services/whispers_service.dart';

class WhispersController extends GetxController{
  final WhispersService _service = WhispersService();

  RxList<WhispersModel> myWhispers = <WhispersModel>[].obs;

  getWhispers(String uid){
    myWhispers.bindStream(_service.getWhispers(uid));
  }
}