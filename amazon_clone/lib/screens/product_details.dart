import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
        title: Center(
          child: Image.asset(
            'images/amazon_white.png',
            fit: BoxFit.cover,
            width: 80.0,
            alignment: Alignment.center,
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
              onPressed: () {}),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Brand : Apple",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Row(
                children: <Widget>[
                  RatingBar(
                    itemSize: 23,
                    initialRating: 4,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Text(
                      "271",
                      style:
                          TextStyle(color: Colors.blueAccent, fontSize: 15.0),
                    ),
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.product_name,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.0, bottom: 4.0),
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(4.0),
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        color: Color(0xffB12704), shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        "32%\noff",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Image.asset(
                      widget.product_img,
                      fit: BoxFit.fitHeight,
                    )),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.share,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "\₹${widget.product_price}/-",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 2.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "MRP: ",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "\₹ ${widget.product_old_price}",
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Save ₹${widget.product_old_price - widget.product_price}",
                        style: TextStyle(
                          color: Color(0xffB12704),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "EMI from ₹588. No Cost EMI available.",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 24.0,
                ),
                OfferList(),
                SizedBox(
                  height: 24.0,
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    boxShadow: [BoxShadow(color: Colors.black)],
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xffF1B469), Color(0xffE28715)])),
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text(
                          "Buy Now",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                      )),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    boxShadow: [BoxShadow(color: Colors.black)],
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xffF4D27F), Color(0xffF0C047)])),
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text(
                          "Add to Cart",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OfferList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Offer(
            image_location: 'images/order_offers/offer1.png',
            image_caption: 'No-contact\nDelivery',
          ),
          Offer(
            image_location: 'images/order_offers/offer2.png',
            image_caption: '10 days,\nReplacement',
          ),
          Offer(
            image_location: 'images/order_offers/offer3.png',
            image_caption: 'Amazon\nDelivered',
          ),
          Offer(
            image_location: 'images/order_offers/offer4.png',
            image_caption: '5 Year\nWarranty',
          ),
        ],
      ),
    );
  }
}

class Offer extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Offer({this.image_location, this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0),
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 50.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  image_location,
                  fit: BoxFit.cover,
//                  color: Colors.black54.withOpacity(0.3),
                  width: 30.0,
                  height: 30.0,
                ),
              ),
            ),
            Text(
              image_caption,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blueAccent, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
