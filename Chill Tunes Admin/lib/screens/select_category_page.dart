import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TextEditingController _categoryCtrl = TextEditingController();
  List<CategoryData> categories = [];
  List<CategoryData> categoriesDisplay = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  void dispose() {
    _categoryCtrl.dispose();
    super.dispose();
  }

  void getData() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('category').get();
    final List<DocumentSnapshot> documents = snapshot.docs;
    documents.forEach((element) {
      categories.add(CategoryData(name: element['name'], id: element['id']));
    });

    print("CATEGORIES: $categories");
    setState(() {
      categoriesDisplay = categories;
      isLoading = false;
    });
  }

  void showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          title: Text(
            title,
            style: TextStyle(
                color: Color(0xff181818),
                fontSize: 20.0,
                fontFamily: 'BeViteSB'),
          ),
          content: Text(
            content,
            style: TextStyle(
                color: Color(0xff181818),
                fontSize: 14.0,
                fontFamily: 'BeViteReg'),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                CollectionReference categories =
                    FirebaseFirestore.instance.collection('category');
                categories.doc(_categoryCtrl.text.toLowerCase()).set({
                  "name": _categoryCtrl.text.toString(),
                  "id": _categoryCtrl.text.toLowerCase()
                }).then((value) {
                  Navigator.pop(
                      context,
                      CategoryData(
                          name: _categoryCtrl.text.toString(),
                          id: _categoryCtrl.text.toLowerCase()));
                });
              },
              child: Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Text(
                  "Confirm",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.grey, fontFamily: 'BeViteLight'),
              ),
              onPressed: () {
                Navigator.pop(context, "cancel");
              },
            )
          ],
        );
      },
    ).then((value) {
      if (value != "cancel") {
        Navigator.pop(context, value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            "assets/images/bg.jpg",
            fit: BoxFit.cover,
          ),
        ),
        !isLoading
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Theme(
                              data: new ThemeData(
                                primaryColor: Colors.white,
                                primaryColorDark: Colors.white,
                              ),
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                controller: _categoryCtrl,
                                // autofocus: true,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      borderSide: BorderSide(
                                          width: 0.5, color: Colors.white),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(28),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      borderSide: BorderSide(
                                          width: 0.5, color: Colors.white),
                                    ),
                                    hintText: 'Search category...',
                                    filled: true,
                                    hintStyle: TextStyle(color: Colors.white),
                                    fillColor: Colors.white.withOpacity(0.2)),
                                onChanged: (value) {
                                  print("ONCHANGED: $value");
                                  value = value.toLowerCase();
                                  setState(() {
                                    categoriesDisplay =
                                        categories.where((element) {
                                      var category = element.name.toLowerCase();
                                      return category.contains(value);
                                    }).toList();
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                if (_categoryCtrl.text.trim().isNotEmpty) {
                                  showAlertDialog("Are you sure?",
                                      "You want to add '${_categoryCtrl.text}' to firebase collection.");
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Please enter category name!")));
                                }

                                //Navigator.pop(context, _categoryCtrl.text);
                              },
                              child: Container(
                                width: 44.0,
                                height: 44.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.tealAccent,
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ListView(
                      children: categoriesDisplay.map((CategoryData currCat) {
                        return Card(
                          elevation: 1.0,
                          shadowColor: Colors.white.withOpacity(0.4),
                          color: Colors.black.withOpacity(0.75),
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context, currCat);
                            },
                            title: Text(
                              currCat.name,
                              style: TextStyle(color: Colors.tealAccent),
                              // textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              )
      ],
    ));
  }
}

class CategoryData {
  final String name;
  final String id;

  CategoryData({required this.name, required this.id});
}
