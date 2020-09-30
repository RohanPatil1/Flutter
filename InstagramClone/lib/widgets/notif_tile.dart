import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luffyvio/screens/home_screen.dart';
import 'package:luffyvio/screens/post_details_screen.dart';
import 'package:luffyvio/screens/profile_screen.dart';
import 'package:timeago/timeago.dart' as tAgo;

class NotificationTile extends StatelessWidget {
  final String username, type, commentData, postID, userID, userImgUrl, url;
  final Timestamp timeStamp;

  const NotificationTile(
      {Key key,
      this.username,
      this.type,
      this.commentData,
      this.postID,
      this.userID,
      this.userImgUrl,
      this.url,
      this.timeStamp})
      : super(key: key);

  factory NotificationTile.fromDocument(DocumentSnapshot doc) {
    return NotificationTile(
        username: doc['username'],
        userID: doc["userID"],
        postID: doc["postID"],
        type: doc["type"],
        userImgUrl: doc["userProfileImg"],
        url: doc["url"],
        timeStamp: doc["timeStamp"],
        commentData: doc["commentData"]);
  }

  @override
  Widget build(BuildContext context) {
    Widget typedMedia = handleType(context);
    String notifMsg = "";
    if (type == "like") notifMsg = ", liked your post!";
    if (type == "comment") notifMsg = ", commented on your post";
    if (type == "follow") notifMsg = ", started following you";

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                userProfileId: userID,
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(userImgUrl),
          ),
          title: RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 17.0),
                children: <TextSpan>[
                  TextSpan(
                      text: username,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "RalewayBold",
                          color: Colors.white)),
                  TextSpan(
                      text: notifMsg,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontFamily: "Lato")),
                ]),
          ),
          subtitle: Text(
            tAgo.format(timeStamp.toDate()),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white, fontSize: 13.0, fontFamily: "Lato"),
          ),
          trailing: typedMedia,
        ),
      ),
    );
  }

  Widget handleType(BuildContext context) {
    if (type == "comment" || type == "like") {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PostDetailScreen(postID: postID, userID: userID),
              ));
        },
        child: Container(
          height: 50.0,
          width: 50.0,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(currUserData.imgUrl),
                      fit: BoxFit.cover)),
            ),
          ),
        ),
      );
    }
    return Container(
      height: 50.0,
      width: 50.0,
      child: Icon(
        Icons.notifications,
        color: Colors.white,
        size: 28.0,
      ),
    );
  }
}
