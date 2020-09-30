import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luffyvio/data_models/user_data.dart';
import 'package:luffyvio/screens/edit_profile_screen.dart';
import 'package:luffyvio/screens/home_screen.dart';
import 'package:luffyvio/screens/post_details_screen.dart';
import 'package:luffyvio/widgets/custom_appbar.dart';
import 'package:luffyvio/widgets/post_card.dart';
import 'package:video_player/video_player.dart';

class ProfileScreen extends StatefulWidget {
  final String userProfileId;

  ProfileScreen({this.userProfileId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String currentOnlineUserId = currUserData.id;
  bool isLoading = false;
  int postsCount = 0;
  List<PostCard> postDataList = [];
  String postOrientation = "grid"; //grid or list
  int followersCount = 0;
  int followingCount = 0;
  bool isFollowing = false;
  VideoPlayerController _controller;

  /*
  followers->profileID->ONlineUserId
following->>ONlineUserId->profileID
   */

  @override
  void initState() {
    print("=================initState()=================");
    _controller = VideoPlayerController.asset('assets/videos/bg5.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _controller.play();
        _controller.setLooping(true);

        setState(() {});
      });

    fetchAllPosts();
    initFollowStatus();
    fetchFollowCounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.tealAccent,
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.fill,
              child: SizedBox(
                width: _controller.value.size?.width ?? 0,
                height: _controller.value.size?.height ?? 0,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage("assets/images/pbg.jpg"),
            //         fit: BoxFit.cover)),
            child: !isLoading
                ? ListView(
                    children: [
                      profileHeader(widget.userProfileId, currUserData.id),
                      SizedBox(
                        height: 16.0,
                      ),
                      Divider(
                        color: Colors.white.withOpacity(0.4),
                        height: 0.0,
                      ),
                      postOrientationView(),
                      Divider(
                        height: 0.0,
                        color: Colors.white.withOpacity(0.4),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : postsCount == 0
                              ? Center(
                                  child: Text(
                                    "NO POST Found!",
                                    style: TextStyle(fontSize: 40.0),
                                  ),
                                )
                              : postView()
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  fetchAllPosts() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot querySnapshot = await postsCollectionRef
        .document(widget.userProfileId)
        .collection("userPosts")
        .orderBy("timeStamp", descending: true)
        .getDocuments();
    print("posts/" + currUserData.id + "/userPosts");

    setState(() {
      postsCount = querySnapshot.documents.length;
      postDataList = querySnapshot.documents
          .map((documentSnapshot) => PostCard.fromDocument(documentSnapshot))
          .toList();
      print("==================");
      print(postDataList);
      print("==================");

      isLoading = false;
    });
  }

  profileHeader(String userID, String profileID) {
    return StreamBuilder(
      stream: userCollectionRef.document(userID).get().asStream(),
      builder: (context, dataSnapshot) {
        if (!dataSnapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (dataSnapshot.hasData) {
          User user = User.fromDocument(dataSnapshot.data);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 84.0,
                      width: 74.0,
                      child: Stack(
                        children: [
                          Center(
                              child:
                                  Image.asset("assets/images/profilebg.png")),
                          Center(
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(user.imgUrl),
                                      fit: BoxFit.cover)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              countColumn("Posts", postsCount),
                              countColumn("Followers", followersCount),
                              countColumn("Following", followingCount),
                            ],
                          ),
                          profileBtn(context)
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 13.0),
                  child: Text(
                    user.userName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontFamily: "HemiHead"),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    user.fullName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontFamily: "Raleway"),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 3.0),
                  child: Text(
                    user.bio,
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14.0,
                        fontFamily: "Raleway"),
                  ),
                ),
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  //==========
  Column countColumn(String title, int count) {
    return //Column1
        Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          " $count",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
            fontFamily: "Xchrome",
            shadows: <Shadow>[
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 1.2,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "RalewayBold",
            shadows: <Shadow>[
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 1.2,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
        ),
      ],
    );
  }

  editUserProfile(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditProfileScreen(currUserId: widget.userProfileId),
      ),
    );
  }

  profileBtn(BuildContext context) {
    bool ownProfile = widget.userProfileId == currentOnlineUserId;
    if (ownProfile) {
      return profileButtonType(
        "Edit Profile",
        () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EditProfileScreen(currUserId: widget.userProfileId),
              ));
        },
      );
    } else {
      if (isFollowing) {
        //  String followStatus = isFollowing ? "Unfollow" : "Follow";

        return profileButtonType("Unfollow", () => handleFollowUtil());
      } else {
        return profileButtonType("Follow", () => handleUnFollowUtil());
      }
    }
    //
    // if (isFollowing) {
    //   //  String followStatus = isFollowing ? "Unfollow" : "Follow";
    //   return profileButtonType("Unfollow", handleUnFollowUtil());
    // }
    // if (!isFollowing) {
    //   return profileButtonType("Follow", handleFollowUtil());
    // }
  }

  handleFollowUtil() async {
    setState(() {
      isFollowing = false;
      print("[handleFollowUtil()] " + isFollowing.toString());
    });
    followersCollectionRef
        .document(widget.userProfileId)
        .collection("userFollowers")
        .document(currentOnlineUserId)
        .get()
        .then((doc) => {
              if (doc.exists) {doc.reference.delete()}
            });
    followingCollectionRef
        .document(widget.userProfileId)
        .collection("userFollowing")
        .document(currentOnlineUserId)
        .get()
        .then((doc) => {
              if (doc.exists) {doc.reference.delete()}
            });

    feedCollectionRef
        .document(widget.userProfileId)
        .collection("feedItems")
        .document(currentOnlineUserId)
        .get()
        .then((doc) => {
              if (doc.exists) {doc.reference.delete()}
            });

    //===============================================
    final timelinePostsRef = timeLineCollectionRef
        .document(currUserData.id)
        .collection("timeLinePosts")
        .where("uploaderID", isEqualTo: widget.userProfileId);

    QuerySnapshot timePosts = await timelinePostsRef.getDocuments();
    timePosts.documents.forEach((doc) {
      print("================TIMELINE UPDATING============================");

      if (doc.exists) {
        print(doc.documentID);
        doc.reference.delete();
      }
    });
    print("================TIMELINE UPDATED============================");

    //==================================================
  }

  //onClick of FOLLOW Button
  handleUnFollowUtil() async {
    setState(() {
      isFollowing = true;
      print("[handleFollowUtil()] " + isFollowing.toString());
    });

    followersCollectionRef
        .document(widget.userProfileId)
        .collection("userFollowers")
        .document(currentOnlineUserId)
        .setData({});

    followingCollectionRef
        .document(currentOnlineUserId)
        .collection("userFollowing")
        .document(widget.userProfileId)
        .setData({});

    //================================================
    final followedUserPostsRef = Firestore.instance
        .collection("posts")
        .document(widget.userProfileId)
        .collection("userPosts");

    final timelinePostsRef = timeLineCollectionRef
        .document(currUserData.id)
        .collection("timeLinePosts");

    QuerySnapshot followedUserPosts = await followedUserPostsRef.getDocuments();
    followedUserPosts.documents.forEach((doc) {
      print("================TIMELINE UPDATING============================");

      print(doc.documentID);
      timelinePostsRef.document(doc.documentID).setData(doc.data);
    });

    print("================TIMELINE UPDATED============================");

    //==================================================
    feedCollectionRef
        .document(widget.userProfileId)
        .collection("feedItems")
        .document(currentOnlineUserId)
        .setData({
      "type": "follow",
      "ownerID": widget.userProfileId,
      "username": currUserData.userName,
      "timeStamp": DateTime.now(),
      "userProfileImg": currUserData.imgUrl,
      "userID": currentOnlineUserId,
    });
  }

  profileButtonType(String title, Function function) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: FlatButton(
        onPressed: () => function(),
        child: Container(
          width: 200.0,
          height: 26.0,
          child: Text(
            title,
            style: TextStyle(color: isFollowing ? Colors.red : Colors.white),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isFollowing ? Colors.deepPurple.withOpacity(0.6) : Colors.blueAccent,
              border: isFollowing ? null: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }

  Widget postView() {
    if (postOrientation == "grid") {
      List<GridTile> gridTile = [];
      postDataList.forEach((currPost) {
        gridTile.add(GridTile(
            child: PostTile(
          post: currPost,
        )));
      });
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 0.6,
          mainAxisSpacing: 1.8,
          crossAxisSpacing: 1.8,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: gridTile,
        ),
      );
    } else if (postOrientation == "list") {
      return Column(
        children: postDataList,
      );
    }
  }

  postOrientationView() {
    return Container(
      height: 44.0,
      color: Colors.black.withOpacity(0.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // IconButton(
          //   onPressed: () => setOrientation("grid"),
          //   icon: Icon(
          //     Icons.grid_on,
          //     color: postOrientation == "grid" ? Colors.blue : Colors.grey,
          //   ),
          // ),
          GestureDetector(
              onTap: () => setOrientation("grid"),
              child: Image.asset(
                "assets/images/ball2.png",
                width: 34,
                height: 34,
              )),

          VerticalDivider(
            color: Colors.white.withOpacity(0.5),
          ),

          GestureDetector(
              onTap: () => setOrientation("list"),
              child: Image.asset(
                "assets/images/ball1.png",
                width: 34,
                height: 34,
              )),

          // IconButton(
          //   onPressed: () => setOrientation("list"),
          //   icon: Icon(
          //     Icons.list,
          //     color: postOrientation == "list" ? Colors.blue : Colors.grey,
          //   ),
          // ),
        ],
      ),
    );
  }

  setOrientation(String orientation) {
    setState(() {
      postOrientation = orientation;
    });
  }

  fetchFollowCounts() async {
    QuerySnapshot followingSnapShot = await followingCollectionRef
        .document(widget.userProfileId)
        .collection("userFollowing")
        .getDocuments();
    setState(() {
      followingCount = followingSnapShot.documents.length;
      print("followingCount= " + followingCount.toString());
    });

    QuerySnapshot followerSnapShot = await followersCollectionRef
        .document(widget.userProfileId)
        .collection("userFollowers")
        .getDocuments();
    setState(() {
      followersCount = followerSnapShot.documents.length;
      print("followersCount= " + followersCount.toString());
    });
  }

  initFollowStatus() async {
    print("[initFollowStatus()=>START]");
    DocumentSnapshot followerSnapshot = await followersCollectionRef
        .document(widget.userProfileId)
        .collection("userFollowers")
        .document(currentOnlineUserId)
        .get();

    setState(() {
      isFollowing = followerSnapshot.exists;
      print("isFollowing= " + isFollowing.toString());
    });
    print("[initFollowStatus()=>END]");
  }
}

class PostTile extends StatelessWidget {
  final PostCard post;

  const PostTile({this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailScreen(
                  postID: post.postID, userID: post.uploaderID),
            ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child: Container(
          height: 40.0,
          width: 80.0,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.white.withOpacity(0.3),
                blurRadius: 3.1,
                spreadRadius: 0.6)
          ]),
          margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          //    child: Image.network(post.imageUrl,fit: BoxFit.cover,)
          child: FancyShimmerImage(
            imageUrl: post.imageUrl,
            boxFit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
