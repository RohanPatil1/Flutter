import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String fullName;

  final String imgUrl;
  final String email;

  User({
    this.id,
    this.fullName,
    this.imgUrl,
    this.email,
  });

  factory User.fromDocument(DocumentSnapshot docSnap) {
    return User(
        id: docSnap.documentID,
        email: docSnap['email'],
        imgUrl: docSnap['imgUrl'],
        fullName: docSnap['fullName']);
  }
}
