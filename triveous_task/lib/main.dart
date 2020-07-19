import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:triveous_task/screens/main_screen.dart';
import 'package:triveous_task/screens/splash_screen.dart';

import 'data_model/article_scopedmodel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ArticleScopedModel articleScopedModel = ArticleScopedModel();

  @override
  Widget build(BuildContext context) {
    articleScopedModel.getData();

    return ScopedModel<ArticleScopedModel>(
      model: articleScopedModel,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
