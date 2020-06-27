import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:ivypodstask/db_helper/db_helper.dart';

class Utils {
  fetchPosts() async {
    List<Map<String, dynamic>> postList;
    print("FETCHING POSTS QUERY");
    postList = await DatabaseHelper.instance.queryPosts();
    return postList;
  }

  uploadImage(File image) async {
    var timeKey = DateTime.now();

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child("posts")
        .child(timeKey.toString() + "image1.jpg");

    StorageUploadTask uploadTask = storageReference.putFile(image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    int i = await DatabaseHelper.instance.insertPost({
      DatabaseHelper.columnImgUrl: downloadUrl,
      DatabaseHelper.columnLike: "false",
    });
    print("INSERTED : " + i.toString());
    List<Map<String, dynamic>> postListD;

    postListD = await DatabaseHelper.instance.queryPosts();
    return postListD;
  }
}
