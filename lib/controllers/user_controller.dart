//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dss_leden/models/post_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import '../models/user_model.dart';
// import '../services/auth_service.dart';
// import '../services/user_database.dart';
//
// class UserController extends GetxController {
//
//   final Rxn<UserModel> _userModel = Rxn<UserModel>() ;
//   UserModel? get userModel => _userModel.value ;
//   set setUserModel(UserModel user) => _userModel.value = user ;
//
//   PostModel? postModel ;
//
//
//   UserModel? selectedUser ;
//
//   bool isAdmin = false ;
//   bool isSuperAdmin = false ;
//
//   @override
//   void onInit() {
//
//     super.onInit();
//   }
//
//   void clear(){_userModel.value = null;}
//
//   getCurrentUser(String id) async {
//     _userModel.value = await UserDatabase().getUser(id);
//   }
//
//   void signOut()async{
//     UserDatabase().deleteToken();
//
//     Get.offAll(()=>AuthWrapper());
//     await FirebaseAuth.instance.signOut();
//     _userModel.value = null ;
//   }
//
//   deleteUser(id)async{
//     await FirebaseFirestore.instance.collection('Users').doc(id).delete();
//   }
//
//
//   void updateUserProfilePhoto(String profileURL){
//     _userModel.update((val) {
//       val!.profileURL = profileURL;
//     });
//   }
//
//   void updateUserProfile(String name,String bio,String? profileURL){
//     try {
//       _userModel.update((val) {
//         val?.name = name;
//         val?.bio = bio;
//         val?.profileURL = profileURL;
//
//       });
//     }catch(e){
//       print(e);
//     }
//   }
//
//   Future<bool> blockUser(String blocked) async{
//
//
//     final List<String> list1 = [blocked];
//
//     try{
//       await FirebaseFirestore.instance.collection("Users")
//           .doc(_userModel.value!.id) // <-- Document ID
//           .update({'blockedUsers': FieldValue.arrayUnion(list1)});// <-- Add data
//       Get.snackbar("Blocked", "You will no longer see this users content");
//
//       return true ;
//     }
//     catch(e){
//       print(e);
//       Get.snackbar("error", e.toString(),snackPosition: SnackPosition.BOTTOM ) ;
//       return false ;
//     }
//   }
//
//   Future<bool> unBlockUser(String blocked) async{
//
//     final List<String> list1 = [blocked];
//
//     try{
//       await FirebaseFirestore.instance.collection("Users")
//           .doc(_userModel.value!.id) // <-- Document ID
//           .update({'blockedUsers': FieldValue.arrayRemove(list1)});// <-- Add data
//       Get.snackbar("Success", "User Was Unblocked");
//       return true;
//     }
//     catch(e){
//       print(e);
//       Get.snackbar("error", e.toString(),snackPosition: SnackPosition.BOTTOM ) ;
//       return false ;
//     }
//   }
//
//   checkSuperAdmin(){
//
//
//
//
//   }
//
//   static Future<bool> checkUserExist(String docID) async {
//     bool exists = false;
//     try {
//       await FirebaseFirestore.instance.doc("users/$docID").get().then((doc) {
//         if (doc.exists)
//           exists = true;
//         else
//           exists = false;
//       });
//       return exists;
//     } catch (e) {
//       return false;
//     }
//   }
//
//
//   static Future<bool> checkSuperAdminExist(String email) async {
//     bool exists = false;
//     try {
//       await FirebaseFirestore.instance.doc("admin/$email").get().then((doc) {
//         if (doc.exists)
//           exists = true;
//         else
//           exists = false;
//       });
//       return exists;
//     } catch (e) {
//       return false;
//     }
//   }
//
//
//
//
// }

import 'dart:async';

import 'package:get/get.dart';
import 'package:hakat/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hakat/view/pages/auth/login_page.dart';

import '../view/pages/subscription/subscription_page.dart';

class UserController extends GetxController {
  var currentUser = Rxn<UsersModel>();
  StreamSubscription<DocumentSnapshot>? _userSub;

  @override
  void onInit() {
    super.onInit();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        currentUser.value = null;
        _userSub?.cancel();
      } else {
        _userSub = FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .snapshots()
            .listen((snapshot) {
          if (snapshot.exists) {
            currentUser.value = UsersModel.fromFirestore(snapshot.data()!);
          }
        });
      }
    });
  }

  @override
  void onClose() {
    _userSub?.cancel();
    super.onClose();
  }

  void setUser(UsersModel user) {
    currentUser.value = user;
  }

  void clearUser() {
    currentUser.value = null;
  }
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      _userSub?.cancel();
      currentUser.value = null;
      Get.offAll(() => LoginPage());
    } catch (e) {
      print("Error during sign out: $e");
      Get.snackbar("Error", "Failed to log out");
    }
  }

  Future<void> updateUserSubscription({
    required String uid,
    required bool isSubscribed,
    required SubscriptionType subscribedPlan,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'isSubscribed': isSubscribed,
        'subscribedPlan': subscribedPlan.name,
      });
      print("✅ User subscription updated successfully");
    } catch (e) {
      print("❌ Failed to update user subscription: $e");
    }
  }

}
