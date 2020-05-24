import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:thegraphe/data_model/product_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:thegraphe/screens/product_details.dart';

import '../styles.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("The Graphe",
            style: GoogleFonts.raleway(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black)),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.shopping_cart,
              color: Colors.black54,
            ),
          )
        ],
        elevation: 0.0,
        leading: Icon(
          Icons.menu,
          color: Colors.black54,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<List<Product>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "All Products",
                                style: GoogleFonts.raleway(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              Text("Filter Items",
                                  style: GoogleFonts.raleway(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black54))
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Positioned(
                        top: 100.0,
                        right: 0.0,
                        bottom: 0.0,
                        left: 0.0,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: StaggeredGridView.countBuilder(
                            crossAxisCount: 2,
                            itemCount: 6,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 1) {
                                return Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 50.0,
                                    ),
                                    ProductCard(product: snapshot.data[index])
                                  ],
                                );
                              }
                              return ProductCard(product: snapshot.data[index]);
                            },
                            staggeredTileBuilder: (int index) =>
                                new StaggeredTile.count(
                                    1, index.isEven ? 1.2 : 1.5),
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 2.0,
                          ),
                        ))
                  ],
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  // A function that converts a response body into a List<Product>.
  List<Product> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }

  Future<List<Product>> fetchPhotos(http.Client client) async {
    final response = await client
        .get('http://developers.thegraphe.com/dummy/public/api/product');
    print(response.body);
    // Use the compute function to run parsePhotos in a separate isolate.
    return parseProducts(response.body);
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ProductDetails(
            product: product,
          );
        }));
      },
      child: Container(
        height: 200.0,
        width: 200.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: grey,
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 8,
              left: 12.0,
              child: Container(
                width: width * 0.4,
                height: width * 0.38,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Center(
                  child: Image.network(
                    product.imgUrl,
                    fit: BoxFit.fill,
                    width: width * 0.33,
                    height: width * 0.33,
                  ),
                ),
              ),
            ),
//            Positioned(
//              top: 25.0,
//              left: 20.0,
//              child: Image.network(
//                product.imgUrl,
//                fit: BoxFit.cover,
//                width: 120.0,
//                height: 120.0,
//              ),
//            ),
            Positioned(
              top: 144,
              left: 20.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    product.name,
                    style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black),
                    minFontSize: 8,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                  Text(
                    "\$ ${product.price}",
                    style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.all(8),
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.black54,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
