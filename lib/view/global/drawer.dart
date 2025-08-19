//
//
// import 'dart:convert';
//
// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:dss_leden/services/notification_service.dart';
// import 'package:dss_leden/view/global/spacing.dart';
// import 'package:dss_leden/view/pages/auth/tos_page.dart';
// import 'package:fast_cached_network_image/fast_cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../constants/theme/colors.dart';
// import '../../../controllers/user_controller.dart';
// import '../../constants/lang/strings.dart';
// import 'package:http/http.dart' as http;
//
// class NavigationDrawerWidget extends StatelessWidget {
//   final padding = EdgeInsets.symmetric(horizontal: 20);
//
//   var user = Get.find<UserController>().userModel ;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Material(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             AddHeight(40),
//             buildHeader(
//               name: user?.name ?? "",
//               email: user?.email ?? "",
//               onClicked: (){},
//             ),
//             Container(
//               padding: padding,
//               child: Column(
//                 children: [
//                   // if(true ?? false)buildMenuItemIcon(
//                   //   text: 'Mentor',
//                   //   icon: CupertinoIcons.person_circle,
//                   //   onClicked: () => selectedItem(context, 7),
//                   // ),
//                   buildMenuItemIcon(
//                     text: "Programma",
//                     icon:  CupertinoIcons.square_list,
//                     onClicked: () => selectedItem(context, 0),
//                   ),
//                   buildMenuItemIcon(
//                     text: AppString.sideBarAboutUs.tr,
//                     icon:  CupertinoIcons.info_circle,
//                     onClicked: () => selectedItem(context, 1),
//                   ),
//                   buildMenuItemIcon(
//                     text: AppString.sideBarContactUs.tr,
//                     icon:  CupertinoIcons.phone_circle,
//                     onClicked: () => selectedItem(context, 2),
//                   ),
//                   buildMenuItemIcon(
//                     text: AppString.sideBarLogout.tr,
//                     icon:  Icons.logout,
//                     onClicked: () => selectedItem(context, 3),
//                   ),
//                 ],
//               ),
//             ),
//             Spacer(),
//             InkWell(
//               onTap: (){
//                 print("Running");
//                 NotificationService().sendNotificationToIndividual(user!.id!, "Test", "Test", "test");
//               },
//               child: Container(
//                   width: 200,
//                   child: const  Text("Developed By Clix-Media",style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,)),
//             ),
//             const  Text("All Rights Reserved @2024",style: TextStyle(color: Colors.black),),
//             AddHeight(20),
//
//           ],
//         ),
//       ),);
//   }
//
//
//   Widget buildHeader({
//     required String name,
//     required String email,
//     required VoidCallback onClicked,
//   }) =>
//       InkWell(
//         onTap: onClicked,
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 40),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(67),
//                 child: Container(
//                     width: 98,
//                     height: 98,
//                     decoration:  BoxDecoration(
//                         color: Colors.black,
//                         shape: BoxShape.circle,
//                         border: Border.all(width: 1, color: Colors.white)
//                     ),
//                     child:
//                     Center(
//                       child:
//                       user?.profileURL == null ?
//                       Text(getInitials(user?.name ?? "N/A"),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Colors.white70),)
//                       : FastCachedImage(url: user!.profileURL!,fit: BoxFit.cover,) ,
//                     )
//                 ),
//               ) ,
//               AddHeight(20),
//               Text(name,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
//             ],
//           ),
//         ),
//       );
//
//   Widget buildMenuItem({
//     required String text,
//     required String icon,
//     VoidCallback? onClicked,
//   }) {
//     final color = AppColor.greyColor;
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12.0),
//       child: InkWell(
//         onTap: onClicked,
//         child: Row(
//           children: [
//             SvgPicture.asset(icon,color: AppColor.blackColor,width: 18,height: 18,),
//             AddWidth(20),
//             Text(text, style: TextStyle(color: color,fontWeight: FontWeight.w500,fontSize: 16)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildMenuItemIcon({
//     required String text,
//     required IconData icon,
//     VoidCallback? onClicked,
//   }) {
//     final color = AppColor.greyColor;
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12.0),
//       child: InkWell(
//         onTap: onClicked,
//         child: Row(
//           children: [
//             Icon(icon,size: 18,color: color,),
//             AddWidth(20),
//             Text(text, style: TextStyle(color: AppColor.greyColor,fontWeight: FontWeight.w500,fontSize: 16)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildMenuItemIconSvg({
//     required String text,
//     required IconData icon,
//     VoidCallback? onClicked,
//   }) {
//     final color = AppColor.greyColor;
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12.0),
//       child: InkWell(
//         onTap: onClicked,
//         child: Row(
//           children: [
//             Icon(icon,size: 18,color: AppColor.blackColor,),
//             AddWidth(20),
//             Text(text, style: TextStyle(color: color,fontWeight: FontWeight.w500,fontSize: 16)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void selectedItem(BuildContext context, int index) {
//     Navigator.of(context).pop();
//
//     switch (index) {
//       case 0:
//         openLinkInChrome("https://dssvoetbal.nl/app-programma");
//         break;
//       case 1:
//         openLinkInChrome("https://dssvoetbal.nl/over-dss");
//         break;
//       case 2:
//         openLinkInChrome("https://dssvoetbal.nl/contact#personen");
//         break;
//       case 3:
//         Get.find<UserController>().signOut() ;
//         break;
//     }
//   }
//
//
//   Future<void> _createUser() async {
//     // try {
//     //   HttpsCallable callable =
//     //   FirebaseFunctions.instance.httpsCallable('createUserWithEmailAndPassword');
//     //   final response = await callable.call(<String, dynamic>{
//     //     'email': "zainan@gmail.com",
//     //     'password': "test1234",
//     //   });
//     //   print('User created successfully: ${response.data['uid']}');
//     // } catch (e) {
//     //   print('Error creating user: $e');
//     // }
//
//     // try {
//     //   final response = await http.post(
//     //     Uri.parse('https://us-central1-dss-leden-app-58e2a.cloudfunctions.net/createUserWithEmailAndPassword'),
//     //     //headers: {'Content-Type': 'application/json'},
//     //     body: json.encode({
//     //            'email': "zainan@gmail.com",
//     //            'password': "test1234",
//     //     }),
//     //   );
//     //
//     //   if (response.statusCode == 200) {
//     //     // User created successfully
//     //     print('User created successfully');
//     //   } else {
//     //     // Error occurred
//     //     print('Error creating user: ${response.body}');
//     //   }
//     // } catch (e) {
//     //   print('Exception: $e');
//     // }
//
//     final functions = FirebaseFunctions.instance;
//
//     // Pass the ID token as a header in the function call
//     final result = functions.httpsCallable("createUserWithEmailAndPassword").call({
//       'email': "zainan@gmail.com",
//       'password': "test1234",
//     });
//
//   }
//
//
//   // Future<void> createUserCopy(String email, String password) async {
//   //
//   //   final functions = FirebaseFunctions.instance;
//   //
//   //   final result = await functions.call('createUserWithEmailAndPassword', {
//   //     'email': email,
//   //     'password': password,
//   //   });
//   //
//   //   if (result.data != null) {
//   //     print('User created successfully');
//   //   } else {
//   //     print('Error creating user: ${result.error}');
//   //   }
//   // }
//
//   shareLink(){
//   }
//
//
//   getInitials(String bankAccountName) => bankAccountName.isNotEmpty
//       ? bankAccountName.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
//       : '';
//
//   Future<void> openLinkInChrome(String url) async {
//     Get.to(()=>WebViewPage(link: url, title: ""));
//     // if (await canLaunchUrl(Uri.parse(url))) {
//     //   await launchUrl(
//     //     Uri.parse(url),
//     //     mode: LaunchMode.platformDefault,
//     //   );
//     // } else {
//     //   throw 'Could not launch $url';
//     // }
//   }
//
// }
//
//
