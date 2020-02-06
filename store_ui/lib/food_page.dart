import 'package:flutter/material.dart';

class FoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFAFB),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          Container(
            padding: EdgeInsets.only(right: 15.0),
            width: MediaQuery.of(context).size.width / 2 - 30.0,
            height: MediaQuery.of(context).size.height / 1.8 ,
            child: GridView.count(
              crossAxisCount: 2,
              primary: false,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 15.0,
              childAspectRatio: 0.8,
              children: <Widget>[
                _foodCard("Cookie Mint ", "\$3.99", "assets/cookiemint.jpg",
                    false, false, context),
                _foodCard("Cookie Mint ", "\$3.99", "assets/cookiemint.jpg",
                    false, false, context),
                _foodCard("Cookie Mint ", "\$3.99", "assets/cookiemint.jpg",
                    false, false, context),
                _foodCard("Cookie Mint ", "\$3.99", "assets/cookiemint.jpg",
                    false, false, context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _foodCard(String name, String price, String imgPath, bool added,
    bool isFav, context) {
  return Padding(
    padding: EdgeInsets.only(top: 10, bottom: 5.0, left: 5.0, right: 5.0),
    child: InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3.0,
                  blurRadius: 5.0)
            ],
            color: Colors.white),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  isFav
                      ? Icon(
                          Icons.favorite,
                          color: Color(0xFFEF7532),
                        )
                      : Icon(
                          Icons.favorite_border,
                          color: Color(0xFFEF7532),
                        )
                ],
              ),
            ),
            Hero(
              tag: imgPath,
              child: Container(
                height: 75.0,
                width: 75.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain, image: AssetImage(imgPath))),
              ),
            ),
            SizedBox(
              height: 7.0,
            ),
            Text(
              price,
              style: TextStyle(
                  color: Color(0xff575E67),
                  fontFamily: "Varela",
                  fontSize: 14.0),
            ),
            Text(
              name,
              style: TextStyle(
                  color: Color(0xff575E67),
                  fontFamily: "Varela",
                  fontSize: 14.0),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                color: Color(0xFFBEBEBE),
                height: 1.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Row(
                children: <Widget>[
                  if (!added) ...[
                    Icon(Icons.shopping_basket,
                        color: Color(0xFFD17E50), size: 12.0),
                    Text('Add to cart',
                        style: TextStyle(
                            fontFamily: 'Varela',
                            color: Color(0xFFD17E50),
                            fontSize: 12.0))
                  ],
                  if (added) ...[
                    Icon(Icons.remove_circle_outline,
                        color: Color(0xFFD17E50), size: 12.0),
                    Text('3',
                        style: TextStyle(
                            fontFamily: 'Varela',
                            color: Color(0xFFD17E50),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0)),
                    Icon(Icons.add_circle_outline,
                        color: Color(0xFFD17E50), size: 12.0),
                  ]
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
