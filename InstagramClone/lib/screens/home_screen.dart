import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:luffyvio/config/palette.dart';
import 'package:luffyvio/data_models/user_data.dart';
import 'package:luffyvio/screens/create_account_screen.dart';
import 'package:luffyvio/screens/notif_activity_screen.dart';
import 'package:luffyvio/screens/profile_screen.dart';
import 'package:luffyvio/screens/search_screen.dart';
import 'package:luffyvio/screens/timeline_screeen.dart';
import 'package:luffyvio/screens/upload_post_screen.dart';
import 'package:luffyvio/widgets/custom_input.dart';
import 'package:luffyvio/widgets/post_card.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final userCollectionRef = Firestore.instance.collection("users");
final postsCollectionRef = Firestore.instance.collection("posts");
final feedCollectionRef = Firestore.instance.collection("feed");
final commentsCollectionRef = Firestore.instance.collection("comments");
final followersCollectionRef = Firestore.instance.collection("followers");
final timeLineCollectionRef = Firestore.instance.collection("timeline");
final followingCollectionRef = Firestore.instance.collection("followings");
final StorageReference storageReference =
    FirebaseStorage.instance.ref().child("Posts Images");

User currUserData;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pgCtrl = PageController();
  bool isSignedIn = false;
  int tabPageIndex = 0;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  VideoPlayerController _controller;
  LinearGradient currItemLG = Palette.homescreen_2;

  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.asset('assets/videos/login_bg.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _controller.play();
        _controller.setLooping(true);

        setState(() {});
      });

    googleSignIn.onCurrentUserChanged.listen((googleSignInAcc) {
      handleGoogleSignIn(googleSignInAcc);
    }).onError((e) {
      print("[initState()]Error : " + e.toString());
    });

    googleSignIn
        .signInSilently(suppressErrors: false)
        .then((value) => handleGoogleSignIn(value))
        .catchError((e) {
      print("[signInSilently()]Error : " + e.toString());
    });

    super.initState();
  }



  @override
  void dispose() {
    // TODO: implement dispose
    pgCtrl.dispose();
    _controller.dispose();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      //HomeScreen
      return Scaffold(
        key: scaffoldKey,
        // body: IndexedStack(
        //   index: tabPageIndex,
        //
        //   children: [
        //     TimeLineScreen(
        //       currUser: currUserData,
        //     ),
        //     SearchScreen(),
        //     UploadPostScreen(
        //       currUser: currUserData,
        //     ),
        //     NotifActivityScreen(),
        //     ProfileScreen(
        //       userProfileId: currUserData.id,
        //     )
        //   ],
        // ),

        body: PageView(
          controller: pgCtrl,
          children: [
            TimeLineScreen(
              currUser: currUserData,
            ),
            SearchScreen(),
            UploadPostScreen(
              currUser: currUserData,
            ),
            NotifActivityScreen(),
            ProfileScreen(
              userProfileId: currUserData.id,
            )
          ],
          physics:NeverScrollableScrollPhysics() ,
          onPageChanged: handlePageChange,
        ),
        extendBody: true,
        bottomNavigationBar: CupertinoTabBar(
          currentIndex: tabPageIndex,
          onTap: handleTabChange,
          inactiveColor: Colors.white,
          backgroundColor: Color(0x00ffffff),
          items: [
            BottomNavigationBarItem(
                icon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return currItemLG.createShader(bounds);
              },
              child: Icon(
                Icons.home,
              ),
            )),
            BottomNavigationBarItem(
                icon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return currItemLG.createShader(bounds);
              },
              child: Icon(
                Icons.search,
              ),
            )),
            BottomNavigationBarItem(
                icon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return currItemLG.createShader(bounds);
              },
              child: Icon(
                FontAwesomeIcons.plusSquare,
              ),
            )),
            BottomNavigationBarItem(
                icon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return currItemLG.createShader(bounds);
              },
              child: Icon(
                Icons.favorite,
              ),
            )),
            BottomNavigationBarItem(
                icon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return currItemLG.createShader(bounds);
              },
              child: Icon(
                Icons.person,
              ),
            )),
          ],
        ),
      );
    } else {
      //SignIn Page
      return Scaffold(
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
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  margin: EdgeInsets.only(top: 55.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          CustomInput(
                            hintText: "Phone number or email address",
                            onChanged: (value) {},
                            textInputAction: TextInputAction.next,
                          ),
                          CustomInput(
                            hintText: "Password",
                            onChanged: (value) {
                              // password = value;
//                                OtherUtils().registerPassword = value;
                            },
                            //focusNode: OtherUtils().passwordFocusNode,
                            isPasswordField: true,
                            onSubmitted: (value) {},
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.blueAccent,
                              ),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Log In",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Forgotten Password?",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 0.8,
                                      color: Colors.white,
                                    ),
                                  ],
                                  fontWeight: FontWeight.bold,
                                  color: Palette.facebookBlue),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 3.0),
                                height: 3.0,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Divider(
                                  color: Colors.white,
                                  thickness: 0.4,
                                )),
                            Text(
                              "OR",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 3.0),
                                height: 3.0,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Divider(
                                  color: Colors.white,
                                  thickness: 0.4,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 24.0),
                        child: GoogleSignInButton(
                          onPressed: () {
                            /* ... */
                            signInUser();
                          },
                          darkMode: false, // default: false
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
  handlePageChange(int index) {
    setState(() {
      tabPageIndex = index;

    });
  }

  handleTabChange(int i) {
    // pgCtrl.animateToPage(i,
    //     duration: Duration(milliseconds: 400), curve: Curves.easeIn);
    pgCtrl.jumpToPage(i);
  }
  handleGoogleSignIn(GoogleSignInAccount signInAccount) async {
    if (signInAccount != null) {
      await storeUserToFirebase();
      setState(() {
        isSignedIn = true;
      });
      //    configureRealTimePushNotif();
    } else {
      setState(() {
        isSignedIn = false;
      });
    }
  }

  //
  // configureRealTimePushNotif() {
  //   final GoogleSignInAccount gUser = googleSignIn.currentUser;
  //   if (Platform.isIOS) {
  //     //iOS Permissions
  //     firebaseMessaging.requestNotificationPermissions(
  //         IosNotificationSettings(alert: true, badge: true, sound: true));
  //
  //     firebaseMessaging.onIosSettingsRegistered.listen((settings) {
  //       print("Registered!");
  //     });
  //   }
  //
  //   firebaseMessaging.getToken().then((value) => userCollectionRef
  //       .document(currUserData.id)
  //       .updateData({"androidNotificationToken": value}));
  //
  //   firebaseMessaging.configure(onMessage: (Map<String, dynamic> msg) async {
  //     final String recipientID = msg["data"]["recipient"];
  //     final String body = msg["notification"]["body"];
  //
  //     if (recipientID == currUserData.id) {
  //       SnackBar snackBar = SnackBar(
  //         backgroundColor: Colors.pink,
  //         content: Text(
  //           body,
  //           style: TextStyle(color: Colors.white),
  //           overflow: TextOverflow.ellipsis,
  //         ),
  //       );
  //
  //       scaffoldKey.currentState.showSnackBar(snackBar);
  //     }
  //   });
  // }

  List<String> prepareSearchIndex(String value) {
    List<String> splitList = value.split(' ');
    List<String> indexList = [];

    for (int i = 0; i < splitList.length; i++) {
      for (int j = 0; j < splitList[i].length + i; j++) {
        indexList.add(splitList[i].substring(0, j));
      }
    }

    return indexList;
  }

  storeUserToFirebase() async {
    final GoogleSignInAccount currUser = googleSignIn.currentUser;
    DocumentSnapshot documentSnapshot =
    await userCollectionRef.document(currUser.id).get();

    if (!documentSnapshot.exists) {
      final username = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateAccScreen(context),
          ));
      List<String> searchUtil = prepareSearchIndex(currUser.displayName);
      final timeStamp = DateTime.now();
      userCollectionRef.document(currUser.id).setData({
        "id": currUser.id,
        "fullName": currUser.displayName,
        "userName": username,
        "imgUrl": currUser.photoUrl,
        "email": currUser.email,
        "bio": "Here goes the bio",
        "timestamp": timeStamp,
        "searchUtil": searchUtil
      });

      await followersCollectionRef
          .document(currUser.id)
          .collection("userFollowers")
          .document(currUser.id)
          .setData({});
      documentSnapshot = await userCollectionRef.document(currUser.id).get();
    }

    currUserData = User.fromDocument(documentSnapshot);
    List<PostCard> posts = [];

    timeLineCollectionRef.document(currUser.id).collection("timeLinePosts");
  }

  signInUser() {
    googleSignIn.signIn();
  }

  signOutUser() {
    googleSignIn.signOut();
  }
}
