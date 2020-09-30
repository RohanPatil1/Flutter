import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luffyvio/data_models/user_data.dart';
import 'package:luffyvio/screens/home_screen.dart';
import 'package:luffyvio/widgets/custom_appbar.dart';
import 'package:luffyvio/widgets/search_user_tile.dart';
import 'package:video_player/video_player.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

String searchString;

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _textEditingController = TextEditingController();
  final userCollectionRef = Firestore.instance.collection("users");
  VideoPlayerController _searchingCtrl;
  VideoPlayerController _bgCtrl;
  double opacity=1.0;
  @override
  void initState() {
    // TODO: implement initState
    _searchingCtrl = VideoPlayerController.asset('assets/videos/search_bg.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _searchingCtrl.play();
        _searchingCtrl.setLooping(true);

        setState(() {});
      });
    _bgCtrl = VideoPlayerController.asset('assets/videos/bg2.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _bgCtrl.play();
        _bgCtrl.setLooping(true);

        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController.dispose();
    _searchingCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.fill,
              child: SizedBox(
                width: _bgCtrl.value.size?.height ?? 0,
                height: _bgCtrl.value.size?.height ?? 0,
                child: VideoPlayer(_bgCtrl),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 180,
              child: Opacity(
                opacity:opacity ,
                child: Image.asset(
                  "assets/images/asuna.png",
                  fit: BoxFit.cover,
                  width: 240,
                ),
              )),
          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: SingleChildScrollView(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //       children: [
          //         Image.asset(
          //           "assets/images/asuna.png",
          //           fit: BoxFit.cover,
          //           width: 240,
          //         )
          //       ],
          //     ),
          //   ),
          // ),

          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(
                  height: 180.0,
                  width: 0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      color: Colors.white.withOpacity(0.1)),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    controller: _textEditingController,
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Search people...",
                        hintStyle: TextStyle(
                            color: Colors.white, fontFamily: "Raleway"),
                        border: InputBorder.none,
                        // enabledBorder: UnderlineInputBorder(
                        //     borderSide: BorderSide(color: Colors.redAccent)
                        // ),
                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(color: Colors.blueAccent),
                        // ),

                        filled: true,
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _textEditingController.clear();
                          },
                        ),
                        prefixIcon: Icon(
                          Icons.people,
                          color: Colors.white,
                        )),
                     onFieldSubmitted: (v){
                      setState(() {
                        opacity=1.0;
                      });
                     },
                    onTap: (){
                      setState(() {
                        opacity=0;
                      });
                    },

                    onChanged: (val) {
                      setState(() {
                        searchString = val;

                      });

                    },
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: (searchString == null || searchString.trim() == '')
                      ? null
                      : userCollectionRef
                          .where('searchUtil', arrayContains: searchString)
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "ERROR",
                          style: TextStyle(color: Colors.white),
                        ),
                        // child: VideoPlayer(_searchingCtrl),
                      );
                    }

                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: Text(
                            "",
                            style: TextStyle(color: Colors.white),
                          ),
                        );

                      case ConnectionState.none:
                        return Center(
                          child: Text(
                            "",
                            style: TextStyle(color: Colors.white),
                          ),
                        );

                      case ConnectionState.done:
                        return Center(
                          child: Text(""),
                        );

                      default:
                        // return Center(
                        //   child: SizedBox.fromSize(
                        //     child: FittedBox(
                        //       fit: BoxFit.fitHeight,
                        //       child: SizedBox(
                        //         width: 200.0,
                        //         height: 200.0,
                        //         child: Text(
                        //           "READY",
                        //           style: TextStyle(color: Colors.white),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // );
                        return Expanded(
                            child: ListView(
                          children: snapshot.data.documents
                              .map((DocumentSnapshot doc) {
                            User currResultUser = User.fromDocument(doc);

                            print("=====TESTING==========");
                            print("doc.fullname" + doc['fullName']);
                            print(currResultUser.fullName);
                            print("doc.username" + doc['userName']);
                            print(currResultUser.userName);

                            print("=====TESTING==========");

                            return SearchUserTile(currResultUser);
                          }).toList(),
                        ));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class ResultScreenUI extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }

class EmptyScreenUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Text("No Users "),
    ));
  }
}
