import 'package:scoped_model/scoped_model.dart';

class ChatRoom extends Model{

  String chatRoomID;
  String profileImg;
  String date;
  String name;
  String lastMsg;

  ChatRoom({this.chatRoomID, this.profileImg, this.date, this.name,
      this.lastMsg});


}