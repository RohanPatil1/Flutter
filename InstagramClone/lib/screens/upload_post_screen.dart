import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luffyvio/config/palette.dart';
import 'package:luffyvio/data_models/user_data.dart';
import 'package:luffyvio/screens/home_screen.dart';
import 'package:luffyvio/widgets/progress.dart';
import 'package:luffyvio/widgets/upload_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as Img;

class UploadPostScreen extends StatefulWidget {
  final User currUser;

  const UploadPostScreen({Key key, this.currUser}) : super(key: key);

  @override
  _UploadPostScreenState createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends State<UploadPostScreen> {
  File image;
  final picker = ImagePicker();
  bool isUploading = false;
  String postID = Uuid().v4();
  TextEditingController descripEditingCtrl = TextEditingController();
  TextEditingController placeEditingCtrl = TextEditingController();
  File croppedFile;

  @override
  Widget build(BuildContext context) {
    return
        //UploadForm
        Scaffold(

      backgroundColor: Color(0xff181818),
      body: StreamBuilder(
        stream: userCollectionRef.document(widget.currUser.id).get().asStream(),
        builder: (context, dataSnapshot) {
          if (!dataSnapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(dataSnapshot.hasData){
                    User user = User.fromDocument(dataSnapshot.data);
            currUserData =user;
          }

          return ListView(
            children: [
              isUploading ? linearProgress() : Text(""),
              Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: (image != null)
                        ? Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(image), fit: BoxFit.cover)),
                    )
                        : GestureDetector(
                      onTap: () {
                        pickImage(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(

                                colors: [
                                  Color(0xff757F9A),
                                  Color(0xffD7DDE8)
                                ])),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.file_upload,
                                size: 55,
                                color: Colors.red,
                              ),
                              Text(
                                "UPLOAD",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "HemiHead",
                                    fontSize: 24.0),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                    CachedNetworkImageProvider(widget.currUser.imgUrl),
                  ),
                  title: Container(
                    child: TextField(
                      controller: descripEditingCtrl,
                      decoration: InputDecoration(
                        hintText: "Caption...",
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: "Raleway",
                            fontSize: 13.0),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyanAccent)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                      ),
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Raleway",
                          fontSize: 13.0),
                    ),
                  ),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.mapMarkerAlt,
                    color: Colors.blueAccent,
                  ),
                  title: Container(
                    child: TextField(
                      controller: placeEditingCtrl,
                      decoration: InputDecoration(
                        hintText: "Place...",
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: "Raleway",
                            fontSize: 14.0),
                        contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.tealAccent)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal)),
                      ),
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Raleway",
                          fontSize: 13.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 34.0,
              ),
              InkWell(
                onTap: isUploading ? null : () => handleUpload(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40.0,
                    margin: EdgeInsets.symmetric(horizontal: 54.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xff11998e), Color(0xff38ef7d)])),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.locationArrow,
                            color: Colors.white,
                            size: 18,
                          ),
                          Text(
                            "Publish Your Post",
                            style: TextStyle(
                                fontFamily: "HemiHead",
                                fontSize: 14.0,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  "assets/images/zoro.png",
                  width: 280.0,
                  height: 280.0,
                ),
              )
            ],
          );
        },
      ),
    );
  }

  handleUpload() async {
    setState(() {
      isUploading = true;
      print("=============IS UPLOADING TRUE============");
    });
    await compressImg();

    String downloadUrl = await uploadImage(image);
    savePostData(downloadUrl, placeEditingCtrl.text, descripEditingCtrl.text);
    placeEditingCtrl.clear();
    descripEditingCtrl.clear();

    setState(() {
      image = null;
      isUploading = false;
      //Update PostID each time for unique Id for every post we upload
      postID = Uuid().v4();
    });
  }

  compressImg() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Img.Image mImage = Img.decodeImage(image.readAsBytesSync());
    final compressedImg = File('$path/post_$postID.jpg')
      ..writeAsBytesSync(Img.encodeJpg(mImage, quality: 60));

    setState(() {
      image = compressedImg;
    });
  }

  Future<String> uploadImage(File image) async {
    StorageUploadTask storageUploadTask =
        storageReference.child('post_$postID.jpg').putFile(image);

    StorageTaskSnapshot storageTaskSnapshot =
        await storageUploadTask.onComplete;
    String downloadIUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadIUrl;
  }

  savePostData(String downloadUrl, String place, String description) async {
    final timeStamp = DateTime.now();

    postsCollectionRef
        .document(currUserData.id)
        .collection("userPosts")
        .document(postID)
        .setData({
      "postID": postID,
      "uploaderID": widget.currUser.id,
      "username": widget.currUser.userName,
      "timeStamp": timeStamp,
      "Likes": {},
      "place": place,
      "description": description,
      "imageUrl": downloadUrl
    });

    await timeLineCollectionRef
        .document(currUserData.id)
        .collection("timeLinePosts")
        .document(postID)
        .setData({
      "postID": postID,
      "uploaderID": widget.currUser.id,
      "username": widget.currUser.userName,
      "timeStamp": timeStamp,
      "Likes": {},
      "place": place,
      "description": description,
      "imageUrl": downloadUrl
    });
  }

  getCurrLocation() async {
    print("PRINTING LOCATION");
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placeMarks = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark mPlaceMark = placeMarks[0];
    String finalAddress =
        '${mPlaceMark.subThoroughfare}, ${mPlaceMark.thoroughfare}, ${mPlaceMark.subLocality}, ${mPlaceMark.locality}, ${mPlaceMark.subAdministrativeArea}, ${mPlaceMark.administrativeArea},${mPlaceMark.postalCode}, ${mPlaceMark.country}';
    print("====================");
    print(finalAddress);
    setState(() {
      placeEditingCtrl.text = finalAddress;
    });
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
            toolbarColor: Palette.darkBrown,
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
      image = croppedFile;
    });
  }

  pickImage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return UploadDialog(
          pickFromGallery: uploadImageFromGallery,
          pickFromCamera: uploadImageFromCamera,
        );
      },
    );
  }
}
