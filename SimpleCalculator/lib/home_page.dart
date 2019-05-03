import 'package:flutter/material.dart';
import 'custom_icon.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var num1 = 0,
      num2 = 0,
      ans = 0;
  final TextEditingController t1 = new TextEditingController(text: "0");
  final TextEditingController t2 = new TextEditingController(text: "0");

  void add() {
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      ans = num1 + num2;
    });
  }

  void multiply() {
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      ans = num1 * num2;
    });
  }

  void divide() {
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      if (num2 == 0) {
        ans = "ND" as int;
      } else {
        ans = (num1 / num2) as int;
      }
    });
  }

  void subs() {
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      ans = num1 - num2;
    });
  }

  void clearAll() {
    setState(() {
      t1.text = "0";
      t2.text = "0";
      ans = 0;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Container(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Output : $ans",
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Enter Number 1..."),
              controller: t1,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Enter Number 2..."),
              controller: t2,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  onPressed: add,
                  child: Icon(Icons.add),
                  color: Colors.greenAccent,
                  splashColor: Colors.red,
                ), //Add->
                MaterialButton(
                  onPressed: subs,
                  child: Icon(CustomIcons.minus_1),
                  splashColor: Colors.red,
                  color: Colors.greenAccent,
                ), //Sub->
              ], //Row->
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  onPressed: multiply,
                  child: Icon(Icons.close),
                  color: Colors.greenAccent,
                  splashColor: Colors.red,
                ), //Mul->
                MaterialButton(
                  onPressed: divide,
                  child: Icon(CustomIcons.divide),
                  splashColor: Colors.red,
                  color: Colors.greenAccent,
                ), //Divide->
              ], //Row->
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  child: Icon(Icons.delete),
                  splashColor: Colors.red,
                  color: Colors.greenAccent,
                  onPressed: clearAll,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.0),
            ),

          ], //Column->
        ),
      ),
    );
  }
}
