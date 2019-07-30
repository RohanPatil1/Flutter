import 'package:flutter/material.dart';
import 'product_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffE9492D),
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {}),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  color: Color(0xffE9492D),
                  width: MediaQuery.of(context).size.width,
                  height: 300.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 2.0, 8.0),
                  child: Text(
                    "less\nbut\nbetter",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 80.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  top: 40.0,
                  left: 180.0,
                  child: Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
//                        color: Colors.yellow,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("images/image1.jpg"))),
                  ),
                ),
                Positioned(
                  top: 235.0,
                  left: 320.0,
                  child: RotatedBox(
                      quarterTurns: 1,
                      child: new Text(
                        "BAUN",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 18.0),
                      )),
                )
              ],
            ),
          ),
          Column(
            children: <Widget>[
              //First Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Dieter Rams",
                          style: TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffE9492D)),
                        ),
                        Text(
                          " Industrial Designer, 85",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),

                  //back front icons
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            ),
                            onPressed: () {}),
                        IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                            ),
                            onPressed: () {}),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0, right: 66.0),
                child: Text(
                  "Dieter Rams is a German industrial designer and noticed academic closely associated with the consumer products company Braun andthe functionalist school of industrial design",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(22.0, 8.0, 0.0, 8.0),
                child: Divider(height: 8.0, color: Colors.black),
              ),
              Container(height: 180.0, child: ProductList()),
            ],
          ),
        ],
      ),
    );
  }
}
