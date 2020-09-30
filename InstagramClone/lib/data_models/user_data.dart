import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String fullName;
  final String userName;
  final String imgUrl;
  final String email;
  final String bio;

  User(
      {this.id,
      this.fullName,
      this.userName,
      this.imgUrl,
      this.email,
      this.bio});

  factory User.fromDocument(DocumentSnapshot docSnap) {
    return User(
        id: docSnap.documentID,
        email: docSnap['email'],
        imgUrl: docSnap['imgUrl'],
        fullName: docSnap['fullName'],
        userName: docSnap['userName'],
        bio: docSnap['bio']);
  }
}
