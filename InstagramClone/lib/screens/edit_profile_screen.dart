import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luffyvio/data_models/user_data.dart';
import 'package:luffyvio/screens/home_screen.dart';
import 'package:luffyvio/screens/profile_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as Img;
import 'package:video_player/video_player.dart';

class EditProfileScreen extends StatefulWidget {
  final String currUserId;

  EditProfileScreen({this.currUserId});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController fullNameEditingCtrl = TextEditingController();
  TextEditingController bioEditingCtrl = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  User user;
  bool isNameValid = true;
  File image;
  final picker = ImagePicker();
  String profileImgID = Uuid().v4();
  double opacity = 1.0;
  VideoPlayerController _controller;
  File croppedFile;
  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.asset('assets/videos/bg3.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _controller.play();
        _controller.setLooping(true);

        setState(() {});
      });
    getUpdatedInfo();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    fullNameEditingCtrl.dispose();
    bioEditingCtrl.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,

        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   actions: [
        //     IconButton(
        //       icon: Icon(
        //         Icons.done,
        //         color: Colors.white,
        //         size: 30.0,
        //       ),
        //       onPressed: () {
        //         Navigator.pushReplacement(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => HomeScreen(),
        //             ));
        //       },
        //     )
        //   ],
        // ),
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
            Positioned(
                bottom: -28,
                left: 130,
                child: Opacity(
                  opacity: opacity,
                  child: Image.asset(
                    "assets/images/luffynami.png",
                    width: 280.0,
                    height: 280.0,
                  ),
                )),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  )
                : ListView(
                    children: [
                      SizedBox(
                        height: 140.0,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: (image == null)
                                        ? CircleAvatar(
                                            radius: 45.0,
                                            backgroundImage:
                                                NetworkImage(user.imgUrl),
                                          )
                                        : CircleAvatar(
                                            radius: 45.0,
                                            backgroundImage: FileImage(image),
                                          ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 190.0,
                                  child: IconButton(
                                    onPressed: () {
                                      pickImage(context);
                                    },
                                    icon: Icon(
                                      Icons.camera_alt_rounded,
                                      size: 28.0,
                                    ),
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  //FullName TextField
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Full Name",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontFamily: "HemiHead"),
                                      ),
                                      TextFormField(
                                        onFieldSubmitted: (v) {
                                          setState(() {
                                            opacity = 1.0;
                                          });
                                        },
                                        onTap: () {
                                          setState(() {
                                            opacity = 0;
                                          });
                                        },
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Raleway"),
                                        controller: fullNameEditingCtrl,
                                        decoration: InputDecoration(
                                            hintText: "Write your full name...",
                                            hintStyle: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Raleway"),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.cyanAccent)),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blue)),
                                            errorText: isNameValid
                                                ? ""
                                                : "Name is very short"),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Bio",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontFamily: "HemiHead")),
                                      TextFormField(
                                        onFieldSubmitted: (v) {
                                          setState(() {
                                            opacity = 1.0;
                                          });
                                        },
                                        onTap: () {
                                          setState(() {
                                            opacity = 0;
                                          });
                                        },
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Raleway"),
                                        controller: bioEditingCtrl,
                                        decoration: InputDecoration(
                                          hintText: "Write your bio...",
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Raleway"),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.cyanAccent)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blue)),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                uploadProfileImg();
                         
                                //Update Data in Firestore Users Collection
                                userCollectionRef
                                    .document(widget.currUserId)
                                    .updateData({
                                  "fullName": fullNameEditingCtrl.text,
                                  "bio": bioEditingCtrl.text
                                });

                                SnackBar snackbar = SnackBar(
                                  backgroundColor: Colors.yellow,
                                  content: ListTile(
                                    leading: Text("Info has been updated!",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "RalewayBold")),
                                    trailing: IconButton(
                                      icon: Icon(
                                        Icons.done,
                                        color: Colors.black,
                                        size: 28.0,
                                      ),
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen(),
                                            ));
                                      },
                                    ),
                                  ),
                                );
                                _scaffoldKey.currentState
                                    .showSnackBar(snackbar);
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              child: Container(
                                height: 40.0,
                                margin: EdgeInsets.symmetric(horizontal: 54.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18.0),
                                    color: Colors.green),
                                child: Center(
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                        fontFamily: "RalewayBold",
                                        fontSize: 16.0,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
          ],
        ));
  }

  pickImage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("New Post "),
          children: <Widget>[
            SimpleDialogOption(
              child: Text("Capture image from Camera"),
              onPressed: () => uploadImageFromCamera(),
            ),
            SimpleDialogOption(
              child: Text("Choose image from Gallery"),
              onPressed: () => uploadImageFromGallery(),
            ),
            SimpleDialogOption(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  uploadImageFromCamera() async {
    Navigator.pop(context);
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      image = File(pickedFile.path);
    });
  }

  uploadImageFromGallery() async {
    Navigator.pop(context);
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Edit Post',
            toolbarColor: Color(0xff181818),
            toolbarWidgetColor: Colors.white,
            backgroundColor: Color(0xff181818),
            cropFrameColor: Color(0xff790fbf),
            cropGridColor: Color(0xffff0044),
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    setState(() {
      image=croppedFile;
    });
    // cropImage(image);
  }



  getUpdatedInfo() async {
    setState(() {
      isLoading = true;
    });

    DocumentSnapshot documentSnapshot =
        await userCollectionRef.document(widget.currUserId).get();
    user = User.fromDocument(documentSnapshot);
    fullNameEditingCtrl.text = user.fullName;
    bioEditingCtrl.text = user.bio;

    setState(() {
      isLoading = false;
    });
  }

  compressImg() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Img.Image mImage = Img.decodeImage(image.readAsBytesSync());
    final compressedImg = File('$path/profileImage_$profileImgID.jpg')
      ..writeAsBytesSync(Img.encodeJpg(mImage, quality: 60));

    setState(() {
      image = compressedImg;
    });
  }

  Future<String> uploadImage(File image) async {
    StorageUploadTask storageUploadTask =
        storageReference.child('profileImage_$profileImgID.jpg').putFile(image);

    StorageTaskSnapshot storageTaskSnapshot =
        await storageUploadTask.onComplete;
    String downloadIUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadIUrl;
  }

  uploadProfileImg() async {
    setState(() {
      isLoading = true;
    });

    await compressImg();

    String downloadUrl = await uploadImage(image);
    userCollectionRef
        .document(widget.currUserId)
        .updateData({"imgUrl": downloadUrl});
  }
}
