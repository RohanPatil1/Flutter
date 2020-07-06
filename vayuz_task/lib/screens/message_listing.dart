import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vayuztask/data_model/chat_data.dart';
import 'package:vayuztask/data_model/chatroom_data.dart';
import 'package:vayuztask/screens/message_chat.dart';
import 'package:vayuztask/style/textstyles.dart';
import 'package:vayuztask/style/colors.dart';
import 'package:vayuztask/utils/utils.dart';

class MessageListing extends StatefulWidget {
  @override
  _MessageListingState createState() => _MessageListingState();
}

class _MessageListingState extends State<MessageListing> {
  List<ChatRoom> chatRoomList = [];

  bool isLoading =true;
  @override
  void initState() {
    loadChatRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ChatScopedModel>(
      builder: (context, child, model) {

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
                  "Message( 3 )",
                  style: FontStyles.headingStyle,
                ),
              )),
              Expanded(
                  flex: 3,
                  child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) => ListTile(
                            leading: Container(
                              height: 50.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          chatRoomList[index].profileImg),
                                      fit: BoxFit.cover)),
                            ),
                            title: Text(
                              chatRoomList[index].name,
                              style: FontStyles.nameStyle,
                            ),
                            subtitle: Text(
                              chatRoomList[index].lastMsg,
                              style: FontStyles.messageStyle,
                            ),
                            trailing: Text(
                              chatRoomList[index].date,
                              style: FontStyles.dateTimeStyle,
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return MessageChat(
                                  chatRoom: chatRoomList[index],
                                );
                              }));
                            },
                          )))
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
      },
    );
  }

  void loadChatRooms() {
    ChatRoom chatRoom1 = ChatRoom(
        chatRoomID: "CH101",
        name: "polaris22",
        date: "Aug22",
        lastMsg: "",
        profileImg: "assets/p1.jpg");
    ChatRoom chatRoom2 = ChatRoom(
        chatRoomID: "CH102",
        name: "polaris22",
        lastMsg: "No Messages",
        date: "Aug22",
        profileImg: "assets/p2.jpg");
    ChatRoom chatRoom3 = ChatRoom(
        chatRoomID: "CH103",
        lastMsg: "No Messages",
        name: "polaris22",
        date: "Aug22",
        profileImg: "assets/p3.jpg");
    chatRoomList.add(chatRoom1);
    chatRoomList.add(chatRoom2);
    chatRoomList.add(chatRoom3);
    setState(() {});
  }

}
