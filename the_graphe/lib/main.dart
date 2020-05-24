import 'package:flutter/material.dart';
import 'package:thegraphe/screens/product_screen.dart';

void main() => runApp(GrapheApp());

class GrapheApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductScreen(),
    );
  }
}
