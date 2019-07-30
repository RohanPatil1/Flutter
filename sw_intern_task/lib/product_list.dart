import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Product(
            image_path: "images/radio.jpg",
            title: "Braun",
            caption: "portable radio",
            type: "T22",
          ),
          Product(
            image_path: "images/radio.jpg",
            title: "Braun",
            caption: "Lectrin System",
            type: "radio",
          ),
          Product(
            image_path: "images/radio.jpg",
            title: "Braun",
            caption: "Pocket radio",
            type: "T44",
          ),
          Product(
            image_path: "images/radio.jpg",
            title: "Braun",
            caption: "portable radio",
            type: "T22",
          ),
        ],
      ),
    );
  }
}

class Product extends StatelessWidget {
  final String image_path;
  final String title;
  final String caption;
  final String type;

  Product({this.image_path, this.title, this.caption, this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Container(
        child: Column(
          children: <Widget>[
            CircleAvatar(
              minRadius: 40.0,
              maxRadius: 50.0,
              backgroundImage: AssetImage(image_path),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
            Text(
              caption,
              style: TextStyle(color: Colors.black54, fontSize: 16.0),
            ),
            Text(
              type,
              style: TextStyle(color: Colors.black54, fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
