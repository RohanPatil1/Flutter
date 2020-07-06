import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vayuztask/data_model/chatroom_data.dart';
import 'package:vayuztask/db_helper/db_helper.dart';
import 'package:vayuztask/style/colors.dart';
import 'package:vayuztask/style/textstyles.dart';

class MessageChat extends StatefulWidget {
  final ChatRoom chatRoom;

  const MessageChat({Key key, this.chatRoom}) : super(key: key);

  @override
  _MessageChatState createState() => _MessageChatState();
}

class _MessageChatState extends State<MessageChat> {
  List<Map<String, dynamic>> _messages;
  bool isLoading = true;
  String messageToSend;
  ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  int msgCount = 10;
  bool isEmpty = true;

  @override
  void initState() {
    super.initState();
    loadMessages();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //load more messages
        print("========LOADING NEW MSGS================");

        if (_messages.length > msgCount + 10) {
          msgCount += 10;
        } else {
          msgCount = _messages.length;
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.headingBgColor,
      appBar: AppBar(
        backgroundColor: Colours.headingBgColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Text(
          "NETWORK",
          style: FontStyles.headingStyle,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.ellipsisV,
              color: Colors.white,
              size: 18,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Conversation with",
              style: FontStyles.detailsUser1Style,
            ),
          )),
          Flexible(
              child: Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
            child: Text(
              widget.chatRoom.name,
              style: FontStyles.detailsUser2Style,
            ),
          )),
          (!isLoading)
              ? (!isEmpty)
                  ? Expanded(
                      flex: 10,
                      child: ListView.builder(
                        controller: scrollController,
                        physics: ClampingScrollPhysics(),
                        itemCount: (_messages.length > 10)
                            ? msgCount
                            : _messages.length,
                        itemBuilder: (context, index) {
                          if (msgCount == index) {
                            return CircularProgressIndicator();
                          }

                          print("MSG COUNT: " + msgCount.toString());
                          print("_messgaesLength: " +
                              _messages.length.toString());
                          Map<String, dynamic> message = _messages[index];
                          var _list = message.values.toList();
                          return Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(8.0),
                                height: 50.0,
                                width: 50.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            widget.chatRoom.profileImg),
                                        fit: BoxFit.cover)),
                              ),
                              Expanded(
                                  child: Container(
                                margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colours.senderBgColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0))),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      _list[1].toString(),
                                      style: FontStyles.detailsMsgStyle,
                                    ),
                                  ),
                                ),
                              ))
                            ],
                          );
                        },
                      ),
                    )
                  : Container(
                      child: Center(
                        child: Text(
                          "No Messages Found",
                          style: FontStyles.detailsMsgStyle,
                        ),
                      ),
                    )
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Stack(
              children: <Widget>[
                TextField(
                  style: FontStyles.detailsMsgStyle,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(8.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: FontStyles.detailsMsgStyle,
                      hintText: "Say Something...",
                      fillColor: Colors.black),
                  controller: textEditingController,
                  onSubmitted: (v) {
                    messageToSend = v;
                    setState(() {});
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        size: 28.0,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        messageToSend = textEditingController.text.toString();
                        insertMessage(messageToSend);
                        textEditingController.text = "";
                      },
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colours.msgListingBgColor,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.09,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.networkWired,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                  Text(
                    "Network",
                    style: FontStyles.footerStyle,
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.message,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                  Text(
                    "Messages",
                    style: FontStyles.footerStyle,
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.people,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                  Text(
                    "Contact",
                    style: FontStyles.footerStyle,
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.video_library,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                  Text(
                    "Library",
                    style: FontStyles.footerStyle,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  insertMessage(String message) async {
    setState(() {
      isLoading = true;
    });
    int i = await DatabaseHelper.instance.insertMsg({
      DatabaseHelper.columnMsg: message,
      DatabaseHelper.columnChatRoomId: widget.chatRoom.chatRoomID,
    });
    print("=======INSERTED : " + i.toString());
    loadMessages();
  }

  loadMessages() async {
    setState(() {
      isLoading = true;
    });
    print("CHATROOM ID : " + widget.chatRoom.chatRoomID);
    List<Map<String, dynamic>> messages = await DatabaseHelper.instance
        .queryMsgByChatRoom(widget.chatRoom.chatRoomID);
    setState(() {
      _messages = messages;
      isLoading = false;
      if (_messages.isNotEmpty) {
        isEmpty = false;
      }
    });
    print(messages);
  }
}
