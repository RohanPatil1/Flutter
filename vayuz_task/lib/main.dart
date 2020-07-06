import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vayuztask/data_model/chat_data.dart';
import 'package:vayuztask/screens/message_listing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ChatScopedModel chatModel = ChatScopedModel();

  @override
  Widget build(BuildContext context) {
    chatModel.loadAllChats();
    return ScopedModel(
        model: chatModel,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MessageListing(),
        ));
  }
}
