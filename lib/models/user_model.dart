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

import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  String? uid, email, name, signInMethod;
  bool? isSubscribed;
  DateTime? createdAt;
  String? subscribedPlan;

  UsersModel({
    this.uid,
    this.email,
    this.name,
    this.createdAt,
    this.signInMethod,
    this.isSubscribed,
    this.subscribedPlan,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'email': this.email,
      'name': this.name,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'signInMethod': this.signInMethod,
      'isSubscribed': this.isSubscribed,
      'subscribedPlan': this.subscribedPlan,
    };
  }

  factory UsersModel.fromFirestore(Map<String, dynamic> map) {
    return UsersModel(
      uid: map.containsKey('uid') && map['uid'] != null
          ? map['uid'] as String
          : null,
      email: map.containsKey('email') && map['email'] != null
          ? map['email'] as String
          : null,
      name: map.containsKey('name') && map['name'] != null
          ? map['name'] as String
          : null,
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
      signInMethod:
          map.containsKey('signInMethod') && map['signInMethod'] != null
          ? map['signInMethod'] as String
          : null,
      isSubscribed:
          map.containsKey('isSubscribed') && map['isSubscribed'] != null
          ? map['isSubscribed'] as bool
          : false,
      subscribedPlan:
          map.containsKey('subscribedPlan') && map['subscribedPlan'] != null
          ? map['subscribedPlan'] as String
          : null,
    );
  }
}
