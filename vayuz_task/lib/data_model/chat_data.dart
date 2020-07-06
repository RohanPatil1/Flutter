import 'package:scoped_model/scoped_model.dart';
import 'package:vayuztask/db_helper/db_helper.dart';
import 'package:vayuztask/utils/utils.dart';

class ChatScopedModel extends Model {
  List<Map<String, dynamic>> _messages;

  List<Map<String, dynamic>> get messages => _messages;

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  bool _isEmpty = false;

  bool get isEmpty => _isEmpty;

  String _lastMsg = "";

  String get lastMsg => _lastMsg;

  insertMessage(String message, String chatRoomID) async {
    int i = await DatabaseHelper.instance.insertMsg({
      DatabaseHelper.columnMsg: message,
      DatabaseHelper.columnChatRoomId: chatRoomID,
    });
    print("=======INSERTED : " + i.toString());
    loadMessages(chatRoomID);
  }

  loadMessages(String chatRoomID) async {
    _isLoading = true;
    notifyListeners();

    print("Loading messages from CHATROOM ID : " + chatRoomID);
//    _messages = Utils().loadChat(chatRoomID);
    List<Map<String, dynamic>> messagesQ =
        await DatabaseHelper.instance.queryMsgByChatRoom(chatRoomID);
    _messages = messagesQ;
    notifyListeners();
    print(messages);

    if (messages.isEmpty) {
      _isEmpty = true;
      notifyListeners();
    } else {
      _isEmpty = false;
      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
  }

  loadAllChats() async {
    _isLoading = true;
    notifyListeners();

    _messages = await Utils().loadAllChat();
    _isLoading = false;
    print("Messages after loadAllChats()============");
    print(messages);
    notifyListeners();

  }


}
