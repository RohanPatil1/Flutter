import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luffyvio/data_models/user_data.dart';
import 'package:luffyvio/screens/home_screen.dart';
import 'package:luffyvio/widgets/custom_appbar.dart';
import 'package:luffyvio/widgets/post_card.dart';

class TimeLineScreen extends StatefulWidget {
  final User currUser;

  const TimeLineScreen({Key key, this.currUser}) : super(key: key);

  @override
  _TimeLineScreenState createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  List<PostCard> postDataList;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  int postsCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    // fetchFollowings();
    //  fetchTimeLineData();
    fetchAllPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        // appBar: CustomAppbar(context, "TimeLine", hasBackBtn: true),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg.jpg"),
                  fit: BoxFit.cover)),
          child: isLoading
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
                  : ListView(
                      children: postDataList,
                    ),
        ));
  }

  /*
  /timeline/104850295729456785670/timeLinePosts/82b774df-ff96-4255-8dcc-fbe79314f717
  timeline/104850295729456785670/timeLinePosts/
   */

  timelineView() {
    // if (postDataList == null) {
    //   return Center(
    //     child: Text("NO POST FOUND"),
    //   );
    // } else {
    //   return ListView(
    //     children: postDataList,
    //   );
    // }
    return ListView(
      children: postDataList,
    );
  }

  fetchAllPosts() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot querySnapshot = await timeLineCollectionRef
        .document(currUserData.id)
        .collection("timeLinePosts")
        .orderBy("timeStamp", descending: true)
        .getDocuments();
    // print("posts/" + currUserData.id + "/userPosts");

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

  fetchTimeLineData() async {
    QuerySnapshot timelineSnapshot = await timeLineCollectionRef
        .document(currUserData.id)
        .collection("timeLinePosts")
        // .orderBy("timeStamp", descending: true)
        .getDocuments();
    print("timeline/" + currUserData.id + "/timeLinePosts/");

    // setState(() {
    //   timelineSnapshot.documents.map((doc) {
    //     print("====Checking DOC exists=============");
    //     if (doc.exists) {
    //       print("==== DOC exists=============");
    //
    //       postDataList.add(PostCard.fromDocument(doc));
    //       print(doc.data);
    //     }
    //   });

    setState(() {
      timelineSnapshot.documents
          .map((doc) => postDataList.add(PostCard.fromDocument(doc)));
    });

    print("====DATA FETCHED==================");
    // print(postDataList.length);
  }
//
// fetchFollowings() async {
//   QuerySnapshot followingSnapshot = await followingCollectionRef
//       .document(widget.currUser.id)
//       .collection("userFollowing")
//       .getDocuments();
//
//   setState(() {
//     followingsDataList =
//         followingSnapshot.documents.map((doc) => doc.documentID).toList();
//   });
// }
}
