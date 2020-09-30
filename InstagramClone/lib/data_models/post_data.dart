import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String postID;
  final String uploaderID;
  final String username;
  final String timeStamp;
  final String place;
  final String description;
  final String imageUrl;
  final dynamic Likes;

  Post(
      {this.postID,
      this.uploaderID,
      this.username,
      this.timeStamp,
      this.place,
      this.description,
      this.imageUrl,
      this.Likes});

  factory Post.fromDocument(DocumentSnapshot docSnap) {
    return Post(
      postID: docSnap['postID'],
      uploaderID: docSnap['uploaderID'],
      username: docSnap['username'],
      timeStamp: docSnap['timeStamp'],
      place: docSnap['place'],
      description: docSnap['description'],
      imageUrl: docSnap['imageUrl'],
      Likes: docSnap['Likes'],
    );
  }
}
