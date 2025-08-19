// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dss_leden/view/pages/auth/welcome_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/auth_controller.dart';
// import '../controllers/user_controller.dart';
// import '../models/user_model.dart';
// import '../view/pages/auth/login.dart';
// import '../view/global/primary_button.dart';
// import '../view/pages/root/root_page.dart';
//
// class AuthWrapper extends GetWidget<AuthController> {
//   @override
//   Widget build(BuildContext context) {
//     return GetX<AuthController>(
//       builder: (AuthController controller) {
//         var user = controller.user;
//         if (user == null) {
//           return WelcomePage();
//         } else {
//           print("Running Twice"+ user.uid);
//           return GetUser(user.uid);
//         }
//       },
//     );
//   }
// }
//
// class GetUser extends StatelessWidget {
//   final String userID;
//
//   const GetUser(this.userID, {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<DocumentSnapshot>(
//           future:
//           FirebaseFirestore.instance.collection('users').doc(userID).get(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: SizedBox(
//                   height: 50,
//                   width: 50,
//                   child: CupertinoActivityIndicator(
//                     color: Colors.blue,
//                   ),
//                 ),
//               );
//             }
//             else if (snapshot.hasData) {
//
//               if(snapshot.data != null && snapshot.data!.data() != null )
//               {
//                 UserModel user = UserModel.fromFirestore(snapshot.data!);
//                   var controller = Get.find<UserController>() ;
//                   controller.setUserModel = user ;
//                   controller.selectedUser = user;
//                   print(user.email);
//
//                   return RootPage();
//
//               }
//               else
//               {
//                 return Scaffold(body: Column(
//                   children: [
//                     PrimaryButton(title: "Logout", onPressed: (){
//                       FirebaseAuth.instance.signOut();
//                      // Get.to(()=>AuthWrapper());
//                     }),
//                     Container(color: Colors.grey,),
//                   ],
//                 ));
//               }
//             }
//             else {
//               print(snapshot.error);
//               return Scaffold(body: Column(
//                 children: [
//                   PrimaryButton(title: "Logout", onPressed: (){
//                     FirebaseAuth.instance.signOut();
//                     // Get.to(()=>AuthWrapper());
//                   }),
//                   Container(color: Colors.grey,),
//                 ],
//               ));
//             }
//           }),
//     );
//   }
//
//
//
// }
