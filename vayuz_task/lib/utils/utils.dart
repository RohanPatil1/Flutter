import 'package:vayuztask/db_helper/db_helper.dart';

class Utils {
  Future<int> sendMessage(String message, String chatRoomID) async {
    return await DatabaseHelper.instance.insertMsg({
      DatabaseHelper.columnMsg: message,
      DatabaseHelper.columnChatRoomId: chatRoomID,
    });
  }

  loadChatByID(String chatRoomID) async {
    print("===loadAllChatByID()=============");

    List<Map<String, dynamic>> messages =
        await DatabaseHelper.instance.queryMsgByChatRoom(chatRoomID);

    return messages;
  }

  loadAllChat() async {
    print("===loadAllChat()=============");
    List<Map<String, dynamic>> messages =
        await DatabaseHelper.instance.queryMsgs();

    return messages;
  }

Future<String>  getLastMessage(String chatRoomID) async {
    String lastMsg;
    List<Map<String, dynamic>> messagesQ =
        await DatabaseHelper.instance.queryMsgByChatRoom(chatRoomID);

    print("=======PRINTING messageQ==========");
    print(messagesQ);

    if (messagesQ.isNotEmpty) {
      Map<String, dynamic> message = messagesQ[0];
      var _list = message.values.toList();
      lastMsg = _list[1].toString();

      print("=======PRINTING message==========");
      print(message);

      print("=======PRINTING LastMSG==========");
      print(lastMsg);
return lastMsg;
    } else {
      lastMsg = "No msg";
    }

    return lastMsg;
  }
}
