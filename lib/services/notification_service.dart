// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:dss_leden/controllers/chat_controllers/search_controller.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:uuid/uuid.dart';
//
// import '../controllers/auth_controller.dart';
//
// class NotificationService extends GetxController {
//
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   FirebaseMessaging _fcm = FirebaseMessaging.instance;
//   AuthController _controller = Get.find<AuthController>() ;
//
//   var notRef = FirebaseFirestore.instance.collection("notifications") ;
//
//
//   @override
//   void onInit() {
//
//     initialize() ;
//     super.onInit();
//   }
//
//   Future initialize() async{
//
//     if (Platform.isIOS) {
//       requestPermission();
//     }
//     await saveTokenToFirestore();
//
//     // workaround for onLaunch: When the app is completely closed (not in the background) and opened directly from the push notification
//
//     // onMessage: When the app is open and it receives a push notification
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
//       print("onMessage data: ${message.data}");
//       Get.snackbar(message.data["title"],message.data["body"]);
//
//       print("onMessage: $message");
//       print("onMessageOpenedApp: $message");
//
//       // await AwesomeNotifications().createNotification(
//       //   content: NotificationContent(
//       //     id: -1,
//       //     channelKey: 'high_importance_channel',
//       //     title: message.data["title"],
//       //     body: message.data["body"],
//       //     actionType: ActionType.Default,
//       //   )
//       // );
//
//
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       print("onMessage: $message");
//       print("onMessageOpenedApp: $message");
//
//
//       Get.snackbar(message.data["title"],message.data["body"]);
//
//       if (message.data["page"] != null) {
//         print(message.data["page"]);
//         String page = message.data["page"];
//         Get.toNamed(page);
//       }
//     }
//     );
//
//    // await _initializeLocalNotifications() ;
//
//   }
//
//
//   sendNotificationToIndividual(String id,String title,String body,String page) async {
//
//
//
//     try {
//       HttpsCallable callable = FirebaseFunctions.instance
//           .httpsCallable('sendNotificationToIndividual');
//
//       List<String> tokens = [];
//       QuerySnapshot doc = await _firestore.collection("users")
//           .doc(id)
//           .collection("tokens")
//           .get();
//       for (int i = 0; i < doc.size; i++) {
//         tokens.add(doc.docs[i].id);
//
//
//       final results = await callable.call(<String, dynamic>{
//         'dataUid': Uuid().v4(),
//         'message': body,
//         'title': title,
//         'tokens': [doc.docs[i].id],
//         'page': page,
//
//       });
//       print(results.data);
//     }
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }
//
//   sendNotificationToList(List<SearchUser> chatusers,String title,String body,String page) async {
//     List<String> ids = [] ;
//     for(int i = 0 ; i < chatusers.length ; i++){
//         ids.add(chatusers[i].id);
//     }
//
//     print(page);
//     List<String> tokens = [];
//     await Future.wait(List.generate(
//         ids.length,
//             (index) => _firestore
//             .collection('users')
//             .doc(ids[index]).collection("tokens")
//             .get()
//             .then((value) {
//           for(int i=0 ; i<value.size;i++){
//             tokens.add(value.docs[i].id);
//           }
//         })));
//     try {
//       HttpsCallable callable =
//       FirebaseFunctions.instance.httpsCallable('sendNotificationToList');
//       final results = await callable.call(<String, dynamic>{
//         'dataUid': Uuid().v4(),
//         'message': body,
//         'title': title,
//         'tokens':tokens,
//         'page':page,
//       });
//       return results.data;
//     } on Exception catch (e) {
//       print(e);
//       return false;
//     }
//   }
//
//   sendNotificationToListIDs(List<String> ids,String title,String body,String page) async {
//
//     print(page);
//     List<String> tokens = [];
//     await Future.wait(List.generate(
//         ids.length,
//             (index) => _firestore
//             .collection('users')
//             .doc(ids[index]).collection("tokens")
//             .get()
//             .then((value) {
//           for(int i=0 ; i<value.size;i++){
//             tokens.add(value.docs[i].id);
//           }
//         })));
//     try {
//       HttpsCallable callable =
//       FirebaseFunctions.instance.httpsCallable('sendNotificationToList');
//       final results = await callable.call(<String, dynamic>{
//         'dataUid': Uuid().v4(),
//         'message': body,
//         'title': title,
//         'tokens':tokens,
//         'page':page,
//       });
//       return results.data;
//     } on Exception catch (e) {
//       print(e);
//       return false;
//     }
//   }
//
//
//
//   saveTokenToFirestore() async{
//     var token = await _fcm.getToken();
//     _firestore.collection("users").doc(_controller.user!.uid).collection("tokens").doc(token).set({
//       "token":token,
//       "platform":Platform.isIOS ? "iOS" : "Android",
//       "createdAt": FieldValue.serverTimestamp(),
//     });
//   }
//
//
//   Future<bool> requestPermission() async {
//     NotificationSettings settings = await _fcm.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true, // Required to display a heads up notification
//       badge: true,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('Permission Granted');
//       return true;
//     } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//       print('Provisional Permission Granted');
//       return true;
//     } else {
//       print('Permission Declined');
//       return false;
//     }
//   }
//
//
// }