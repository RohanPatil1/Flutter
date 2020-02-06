import 'package:flutter/material.dart';
import 'package:store_ui/bottom_nav.dart';
import 'package:store_ui/food_page.dart';

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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF545D68),
          ),
          onPressed: () {},
        ),
        title: Text(
          "PickUp",
          style: TextStyle(
              fontFamily: "Varela", color: Color(0xFF545D68), fontSize: 20.0),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Color(0xFF545D68),
            ),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20.0),
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          Text(
            "Categories",
            style: TextStyle(fontSize: 42.0, fontFamily: "Varela"),
          ),
          SizedBox(
            height: 15.0,
          ),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.transparent,
            labelColor: Color(0xFFC88D67),
            isScrollable: true,
            labelPadding: EdgeInsets.only(right: 45.0),
            unselectedLabelColor: Color(0xFFCDCDCD),
            tabs: <Widget>[
              Tab(
                child: Text(
                  "Cookies",
                  style: TextStyle(fontFamily: "Varela", fontSize: 21.0),
                ),
              ),
              Tab(
                child: Text(
                  "Pastries",
                  style: TextStyle(fontFamily: "Varela", fontSize: 21.0),
                ),
              ),
              Tab(
                child: Text(
                  "Ice cream",
                  style: TextStyle(fontFamily: "Varela", fontSize: 21.0),
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height - 100,
            width: double.infinity,
            child: TabBarView(
              controller: _tabController,
              children: [
                FoodPage(),
                FoodPage(),
                FoodPage(),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.fastfood),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
