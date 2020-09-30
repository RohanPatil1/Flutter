import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luffyvio/screens/home_screen.dart';
import 'package:luffyvio/widgets/post_card.dart';

class PostDetailScreen extends StatelessWidget {
  final postID, userID;

  const PostDetailScreen({this.postID, this.userID});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postsCollectionRef
          .document(userID)
          .collection("userPosts")
          .document(postID)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        PostCard postCard = PostCard.fromDocument(snapshot.data);
        return Center(
          child: Scaffold(
            body: ListView(
              children: [
                Container(
                  child: postCard,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
