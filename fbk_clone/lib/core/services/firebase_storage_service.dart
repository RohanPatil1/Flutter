import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbk_clone/core/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../locator.dart';

class FirebaseStorageService {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final userCollectionRef = Firestore.instance.collection("users");
  final timelineCollectionRef = Firestore.instance.collection("timeline");
  final AuthService _authService = locator<AuthService>();
  final firebase_storage.Reference storageReference =
      firebase_storage.FirebaseStorage.instance.ref().child("Posts Images");

  Future<String> uploadImage(File img, String postID) async {
    // try {
    //   await firebase_storage.FirebaseStorage.instance
    //       .ref().child("Posts_Images")
    //       .child("post_$postID.jpg")
    //       .putFile(img);
    // } on firebase_core.FirebaseException catch (e) {
    //   // e.g, e.code == 'canceled'
    // }

    firebase_storage.UploadTask storageUploadTask =
        storageReference.child("post_$postID.jpg").putFile(img);

    firebase_storage.TaskSnapshot taskSnapshot =
        await storageUploadTask.whenComplete(() {});
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    print("FILE UPLOADED : "+downloadUrl);
    return downloadUrl;
  }
}
