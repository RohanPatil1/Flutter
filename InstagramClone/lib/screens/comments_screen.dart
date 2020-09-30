import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luffyvio/screens/home_screen.dart';
import 'package:luffyvio/widgets/custom_appbar.dart';
import 'package:timeago/timeago.dart' as TimeAgo;

class CommentsScreen extends StatefulWidget {
  final postID, uploaderID, imgUrl;

  const CommentsScreen({this.postID, this.uploaderID, this.imgUrl});

  @override
  CommentsScreenState createState() => CommentsScreenState(
      postID: postID, uploaderID: uploaderID, imgUrl: imgUrl);
}

class CommentsScreenState extends State<CommentsScreen> {
  final postID, uploaderID, imgUrl;

  CommentsScreenState({this.postID, this.uploaderID, this.imgUrl});

  TextEditingController comEditingCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(context, "Comments"),
      body: Column(
        children: [
          Expanded(
            child: showComments(),
          ),
          Divider(),
          ListTile(
            title: TextFormField(
              controller: comEditingCtrl,
              decoration: InputDecoration(
                labelText: "Write your comment here...",
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
              ),
            ),
            trailing: OutlineButton(
              borderSide: BorderSide.none,
              onPressed: () => postComment(),
              child: Text(
                "Post",
                style: TextStyle(
                    color: Colors.blueAccent, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  showComments() {
    return StreamBuilder(
      stream: commentsCollectionRef
          .document(postID)
          .collection("comments")
          .orderBy("timeStamp", descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Comment> commentsDataList = [];
        snapshot.data.documents.forEach((doc) {
          commentsDataList.add(Comment.fromDocument(doc));
        });

        print("=======TESTING================");
        print(commentsDataList);
        return ListView(
          shrinkWrap: true,
          children: commentsDataList,
        );
      },
    );
  }

  postComment() {
    final timestamp = DateTime.now();
    commentsCollectionRef.document(postID).collection("comments").add({
      "username": currUserData.userName,
      "userID": currUserData.id,
      "imgUrl": imgUrl,
      "comment": comEditingCtrl.text,
      "timeStamp": timestamp,
    });

    bool isPostUploader = uploaderID == currUserData.id;
    if (!isPostUploader) {
      feedCollectionRef.document(uploaderID).collection("feedItems").add({
        "type": "comment",
        "commentData": comEditingCtrl.text,
        "postID": postID,
        "userID": currUserData.id,
        "username": currUserData.userName,
        "userImgUrl": currUserData.imgUrl,
        "url": imgUrl,
        'timeStamp': DateTime.now()
      });
    }
    comEditingCtrl.clear();
  }
}

class Comment extends StatelessWidget {
  final String username, userID, imgUrl, comment;
  final Timestamp timeStamp;

  const Comment(
      {Key key,
      this.username,
      this.userID,
      this.imgUrl,
      this.comment,
      this.timeStamp})
      : super(key: key);

  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      username: doc["username"],
      userID: doc["userID"],
      imgUrl: doc['imgUrl'],
      comment: doc['comment'],
      timeStamp: doc['timestamp'],
    );
  }

  @override
  Widget build(BuildContext context) {
    String timee;
    // timee = TimeAgo.format(timeStamp.);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            ListTile(
              title: Text(
                username + ":   " + comment,
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(imgUrl),
              ),
              subtitle: Text(
                "a minute ago",
                style: TextStyle(color: Colors.grey, fontSize: 12.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
