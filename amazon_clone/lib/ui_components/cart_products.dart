import 'package:flutter/material.dart';

class Cart_Products extends StatefulWidget {
  @override
  _Cart_ProductsState createState() => _Cart_ProductsState();
}

class _Cart_ProductsState extends State<Cart_Products> {
  var productList = [
    {
      "name": "Blazer ",
      "img": "images/products/dress2.jpeg",
      "price": 1999,
      "size": "XL",
      "color": "Black",
      "qty": 2
    },
    {
      "name": "Red Dress",
      "img": "images/products/dress2.jpeg",
      "price": 999,
      "size": "M",
      "color": "Red",
      "qty": 1
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return CartProduct(
            cart_prod_name: productList[index]['name'],
            cart_prod_img: productList[index]['img'],
            cart_prod_price: productList[index]['price'],
            cart_prod_size: productList[index]['size'],
            cart_prod_color: productList[index]['color'],
            cart_prod_qty: productList[index]['qty'],
          );
        });
  }
}

class CartProduct extends StatelessWidget {
  String cart_prod_name, cart_prod_img, cart_prod_size, cart_prod_color;
  int cart_prod_price, cart_prod_qty;

  CartProduct(
      {this.cart_prod_name,
      this.cart_prod_img,
      this.cart_prod_size,
      this.cart_prod_color,
      this.cart_prod_price,
      this.cart_prod_qty});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(cart_prod_name),
        leading: Image.asset(
          cart_prod_img,
          width: 40.0,
          height: 40.0,
        ),
        subtitle: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, right: 3.0, left: 1.0, bottom: 2.0),
                  child: Text("Size : "),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(cart_prod_size),
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Text("Color"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(cart_prod_color),
                ),
              ],
            ),
            Container(
              child: Text(
                "\$$cart_prod_price",
                style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              alignment: Alignment.topLeft,
            ),
          ],
        ),
        trailing: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.arrow_drop_up),
              Text(
                "$cart_prod_qty",
                style: TextStyle(fontSize: 7.0),
              ),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
