import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(NewsApp());
final Color bgColor = Color(0xffF3F3F3);
final Color primaryColor = Color(0xffE70F0B);

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<dynamic> isSelected = [
    true,
    false,
    false,
  ].cast<bool>();
  List<Color> iconColor = [Colors.white, Colors.white, Colors.white];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "News Feed",
          style: TextStyle(fontSize: 30.0, color: Colors.black87),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.grey.shade600,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          ToggleButtons(
            fillColor: primaryColor,
            hoverColor: primaryColor,
            borderColor: Colors.grey.shade300,
            color: Colors.grey.shade800,
            selectedColor: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 32.0, 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.hockeyPuck,
                      color: iconColor[0],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      "Hockey",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 32.0, 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.volleyballBall,
                      color: iconColor[1],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      "Football",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 32.0, 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.golfBall,
                      color: iconColor[2],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      "Golf",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    )
                  ],
                ),
              ),
            ],
            onPressed: (index) {
              setState(() {
                for (int buttonIndex = 0;
                    buttonIndex < isSelected.length;
                    buttonIndex++) {
                  if (buttonIndex == index) {
                    isSelected[buttonIndex] = true;
                    iconColor[buttonIndex] = Colors.white;
                  } else {
                    isSelected[buttonIndex] = false;
                    iconColor[buttonIndex] = Colors.grey.shade800;
                  }
                }
              });
            },
            isSelected: isSelected,
          ),
          SizedBox(
            height: 16.0,
          ),
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/255px-Flag_of_India.svg.png"),
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "IND",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        "7",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0),
                    child: Text(
                      ":",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "ENG",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        "2",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/en/thumb/a/ae/Flag_of_the_United_Kingdom.svg/1280px-Flag_of_the_United_Kingdom.svg.png"),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Card(
            elevation: 6.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 200.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://thebridge.in/wp-content/uploads/2020/01/Indian-mens-hockey-Source-Hockey-India-696x364.jpg"),
                              fit: BoxFit.fill)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "FIH Pro League: Confident India braces up for Belgium League",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Yesterday, 8:45 PM",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Hockey",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Positioned(
                  top: 175.0,
                  left: 240.0,
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "LIVE",
                        style: TextStyle(
                          backgroundColor: Colors.red,
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Divider(),
          const SizedBox(height: 10.0),
          ListTile(
            title: Text(
              "FCM Travel Solutions leverages fan engagement for sports marketing",
              style: TextStyle(color: Colors.black87, fontSize: 16.0),
            ),
            subtitle: Text("Yesterday, 9:02 PM | Aberdeen"),
            trailing: Container(
              width: 80.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://images.pexels.com/photos/1363876/pexels-photo-1363876.jpeg"),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: bgColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey.shade700,
        currentIndex: 0,
        elevation: 4,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.globe),
            title: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Icon(
                FontAwesomeIcons.solidCircle,
                size: 8.0,
                color: primaryColor,
              ),
            ),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.facebook,
                color: Colors.blueAccent,
              ),
              title: Text("")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.googlePlus,
                color: Colors.redAccent,
              ),
              title: Text("")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.twitch,
                color: Colors.deepPurpleAccent,
              ),
              title: Text("")),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.youtube,
                color: Colors.red,
              ),
              title: Text("")),
        ],
      ),
    );
  }
}
