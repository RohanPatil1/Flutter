import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String id;
  final String fullName;

  final String imgUrl;
  final String email;

  UserData({
    this.id,
    this.fullName,
    this.imgUrl,
    this.email,
  });

  factory UserData.fromDocument(DocumentSnapshot docSnap) {
    return UserData(
        id: docSnap.documentID,
        email: docSnap['email'],
        imgUrl: docSnap['imgUrl'],
        fullName: docSnap['fullName']);
  }
}
