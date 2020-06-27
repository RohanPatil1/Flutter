import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ivypodstask/data_model/post_scopedmodel.dart';
import 'package:ivypodstask/db_helper/db_helper.dart';
import 'package:ivypodstask/screens/homepage.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final PostScopedModel postScopedModel = PostScopedModel();

  @override
  Widget build(BuildContext context) {
    postScopedModel.getData();
    return ScopedModel<PostScopedModel>(
      model: postScopedModel,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
