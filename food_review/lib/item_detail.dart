import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_icons/flutter_icons.dart';


class ItemDetail extends StatefulWidget {
  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.center,
                    colors: [
                      const Color(0xCC000000),
                      const Color(0xCC000000),
                    ],
                  ),
                  image: DecorationImage(
                      image: AssetImage('assets/food1.jpg'), fit: BoxFit.cover),
                ),
              ),
              AppBar(
                elevation: 40.0,
                backgroundColor: Colors.transparent,
                leading: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 38.0,
                ),
                actions: <Widget>[
                  Icon(
                    Icons.bookmark_border,
                    color: Colors.white,
                    size: 38.0,
                  ),
                ],
              ),
              Positioned(
                top: 380.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5.0,
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 3.0)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(44.0)),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 28.0, right: 120.0),
                        child: Text(
                          'Scrambbled Eggs',
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 18.0, right: 8.0),
                            child: FilterChip(
                              label: Text(
                                'Breakfast',
                                style: TextStyle(color: Colors.green),
                              ),
                              onSelected: null,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: FilterChip(
                              label: Text(
                                'Eggs',
                                style: TextStyle(color: Colors.green),
                              ),
                              onSelected: null,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: FilterChip(
                              label: Text(
                                'Light Food',
                                style: TextStyle(color: Colors.green),
                              ),
                              onSelected: null,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.star,
                                    color: Colors.yellow, size: 24.0),
                                Icon(Icons.star,
                                    color: Colors.yellow, size: 24.0),
                                Icon(Icons.star,
                                    color: Colors.yellow, size: 24.0),
                                Icon(Icons.star,
                                    color: Colors.yellow, size: 24.0),
                                Icon(Icons.star_border,
                                    color: Colors.grey, size: 24.0),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 28.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.favorite_border,
                                    color: Colors.grey,
                                    size: 20.0,
                                  ),
                                  Text(
                                    '1,567',
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  SizedBox(width: 14.0),
                                  Icon(
                                    Icons.chat_bubble_outline,
                                    color: Colors.grey,
                                    size: 20.0,
                                  ),
                                  Text(
                                    '278',
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 27.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 200.0),
                        child: Text(
                          "INSIDER INFO",
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              letterSpacing: 4.0,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 3.0, right: 3.0),
                        child: Text(
                          "Learning how to make easy scrambled eggs can be fun! Spice up this easy egg favourite by adding pepper jack and  salsa or lighten it up by substituting cooking spray and  water for the butter milk...",
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Quicksand',
                              fontSize: 13.7),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 18.0, right: 8.0),
                            child: Chip(
                              backgroundColor: Colors.white,

                              avatar: Icon(Icons.access_time,color: Colors.green,size: 25.0,),
                              label: Text(
                                '25 min',
                                style: TextStyle(color: Colors.green),
                              ),

                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Chip(
                              avatar: Image.asset('assets/bowl.png',width: 35.0,height: 40.0,color: Color(0xff1c7f03),fit: BoxFit.fitHeight,),
                              backgroundColor: Colors.white,
                              label: Text(
                                'for 2 people',
                                style: TextStyle(color: Colors.green),
                              ),

                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only( right: 8.0),
                            child: Chip(

                              avatar: Icon(FontAwesomeIcons.bolt,color: Colors.green,size: 20.0,),
                              backgroundColor: Colors.white,
                              label: Text(
                                '450 cal',
                                style: TextStyle(color: Colors.green),
                              ),

                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0,),
                      Icon(Icons.keyboard_arrow_down,color: Colors.green,size: 25.0,),


                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

/*
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.arrow_back_ios,color: Colors.white,size:40.0,),

                    Icon(Icons.bookmark_border,color: Colors.white,size:40.0,)
                  ],
                ),
              ),
 */
