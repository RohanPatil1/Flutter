import 'package:flutter/material.dart';
import 'package:amazoine_clone/ui_components/cart_products.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color(0xff232F3E),
        centerTitle: true,
        title: Text(
          "My Cart",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
                //Color(0xffF3A847)
              ),
              onPressed: () {}),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text("Total : "),
                subtitle: Text("\$230"),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {},
                child: Text(
                  "Check out",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.redAccent,
              ),
            )
          ],
        ),
      ),
      body: Cart_Products(),
    );
  }
}
