import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:provider/provider.dart';
import '../new.dart';
import './product_details.dart';
import 'package:amazoine_clone/ui_components/category_list.dart';
import 'package:amazoine_clone/ui_components/product_list.dart';
import './cart.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget productCarousel;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    productCarousel = Container(
      height: 200.0,
      width: MediaQuery.of(context).size.width,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/c1.jpg'),
          AssetImage('images/m1.jpeg'),
          AssetImage('images/w3.jpeg'),
          AssetImage('images/w4.jpeg'),
          AssetImage('images/m2.jpg'),
        ],
        dotColor: Colors.transparent,
        dotBgColor: Colors.transparent,
        autoplay: false,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color(0xff232F3E),
        centerTitle: true,
        title:  Padding(
          padding: const EdgeInsets.only(top:12.0),
          child: Center(
            child: Image.asset(
              'images/amazon_white.png',
              fit: BoxFit.cover,
             width: 100.0,

              alignment: Alignment.center,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
                //Color(0xffF3A847)
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              }),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Rohan Patil"),
              accountEmail: Text("prorohan8@gmail.com"),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(color: Colors.redAccent),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Home Page"),
                leading: Icon(Icons.home),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("My Account"),
                leading: Icon(Icons.person),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("My Orders"),
                leading: Icon(Icons.shopping_basket),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Categories"),
                leading: Icon(Icons.dashboard),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Favourites"),
                leading: Icon(Icons.favorite),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Settings"),
                leading: Icon(Icons.settings),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("About"),
                leading: Icon(Icons.info),
              ),
            ),
            InkWell(
              onTap: () {
                user.signOut();
              },
              child: ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.highlight_off),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          productCarousel,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Categories",
              style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
            ),
          ),
          CategoryListView(),
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: 8.0, bottom: 8.0),
            child: Text(
              "Recent Products",
              style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 320.0,
            child: ProductGridView(),
          ),
        ],
      ),
    );
  }
}
