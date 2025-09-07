import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:hakat/models/user_model.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../controllers/user_controller.dart';

class Auth{

  static String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Future<bool> signInWithApple(BuildContext context) async {
    User? user;
    EasyLoading.show();

    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    AuthorizationCredentialAppleID? appleCredential;
    try {
      appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
    } catch (e) {
      EasyLoading.dismiss();
    }

    if (appleCredential != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (appleCredential.email != null) {
        pref.setString("user_email", appleCredential.email??'');
        pref.setString("user_name", '${appleCredential.givenName} ${appleCredential.familyName}');
      }
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
        accessToken: appleCredential.authorizationCode,
      );

      try{
        user =
            (await FirebaseAuth.instance.signInWithCredential(oauthCredential)).user;
        if (user != null) {
          final userDoc =
          FirebaseFirestore.instance.collection("users").doc(user.uid);

          final docSnapshot = await userDoc.get();
          if (!docSnapshot.exists) {
            await userDoc.set({
              "uid": user.uid,
              "email": user.email ?? appleCredential.email ?? "",
              "name": user.displayName ??
                  '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}'.trim(),
              "createdAt": FieldValue.serverTimestamp(),
              "signInMethod": "apple",
              "isSubscribed": false
            });
            final userData = (await userDoc.get()).data()!;
            final appUser = UsersModel.fromFirestore(userData);
            Get.find<UserController>().setUser(appUser);
          }
        }

        print("Signed in as: ${user?.email}");
        print(user?.email);
      }catch(exception){
        print('error found : ${exception.toString()}');
        Get.snackbar('Error', exception.toString());
      }

      EasyLoading.dismiss();
      return true;
    }else{
      EasyLoading.dismiss();
      return false;
    }
  }
}