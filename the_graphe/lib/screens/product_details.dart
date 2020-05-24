import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thegraphe/data_model/product_model.dart';
import 'package:thegraphe/styles.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      //  backgroundColor: grey,
      appBar: AppBar(
        title: Text("Overview",
            style: GoogleFonts.raleway(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black)),
        centerTitle: true,
        elevation: 0.0,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black54,
        ),
        actions: <Widget>[
          Icon(
            Icons.shopping_cart,
            color: Colors.black54,
          ),
        ],
        backgroundColor: grey,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            color: grey,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: width * 0.7,
              height: width * 0.8,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Center(
                child: Image.network(

                  product.imgUrl,
                  fit: BoxFit.cover,
                  width: 200.0,
                  height: 190.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * 0.4,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: AutoSizeText(
                          product.name,
                          style: GoogleFonts.lato(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                          minFontSize: 16,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "\$ ${product.price}",
                          style: GoogleFonts.lato(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${product.description}",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.black.withOpacity(0.74)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(
                          Icons.favorite_border,
                          color: Colors.black54,
                        ),
                        Container(
                          width: width * 0.7,
                          decoration: BoxDecoration(
                              color: Color(0xff0FCAD6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0))),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "ADD TO CART",
                                    style: GoogleFonts.lato(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
