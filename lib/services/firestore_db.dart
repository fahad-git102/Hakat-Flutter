import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreFunctions{
  Future<bool> uploadWhisper(String title, String description, String date, List<String> cardIds) async {

    try{
      await FirebaseFirestore.instance.collection("Whispers").add({
        'title': title,
        'description': description,
        'date': date,
        'uid': FirebaseAuth.instance.currentUser?.uid,
        'cards': cardIds,
      });
      return true;
    }catch(e){
      debugPrint("Error uploading whisper: $e");
      return false;
    }
  }
}