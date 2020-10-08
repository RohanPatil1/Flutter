import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbk_clone/core/models/user.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  final userCollectionRef = Firestore.instance.collection("users");


  //Store User Data in Firebase
  Future storeUser(User user) async {
    DocumentSnapshot documentSnapshot =
        await userCollectionRef.document(user.id).get();
    if (!documentSnapshot.exists) {
      final timeStamp = DateTime.now();
      userCollectionRef.document(user.id).setData({
        "id": user.id,
        "fullName": user.fullName,
        "imgUrl": user.imgUrl,
        "email": user.email,
        "timeStamp": timeStamp
      });
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await userCollectionRef.document(uid).get();
      return User.fromDocument(userData);
    } catch (e) {
      return e.message;
    }
  }
}
