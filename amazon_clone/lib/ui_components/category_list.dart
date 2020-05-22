import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0,bottom: 8.0),
      height: 80.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Category(
            image_location: 'images/cats/tshirt.png',
            image_caption: 'T-Shirts',
            color: Color(0xffD3FFCE),
          ),
          Category(
            image_location: 'images/cats/dress.png',
            image_caption: 'Dress',
            color: Color(0xffFFE7C5),
          ),
          Category(
            image_location: 'images/cats/jeans.png',
            image_caption: 'Pants',
            color: Color(0xffE0C7DD),
          ),
          Category(
            image_location: 'images/cats/formal.png',
            image_caption: 'Formals',
            color: Color(0xffAFCFF2),
          ),
          Category(
            image_location: 'images/cats/informal.png',
            image_caption: 'Casuals',
            color: Color(0xffE5E6FA),
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;
  final Color color;

  Category({this.image_location, this.image_caption, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:4.0,left: 8.0,right: 8.0,bottom: 2.0),
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
                  shape: BoxShape.circle, color: color),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  image_location,
                  fit: BoxFit.contain,
          color: Colors.black54.withOpacity(0.3),
          width: 30.0,
                  height: 30.0,
                ),
              ),
            ),
            Text(
              image_caption,
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
