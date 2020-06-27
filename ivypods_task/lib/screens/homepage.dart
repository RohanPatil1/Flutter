import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ivypodstask/data_model/post_scopedmodel.dart';
import 'package:ivypodstask/db_helper/db_helper.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File _image;
  final picker = ImagePicker();
  String imgUrl;

  Future<File> getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      _image = File(pickedFile.path);
    });
    return _image;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<PostScopedModel>(
      builder: (BuildContext context, Widget child, PostScopedModel model) {
        return Scaffold(
            backgroundColor: Color(0xffFCFCFC),
            floatingActionButton: SpeedDial(
              marginRight: 18,
              marginBottom: 20,
              animatedIcon: AnimatedIcons.add_event,
              animatedIconTheme: IconThemeData(size: 22.0, color: Colors.white),
              visible: true,
              closeManually: false,
              curve: Curves.bounceIn,
              overlayColor: Colors.black,
              overlayOpacity: 0.5,
              onOpen: () => print('OPENING DIAL'),
              onClose: () => print('DIAL CLOSED'),
              tooltip: 'Speed Dial',
              heroTag: 'speed-dial-hero-tag',
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.pink,
              elevation: 8.0,
              shape: CircleBorder(),
              children: [
                SpeedDialChild(
                    child: Icon(Icons.camera),
                    backgroundColor: Colors.red,
                    label: 'Camera',
                    labelStyle: TextStyle(fontSize: 18.0),
                    onTap: () async {
                      Future<File> myImg = getImage(ImageSource.camera);
                      await model.uploadPost(await myImg);
                    }),
                SpeedDialChild(
                  child: Icon(Icons.image),
                  backgroundColor: Colors.blue,
                  label: 'Gallery',
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () async {
                    Future<File> myImg = getImage(ImageSource.gallery);
                    await model.uploadPost(await myImg);
                  },
                ),
              ],
            ),
            body: model.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : model.isEmpty
                    ? Container(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/emptyview.PNG",
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.17,
                              ),
                              Text(
                                "No Photos Found",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 24.0),
                              )
                            ],
                          ),
                        ),
                      )
                    : Stack(
                        children: <Widget>[
                          ListView.builder(
                            itemCount: model.posts.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> post = model.posts[index];
                              var data = post.values.toList();

                              String likeStatus = model.getLikeStatus(index);

                              double height =
                                  MediaQuery.of(context).size.height;
                              double width = MediaQuery.of(context).size.width;

                              return Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(8.0),
                                    alignment: Alignment.topCenter,
                                    height: height * 0.3,
                                    width: width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      child: FadeInImage(
                                        image: NetworkImage(data[2].toString()),
                                        placeholder:
                                            AssetImage("assets/loading.jpg"),
                                        fit: BoxFit.cover,
                                        height: height * 0.3,
                                        width: width,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: IconButton(
                                        color: (likeStatus == "true")
                                            ? Colors.pink
                                            : Colors.grey,
                                        onPressed: () async {
                                          print("=========UPDATIING==========");
                                          if (likeStatus == "true") {
                                            int updatedId = await DatabaseHelper
                                                .instance
                                                .updatePost({
                                              DatabaseHelper.columnId:
                                                  data[0].toString(),
                                              DatabaseHelper.columnLike: "false"
                                            }, data[0]);
                                            print(updatedId);
                                          } else {
                                            int updatedId = await DatabaseHelper
                                                .instance
                                                .updatePost({
                                              DatabaseHelper.columnId:
                                                  data[0].toString(),
                                              DatabaseHelper.columnLike: "true"
                                            }, data[0]);
                                            print(updatedId);
                                          }
                                          model.getData();
                                        },
                                        icon: (likeStatus == "true")
                                            ? Icon(
                                                Icons.favorite,
                                                size: 34.0,
                                              )
                                            : Icon(Icons.favorite_border,
                                                size: 34.0),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ],
                      ));
      },
    );
  }
}
