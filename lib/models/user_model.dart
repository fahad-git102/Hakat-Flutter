// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class UserModel {
//
//   String? id;
//   String name;
//   DateTime createdAt;
//   String email;
//   String? profileURL;
//   String? bio;
//   bool admin;
//   String teamname ;
//
//   DateTime modifiedAt;
//   bool verified ;
//   bool restricted ;
//
//
//   UserModel({
//     this.id,
//     required this.name,
//     required this.createdAt,
//     required this.email,
//     this.profileURL,
//     required this.teamname,
//     required this.modifiedAt,
//     required this.verified,
//     required this.restricted,
//     required this.admin
//
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       "display_name": name,
//       "email": email,
//       "created_time": createdAt,
//       "photo_url": profileURL,
//       "modifiedAt": modifiedAt,
//       "verified":verified,
//       "restricted":restricted,
//       "admin":admin,
//
//     };
//   }
//
//   factory UserModel.fromFirestore(DocumentSnapshot snapshot) {
//
//     Map data = snapshot.data() as Map;
//     return UserModel(
//       id: snapshot.id,
//       name: data["display_name"] ?? "",
//       email: data["email"] ??"",
//       createdAt: data["created_time"].toDate(),
//       modifiedAt: DateTime.now(),
//       profileURL: data["photo_url"] ?? "",
//       admin: data["admin"] ?? false,
//       teamname: data['teamname'] ?? "DSS",
//       verified: data["verified"] ?? false,
//       restricted: data["restricted"] ?? false,
//    //   blockedUsers:(data["blockedUsers"]==null) ? [] : (data["blockedUsers"] as List).map((item) => item as String).toList(),
//
//     );
//   }
// }
