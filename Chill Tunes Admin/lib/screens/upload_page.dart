import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:niravanaz_admin/screens/select_category_page.dart';

import '../widgets/textField.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  //Dialog variables
  double uploadProgressAudio = 0;
  double uploadProgressImage = 0;
  bool filesUploaded = false;
  bool filesUploadedFailed = false;
  late StateSetter _setModalState;

  final TextEditingController _nameTextCtrl = TextEditingController();

  final player = AudioPlayer();
  late Duration musicDuration;

  String audioPath = "";
  String audioName = "Select audio";
  String svgPath = "";
  bool isPlaying = false;
  List<String> categories = [];
  CategoryData currCategory = CategoryData(name: "Select category", id: "");

  @override
  void initState() {
    super.initState();
    initMUSIC();
  }

  @override
  void dispose() {
    _nameTextCtrl.dispose();

    super.dispose();
  }

  void initMUSIC() async {
    await player.setLoopMode(LoopMode.one); // loop cu
    // var duration = await player.setUrl(
    //     'https://firebasestorage.googleapis.com/v0/b/niravanaz.appspot.com/o/Sounds%2FNature%2FWind.mp3?alt=media&token=c8f8cbea-93cc-4e92-bddb-7c4dc31381e3');
    // setState(() {
    //   musicDuration = duration!;
    // });
    // print("AUDIO DURATION: $duration  ${musicDuration.inMilliseconds}"); // rrent item
  }

  void showProgressDialog(String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            this._setModalState = setModalState;

            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              title: Text(
                title,
                style: TextStyle(
                    color: Color(0xff181818),
                    fontSize: 20.0,
                    fontFamily: 'BeViteSB'),
              ),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sound Uploading",
                      style: TextStyle(
                          color: Color(0xff181818),
                          fontSize: 16.0,
                          fontFamily: 'BeViteSB'),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    LinearProgressIndicator(
                      value: uploadProgressAudio,
                      backgroundColor: Colors.grey.withOpacity(0.15),
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.pink),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      "Image Uploading",
                      style: TextStyle(
                          color: Color(0xff181818),
                          fontSize: 16.0,
                          fontFamily: 'BeViteSB'),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    LinearProgressIndicator(
                      backgroundColor: Colors.grey.withOpacity(0.15),
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.pink),
                      value: uploadProgressAudio,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      "Updating Firestore...",
                      style: TextStyle(
                          color: Color(0xff181818),
                          fontSize: 16.0,
                          fontFamily: 'BeViteSB'),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    // LinearProgressIndicator(
                    //   backgroundColor: Colors.white,
                    //   value: uploadProgressAudio,
                    // )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/images/bg.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return CategoryPage();
                        },
                      )).then((value) {
                        setState(() {
                          currCategory = value;
                        });
                      });
                    },
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1.7, sigmaY: 1.7),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 10.0),
                            child: Text(
                              (currCategory.name.isNotEmpty)
                                  ? currCategory.name
                                  : "Select category",
                              style: TextStyle(
                                  fontFamily: "BeViteReg",
                                  color: Colors.white,
                                  fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1.7, sigmaY: 1.7),
                      child: CustomInputField(
                        hintText: 'Enter Name',
                        controller: _nameTextCtrl,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter name";
                          }
                          return "";
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1.7, sigmaY: 1.7),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  pickAudioFile();
                                },
                                child: Text(
                                  (audioName != "Select audio")
                                      ? audioName
                                      : "Select audio",
                                  style: TextStyle(
                                      fontFamily: "BeViteReg",
                                      color: Colors.white,
                                      fontSize: 16.0),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  isPlaying ? Icons.stop : Icons.play_arrow,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  if (audioPath.isEmpty) {
                                    if (isPlaying) {
                                      await player.pause();
                                      await player.seek(Duration.zero);
                                      // print("Audio Player Pause Result: $result");
                                      setState(() {
                                        isPlaying = false;
                                        print("isPLAYING: $isPlaying");
                                      });
                                    } else {
                                      setState(() {
                                        isPlaying = true;
                                        print("isPLAYING: $isPlaying");
                                      });
                                      playLocal();
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        "Select audio first!",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'BeViteSB'),
                                      ),
                                      backgroundColor: Colors.deepOrange,
                                    ));
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      pickSvg();
                    },
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2.7, sigmaY: 2.7),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Center(
                              child: (svgPath.isNotEmpty)
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      // child: Image.file(
                                      //   File(svgPath),
                                      //   fit: BoxFit.cover,
                                      // ),
                                      child: SvgPicture.file(
                                        File(svgPath),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Icon(
                                      Icons.image,
                                      color: Colors.white,
                                      size: 48,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2.7, sigmaY: 2.7),
                      child: TextButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      side: BorderSide(
                                          color: Colors.white, width: 1.0)))),
                          onPressed: () async {
                            showProgressDialog("Firebase Upload in progress");
                            String soundUrl = await uploadFile(0, audioPath,
                                currCategory.name, _nameTextCtrl.text);

                            String imageUrl = await uploadFile(1, svgPath,
                                currCategory.name, _nameTextCtrl.text);

                            if (filesUploaded) {
                              print("UPLOAD COMPLETE");
                              print(soundUrl);
                              print(imageUrl);

                              //First letter cap
                              String name = toBeginningOfSentenceCase(
                                  _nameTextCtrl.text)!;

                              CollectionReference sounds = FirebaseFirestore
                                  .instance
                                  .collection('sounds');
                              sounds.doc(_nameTextCtrl.text.toLowerCase()).set({
                                "name": name,
                                "id": _nameTextCtrl.text.toLowerCase(),
                                "image": imageUrl,
                                "sound": soundUrl,
                                "category": currCategory.id
                              }).then((value) {
                                //RESET ALL
                                setState(() {
                                  audioPath = "";
                                  audioName = "Select audio";
                                  svgPath = "";
                                  _nameTextCtrl.clear();
                                  currCategory = CategoryData(
                                      name: "Select category", id: "");
                                });

                                //Close Dialog
                                Navigator.pop(context);
                              });
                            }
                            if (filesUploadedFailed) {
                              //Close Dialog
                              Navigator.pop(context);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  "Upload Failed!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'BeViteSB'),
                                ),
                                backgroundColor: Colors.deepOrange,
                              ));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2.0),
                            child: Text(
                              "SUBMIT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'BeViteBold',
                                  fontSize: 16.0),
                            ),
                          )),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  void pickAudioFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);

    if (result != null) {
      PlatformFile file = result.files.first;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);

      setState(() {
        audioName = file.name.toString();
        audioPath = file.path!;
        print("AUDIO PATH: $audioPath");
      });
      var duration = await player.setFilePath(audioPath);
      setState(() {
        musicDuration = duration!;
      });
      print("AUDIO DURATION: $duration  ${musicDuration.inMilliseconds}");
    } else {
      // User canceled the picker
    }
  }

  void pickSvg() async {
    final FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [".svg"]);

    if (result != null) {
      PlatformFile file = result.files.first;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);

      setState(() {
        svgPath = file.path!;
      });
    } else {
      // User canceled the picker
    }
  }

  playLocal() async {
    await player.setClip(
        start: Duration(seconds: 1),
        end: Duration(seconds: musicDuration.inMilliseconds - 900));
    await player.play(); // Waits until the clip has finished playing
    // setState(() {
    //   isPlaying = true;
    // });
    // print("Audio Result: $result");
  }

  // FileType: 0=>Audio || 1=>Image
  Future<String> uploadFile(
      int fileType, String filePath, String categoryName, String name) async {
    String fileName = (fileType == 0)
        ? DateTime.now().millisecondsSinceEpoch.toString() + '$name.mp3'
        : DateTime.now().millisecondsSinceEpoch.toString() + '$name.svg';
    String fileUrl = "";
    File file = File(filePath);

    // =>  Audio/CategoryName/NameField.mp3

    //TODO: Change to audioPath
    Reference reference = (fileType == 0)
        ? FirebaseStorage.instance
            .ref()
            .child('Sounds')
            .child(categoryName)
            .child(fileName)
        : FirebaseStorage.instance
            .ref()
            .child('Images')
            .child(categoryName)
            .child(fileName);

    UploadTask uploadTask = reference.putFile(file);

    uploadTask.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
      _setModalState(() {
        if (fileType == 0) {
          uploadProgressAudio = snapshot.bytesTransferred.toDouble() /
              snapshot.totalBytes.toDouble();
          print("uploadProgressAudio value=> $uploadProgressAudio");
        } else if (fileType == 1) {
          uploadProgressImage = snapshot.bytesTransferred.toDouble() /
              snapshot.totalBytes.toDouble();
        }
      });

      print('Task state: ${snapshot.state}');
      if (snapshot.state == firebase_storage.TaskState.success) {
        setState(() {
          filesUploaded = true;
        });
      } else if (snapshot.state == TaskState.error) {
        setState(() {
          filesUploadedFailed = true;
        });
      }
      print(
          'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
    }, onError: (e) {
      print("UploadTask : ${uploadTask.snapshot}");

      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    });

    await uploadTask.whenComplete(() async {
      fileUrl = await uploadTask.snapshot.ref.getDownloadURL();
    });

    return fileUrl;
  }
}
