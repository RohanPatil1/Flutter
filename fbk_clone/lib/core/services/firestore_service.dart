import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbk_clone/core/models/post_model.dart';
import 'package:fbk_clone/core/models/user.dart';

import 'package:flutter/material.dart';

import '../../locator.dart';

class FirestoreService {
  final userCollectionRef = Firestore.instance.collection("users");
  final timelineCollectionRef = Firestore.instance.collection("timeline");
  final postsCollectionRef = Firestore.instance.collection("posts");

  Future getAllPost(String uid) async {
    List<Post> postDataList = [];
    QuerySnapshot postsSnapshot = await timelineCollectionRef
        .document(uid)
        .collection("timeLinePosts")
        .orderBy("timeStamp", descending: true)
        .getDocuments();

    postDataList =
        postsSnapshot.documents.map((doc) => Post.fromDocument(doc)).toList();
    print(postDataList);
    return postDataList;
  }

  //Store User Data in Firebase
  Future storeUser(UserData user) async {
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

  Future storePostData(
      UserData currUser, String downloadUrl, String caption, String postID) {
    final timeStamp = DateTime.now();

    postsCollectionRef
        .document(currUser.id)
        .collection("userPosts")
        .document(postID)
        .setData({
      "postID": postID,
      "uploaderID": currUser.id,
      "name": currUser.fullName,
      "timeStamp": timeStamp,
      "Likes": {},
      "caption": caption,
      "imageUrl": downloadUrl
    });
    timelineCollectionRef
        .document(currUser.id)
        .collection("timeLinePosts")
        .document(postID)
        .setData({
      "postID": postID,
      "uploaderID": currUser.id,
      "name": currUser.fullName,
      "timeStamp": timeStamp,
      "Likes": {},
      "caption": caption,
      "imageUrl": downloadUrl
    });
  }

  Future getUser(String uid) async {
    try {
      var userData = await userCollectionRef.document(uid).get();
      return UserData.fromDocument(userData);
    } catch (e) {
      return e.message;
    }
  }
}
