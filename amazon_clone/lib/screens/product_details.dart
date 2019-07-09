import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  String product_name, product_img;
  int product_old_price, product_price;

  ProductDetails(
      {this.product_name,
      this.product_img,
      this.product_old_price,
      this.product_price});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color(0xff232F3E),
        centerTitle: true,
        title: Text(
          "Amazon",
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
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300.0,
            color: Colors.red,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Hero(
                    tag: widget.product_name,
                    child: Image.asset(widget.product_img)),
              ),
              footer: Container(
                color: Colors.white.withOpacity(0.7),
                child: ListTile(
                  leading: Text(widget.product_name),
                  title: Row(
                    children: <Widget>[
                      Expanded(child: Text("\$${widget.product_price}")),
                      Expanded(
                          child: Text(
                        "\$${widget.product_old_price}",
                        style:
                            TextStyle(decoration: TextDecoration.lineThrough),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              // ----------------------------SIZE BUTTON--------------------------------------

              Expanded(
                child: MaterialButton(
                  elevation: 0.2,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Choose the size "),
                            actions: <Widget>[
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Close "),
                              )
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("Size"),
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: MaterialButton(
                  elevation: 0.2,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Choose the color "),
                            actions: <Widget>[
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Close "),
                              )
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("Color"),
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: MaterialButton(
                  elevation: 0.2,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Choose the quantity "),
                            actions: <Widget>[
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Close "),
                              )
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("Qty"),
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: MaterialButton(
              onPressed: () {},
              color: Colors.redAccent,
              textColor: Colors.white,
              child: Text(
                "Buy Now!",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(top:5.0),
            child: ListTile(
              title: Text("Product Details"),
              subtitle: Text(
                  "Lorem simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of L"),
            ),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
              ),
            ],
          ),


        ],
      ),
    );
  }
}
