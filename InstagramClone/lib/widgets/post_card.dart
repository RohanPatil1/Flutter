import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luffyvio/config/palette.dart';
import 'package:luffyvio/data_models/post_data.dart';
import 'package:luffyvio/data_models/user_data.dart';
import 'package:luffyvio/screens/comments_screen.dart';
import 'package:luffyvio/screens/home_screen.dart';
import 'package:luffyvio/screens/profile_screen.dart';

class PostCard extends StatefulWidget {
  final String postID;
  final String uploaderID;
  final String username;

  final String place;
  final String description;
  final String imageUrl;
  final dynamic Likes;

  PostCard(
      {this.postID,
      this.uploaderID,
      this.username,
      this.place,
      this.description,
      this.imageUrl,
      this.Likes});

  factory PostCard.fromDocument(DocumentSnapshot docSnap) {
    return PostCard(
      postID: docSnap['postID'],
      uploaderID: docSnap['uploaderID'],
      username: docSnap['username'],
      place: docSnap['place'],
      description: docSnap['description'],
      imageUrl: docSnap['imageUrl'],
      Likes: docSnap['Likes'],
    );
  }

  int getLikes(dynamic likes) {
    if (likes == null) {
      return 0;
    }
    int counter = 0;
    likes.values.forEach((value) {
      if (value == true) {
        counter++;
      }
    });

    return counter;
  }

  @override
  _PostCardState createState() => _PostCardState(
        postID: this.postID,
        uploaderID: this.uploaderID,
        username: this.username,
        place: this.place,
        description: this.description,
        imageUrl: this.imageUrl,
        Likes: this.Likes,
        likeCount: getLikes(this.Likes),
      );
}

class _PostCardState extends State<PostCard> {
  final String postID;
  final String uploaderID;
  final String username;

  final String place;
  final String description;
  final String imageUrl;
  Map Likes;
  int likeCount;
  bool isLiked;
  bool showHeart = false;

  _PostCardState(
      {this.postID,
      this.uploaderID,
      this.username,
      this.place,
      this.description,
      this.imageUrl,
      this.Likes,
      this.likeCount});

  final String currentOnlineUserId = currUserData?.id;

  @override
  Widget build(BuildContext context) {
    //initial Like Status
    isLiked = (Likes[currentOnlineUserId] == true);
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    /*


     */

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        constraints: BoxConstraints(
            minHeight: deviceHeight - 200.0,
            maxHeight: deviceHeight - 100,
            maxWidth: deviceWidth - 20),
        decoration: BoxDecoration(
            color: Colors.red,
            image: DecorationImage(
                image: AssetImage("assets/images/op_card_final.png"),
                fit: BoxFit.fill)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [postHeader(), postImgContent(), postFooter()],
        ),
      ),
    );
  }

  Widget postFooter() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.0,
                width: 20.0,
              ),
              GestureDetector(
                onTap: () => handleLikePost(),
                child: Icon(
                  !isLiked ? Icons.favorite_border : Icons.favorite,
                  color: isLiked ? Colors.pink : Palette.darkBrown,
                  size: 28.0,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: () => showComment(context, postID, uploaderID, imageUrl),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Image.asset(
                    "assets/images/comment.png",
                    width: 30.0,
                    height: 30.0,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Text(
                  " $likeCount likes",
                  style: TextStyle(
                      fontFamily: "Xchrome",
                      color: Palette.darkBrown,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20.0,top: 4.0),
                child: Text(
                  "$username",
                  style: TextStyle(
                      fontFamily: "HemiHead",
                      color: Palette.darkBrown,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top:5.0),
                  child: Text(
                    " " + description,
                    style: TextStyle(
                        fontFamily: "Raleway",
                        color: Palette.darkBrown,
                        fontSize: 12.0),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  addLikeFeed() {
    final timestamp = DateTime.now();
    bool isPostUploader = currentOnlineUserId == uploaderID;
    if (!isPostUploader) {
      feedCollectionRef
          .document(uploaderID)
          .collection("feedItems")
          .document(postID)
          .setData({
        "type": "like",
        "username": currUserData.userName,
        "userID": currUserData.id,
        "timestamp": timestamp,
        "url": imageUrl,
        "userProfileImg": currUserData.imgUrl
      });
    }
  }

  removeLikeFeed() {
    bool isPostUploader = currentOnlineUserId == uploaderID;
    if (!isPostUploader) {
      feedCollectionRef
          .document(uploaderID)
          .collection("feedItems")
          .document(postID)
          .get()
          .then((doc) {
        doc.reference.delete();
      });
    }
  }

  showComment(
      BuildContext context, String postID, String uploaderID, String url) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CommentsScreen(
            postID: postID,
            uploaderID: uploaderID,
            imgUrl: url,
          ),
        ));
  }

  handleLikePost() {
    bool _isLiked = Likes[currentOnlineUserId] == true;

    //Dislike
    if (_isLiked) {
      postsCollectionRef
          .document(uploaderID)
          .collection("userPosts")
          .document(postID)
          .updateData({
        "Likes.$currentOnlineUserId": false,
      });
      removeLikeFeed();
      setState(() {
        likeCount -= 1;
        isLiked = false;
        Likes[currentOnlineUserId] = false;
      });
    }
    //Liked
    else if (!_isLiked) {
      postsCollectionRef
          .document(uploaderID)
          .collection("userPosts")
          .document(postID)
          .updateData({
        "Likes.$currentOnlineUserId": true,
      });
      addLikeFeed();
      setState(() {
        likeCount += 1;
        isLiked = true;
        Likes[currentOnlineUserId] = true;
        showHeart = true;
      });
      Timer(Duration(milliseconds: 800), () {
        setState(() {
          showHeart = false;
        });
      });
    }
  }

  Widget postImgContent() {
    return GestureDetector(
      onDoubleTap: () => handleLikePost(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          //  CachedNetworkImageProvider(imageUrl)
          Image.network(
            imageUrl,
            height: 420.0,
            width: MediaQuery.of(context).size.width - 60,
            fit: BoxFit.fill,
          ),
          showHeart
              ? Icon(
                  Icons.favorite,
                  size: 120.0,
                  color: Colors.pink,
                )
              : Text("")
        ],
      ),
    );
  }

  Widget postHeader() {
    return FutureBuilder(
      future: userCollectionRef.document(uploaderID).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        User user = User.fromDocument(snapshot.data);
        bool isPostOwner = currentOnlineUserId == uploaderID;
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListTile(
            leading: Container(
              margin: EdgeInsets.only(top: 8.0),
              width: 50.0,
              height: 60.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(user.imgUrl),
                    fit: BoxFit.cover,
                  )),
            ),
            title: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        userProfileId: user.id,
                      ),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  user.userName,
                  style: TextStyle(
                      color: Palette.darkBrown,
                      fontSize: 22.0,
                      fontFamily: "EfnChrome"),
                ),
              ),
            ),
            subtitle: Text(
              place,
              style: TextStyle(
                  color: Palette.darkBrown,
                  fontSize: 14.0,
                  fontFamily: "EfnChrome"),
            ),
            trailing: isPostOwner
                ? IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.black87,
                    ),
                  )
                : Text(""),
          ),
        );
      },
    );
  }
}
