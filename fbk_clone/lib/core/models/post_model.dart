import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'models.dart';

class Post {
  final String caption;
  final String timeStamp;
  final String imageUrl;
  final String uploaderImgUrl;
  final String uploaderName;
  final int likes;
  final int comments;
  final int shares;
  final String uploaderID;
  final String postID;


  const Post( {
    this.uploaderImgUrl, this.uploaderName,
    this.uploaderID,
    this.postID,
    this.caption,
    this.timeStamp,
    this.imageUrl,
    this.likes,
    this.comments,
    this.shares,
  });

  factory Post.fromDocument(DocumentSnapshot docSnap) {
    return Post(
      uploaderID: docSnap['uploaderID'],
      uploaderImgUrl: docSnap['uploaderImgUrl'],
      uploaderName: docSnap['uploaderName'],
      postID: docSnap['postID'],
      caption: docSnap['caption'],
      timeStamp: docSnap['timeStamp'],
      imageUrl: docSnap['imageUrl'],
      likes: docSnap['likes'],
      comments: docSnap['comments'],
      shares: docSnap['shares'],
    );
  }
}
