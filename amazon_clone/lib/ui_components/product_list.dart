import 'package:flutter/material.dart';
import 'package:amazoine_clone/screens/product_details.dart';

class ProductGridView extends StatefulWidget {
  @override
  _ProductGridViewState createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  var productList = [
    {
      "name": "Blazer",
      "img": "images/products/blazer1.jpeg",
      "old_price": 2000,
      "price": 1500
    },
    {
      "name": "Red Dress",
      "img": "images/products/dress1.jpeg",
      "old_price": 1350,
      "price": 999,
    },
    {
      "name": "Blazer 2",
      "img": "images/products/blazer2.jpeg",
      "old_price": 2000,
      "price": 1500
    },
    {
      "name": "Red Dress 2",
      "img": "images/products/dress2.jpeg",
      "old_price": 1350,
      "price": 999,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: productList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Product(
              product_name: productList[index]['name'],
              product_img: productList[index]['img'],
              product_old_price: productList[index]['old_price'],
              product_price: productList[index]['price']);
        });
  }
}

class Product extends StatelessWidget {
  String product_name, product_img;
  int product_old_price, product_price;

  Product(
      {this.product_name,
      this.product_img,
      this.product_old_price,
      this.product_price});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Container(
        child: Material(
          child: InkWell(
              onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return new ProductDetails(
                      product_name: product_name,
                      product_price: product_price,
                      product_old_price: product_old_price,
                      product_img: product_img,
                    );
                  })),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Container(
                      child: Image.asset(
                        product_img,
                        fit: BoxFit.cover,
                        width: 150.0,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 55.0,
                      width: 200.0,
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                product_name,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top:8.0,right:8.0),
                                  child: Text(
                                    "\$$product_price",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom:2.0,right:4.0),
                                  child: Text(
                                    "\$$product_old_price",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
