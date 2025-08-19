//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';
//
// import '../controllers/user_controller.dart';
// import '../models/user_model.dart';
//
// class UserDatabase{
//
//   var userRef =  FirebaseFirestore.instance.collection("users");
//
//
//   DocumentReference userPath(String userID){
//     return userRef.doc(userID);
//   }
//
//   DocumentReference userAddressPath(String userID,String addressID){
//     return userRef.doc(userID).collection("Addresses").doc(addressID);
//   }
//
//   Future<bool> createUser(UserModel user) async {
//     print("running");
//     try{
//       await userRef.doc(user.id).set(user.toMap());
//       return true ;
//     }
//     catch(e){
//       print(e);
//       Get.snackbar("error", e.toString(),snackPosition: SnackPosition.BOTTOM ) ;
//       return false ;
//     }
//   }
//
//   Future<List<UserModel>> getAllUsers() async{
//     try {
//
//       var ref =  await userRef.where("restricted", isEqualTo: false).get();
//       return ref.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
//
//     } catch (e) {
//       print(e);
//       rethrow;
//     }
//   }
//
//
//
//   static Future<bool> checkUserExist(String docID) async {
//     bool exists = false;
//     try {
//       await FirebaseFirestore.instance.doc("Users/$docID").get().then((doc) {
//         if (!doc.exists)
//           exists = false;
//         else
//           exists = true;
//       });
//       return exists;
//     } catch (e) {
//       return false;
//     }
//   }
//
//   Future<UserModel?> checkUserExistsByNumber(String number) async {
//     UserModel? user ;
//     try {
//       await
//       FirebaseFirestore.instance.collection("Users")
//           .where("phone", isEqualTo: number)
//       // .where("restricted", isEqualTo: false)
//           .get()
//           .then((doc) {
//         if (doc.docs.isNotEmpty){
//           user = UserModel.fromFirestore(doc.docs.first) ;
//           print(user?.id);
//         }
//       });
//       return user ;
//     } catch (e) {
//       print(e);
//     }
//   }
//
//
//
//
//   Future<void> updateUserProfilePhoto(String id,String photoURL)async {
//     try{
//       await userRef.doc(id).update({
//         "profileURL": photoURL ,
//       });
//     }
//     catch(e){
//       print(e);
//       Get.snackbar("error", e.toString(),snackPosition: SnackPosition.BOTTOM ) ;
//     }
//   }
//
//   Future<void> updateInfo(String uid,String name,String number)async {
//     try{
//       await userRef.doc(uid).update({
//         "phone": number ,
//         "name" :name,
//       });
//     }
//     catch(e){
//       print(e);
//       Get.snackbar("error", e.toString(),snackPosition: SnackPosition.BOTTOM ) ;
//     }
//   }
//
//   Future<bool> updateCreatorField(String id) async {
//
//     try{
//       await userRef.doc(id).update({
//         "isCreator": true ,
//       });
//       return true ;
//     }
//     catch(e){
//       print(e);
//       Get.snackbar("error", e.toString(),snackPosition: SnackPosition.BOTTOM ) ;
//       return false ;
//     }
//
//   }
//
//   Future<UserModel>  getUser (String id) async {
//     try{
//       DocumentSnapshot doc = await userRef.doc(id).get();
//       return UserModel.fromFirestore(doc) ;
//     }
//     catch(e){
//       print(e);
//       Get.snackbar("error", e.toString(),snackPosition: SnackPosition.BOTTOM ) ;
//       rethrow ;
//     }
//   }
//
//   deleteToken()async{
//     var userId = Get.find<UserController>().userModel!.id ;
//     String? token = await FirebaseMessaging.instance.getToken();
//     userRef.doc(userId).collection("Tokens").doc(token).delete() ;
//   }
//
//
//
// }