import 'dart:io';

import 'package:fbk_clone/core/models/user.dart';
import 'package:fbk_clone/core/models/user_model.dart';
import 'package:fbk_clone/core/viewmodels/upload_post_view_model.dart';
import 'package:fbk_clone/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:fbk_clone/ui/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';

class UploadPostContainer extends StatelessWidget {
  final UserData currUser;

  UploadPostContainer({Key key, this.currUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<UploadPostViewModel>(
      onModelReady: (model) => model.getUserName(),
      builder: (context, model, child) {
        final bool isDesktop = Responsive.isDesktop(context);
        return Card(
          margin: EdgeInsets.symmetric(horizontal: isDesktop ? 5.0 : 0.0),
          elevation: isDesktop ? 1.0 : 0.0,
          shape: isDesktop
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0))
              : null,
          child: Container(
            padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    ProfileAvatar(imageUrl: currUser.imgUrl),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextField(
                        //collapsed mode hides the underline part
                        decoration: InputDecoration.collapsed(
                          hintText: 'What\'s on your mind?',
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(height: 10.0, thickness: 0.5),
                Container(
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton.icon(
                        onPressed: () => print('Live'),
                        icon: const Icon(
                          Icons.videocam,
                          color: Colors.red,
                        ),
                        label: Text('Live'),
                      ),
                      const VerticalDivider(width: 8.0),
                      FlatButton.icon(
                        onPressed: () => model.uploadImageFromGallery(),
                        icon: const Icon(
                          Icons.photo_library,
                          color: Colors.green,
                        ),
                        label: Text('Photo'),
                      ),
                      const VerticalDivider(width: 8.0),
                      FlatButton.icon(
                        onPressed: () => print('Room'),
                        icon: const Icon(
                          Icons.video_call,
                          color: Colors.purpleAccent,
                        ),
                        label: Text('Room'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                (model.image != null)
                    ? Container(
                        height: 200.0,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.teal,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(model.image),
                                fit: BoxFit.cover)),
                      )
                    : Text(""),
                (model.image != null)
                    ? RaisedButton.icon(
                        onPressed: () {
                          model.uploadPost();
                        },
                        icon: Icon(Icons.email),
                        label: Text("Post"))
                    : Text(""),
              ],
            ),
          ),
        );
      },
    );
  }
}
