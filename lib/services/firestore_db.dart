import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreFunctions{
  Future<bool> uploadWhisper(String title, String description, String date) async {

    try{
      await FirebaseFirestore.instance.collection("Whispers").add({
        'title': title,
        'description': description,
        'date': date,
      });
      return true;
    }catch(e){
      debugPrint("Error uploading whisper: $e");
      return false;
    }
  }
}