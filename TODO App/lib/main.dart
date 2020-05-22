import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ToDo App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff543B7A),
      ),
      home: CreateToDo(),
    );
  }
}

class CreateToDo extends StatefulWidget {
  @override
  _CreateToDoState createState() => _CreateToDoState();
}

class _CreateToDoState extends State<CreateToDo> {
  String taskName, taskTime, taskDate, taskDetails;

  Widget todoTye(String iconType) {
    IconData iconVal;
    Color colorVal;

    switch (iconType) {
      case 'travel':
        iconVal = FontAwesomeIcons.mapMarkedAlt;
        colorVal = Colors.purple;
        break;
      case 'shopping':
        iconVal = FontAwesomeIcons.shoppingCart;
        colorVal = Colors.redAccent;
        break;
      case 'gym':
        iconVal = FontAwesomeIcons.dumbbell;
        colorVal = Colors.green;
        break;
      case 'party':
        iconVal = FontAwesomeIcons.glassCheers;
        colorVal = Color(0xff9962a);
        break;
      default:
        iconVal = FontAwesomeIcons.tasks;
        colorVal = Colors.blue;
        break;
    }

    return CircleAvatar(
      backgroundColor: colorVal,
      child: Center(child: Icon(iconVal, color: Colors.white, size: 18.0)),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 180.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("TODO Tasks"),
              background: Image.asset(
                "assets/appbarbg.jpg",
                fit: BoxFit.fill,
              ),
            ),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: StreamBuilder(
                    stream:
                        Firestore.instance.collection('todolist').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        const Text('Loading ');
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot myTask =
                                  snapshot.data.documents[index];
                              return Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                actionExtentRatio: 0.25,
                                closeOnScroll: true,
                                child: Stack(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 80.0,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 8.0, bottom: 8.0),
                                            child: Material(
                                              color: Colors.white,
                                              elevation: 14.0,
                                              shadowColor: Color(0x802196F3),
                                              child: Center(
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      todoTye(
                                                          '${myTask['tasktype']}'),
                                                      Text(
                                                        "${myTask['taskname']}",
                                                        style: TextStyle(
                                                            fontSize: 20.0,
                                                            fontFamily:
                                                                'Raleway',
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text(
                                                            "${myTask['taskdate']}",
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          Text(
                                                            "${myTask['tasktime']}",
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  IconSlideAction(
                                      caption: 'Delete',
                                      color: Colors.redAccent,
                                      icon: Icons.delete,
                                      onTap: () => deleteData(snapshot
                                          .data.documents[index].documentID)),
                                  IconSlideAction(
                                      caption: 'Update',
                                      color: Colors.blueAccent,
                                      icon: Icons.update,
                                      onTap: () => updateData(snapshot
                                          .data.documents[index].documentID)),
                                ],
                              );
                            });
                      }
                    } //builder
                    ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xfffA7397),
          child: Icon(
            Icons.add,
            size: 29.0,
            color: Colors.white,
          ),
          onPressed: () {
            _addDialog(context);
          }),
    );
  }

  int _myTaskType = 1;
  String taskVal;

  void _handleTaskType(int type) {
    setState(() {
      _myTaskType = type;
      switch (_myTaskType) {
        case 1:
          taskVal = "travel";
          break;

        case 2:
          taskVal = "shopping";
          break;

        case 3:
          taskVal = "gym";
          break;

        case 4:
          taskVal = "party";
          break;

        case 5:
          taskVal = "others";
          break;
      }
    });
  }

  updateData(selectedDoc) {
    _updateDialog(context, selectedDoc);
  }

  deleteData(docID) {
    Firestore.instance.collection("todolist").document(docID).delete();
  }

  Future<bool> _addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Add Data",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 1.0, right: 1.0),
                    child: TextField(
                      onChanged: (value) {
                        this.taskName = value;
                      },
                      decoration: InputDecoration(labelText: "Name"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 1.0, right: 1.0),
                    child: TextField(
                      onChanged: (value) {
                        this.taskDetails = value;
                      },
                      decoration: InputDecoration(labelText: "Details"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 1.0, right: 1.0),
                    child: TextField(
                      onChanged: (value) {
                        this.taskDate = value;
                      },
                      decoration: InputDecoration(labelText: "Date"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 1.0, right: 1.0),
                    child: TextField(
                      onChanged: (value) {
                        this.taskTime = value;
                      },
                      decoration: InputDecoration(labelText: "Time"),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Center(
                      child: Text(
                    "Select Task Type :",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: _myTaskType,
                            onChanged: _handleTaskType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text(
                            "Travel",
                            style: TextStyle(fontSize: 16.0),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 2,
                            groupValue: _myTaskType,
                            onChanged: _handleTaskType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text(
                            "Shopping",
                            style: TextStyle(fontSize: 16.0),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 3,
                            groupValue: _myTaskType,
                            onChanged: _handleTaskType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text(
                            "Gym",
                            style: TextStyle(fontSize: 16.0),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 4,
                            groupValue: _myTaskType,
                            onChanged: _handleTaskType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text(
                            "Party",
                            style: TextStyle(fontSize: 16.0),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 5,
                            groupValue: _myTaskType,
                            onChanged: _handleTaskType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text(
                            "Others",
                            style: TextStyle(fontSize: 16.0),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 45.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                      ),
                    ],
                  )
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                  elevation: 5.0,
                  color: Colors.redAccent,
                  highlightElevation: 1.0,
                  highlightColor: Colors.red,
                  minWidth: 75.0,
                  height: 47.0,
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: "Raleway"),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              SizedBox(
                width: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 38.0),
                child: MaterialButton(
                    elevation: 5.0,
                    color: Colors.blue,
                    highlightElevation: 1.0,
                    highlightColor: Colors.blueAccent,
                    minWidth: 75.0,
                    height: 47.0,
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'Raleway'),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Map<String, dynamic> tasks = {
                        'taskname': this.taskName,
                        'taskdate': this.taskDate,
                        'taskdetails': this.taskDetails,
                        'tasktime': this.taskTime,
                        'tasktype': taskVal
                      };

                      //TODO: Add Task Logic
                      DocumentReference ds = Firestore.instance
                          .collection("todolist")
                          .document(this.taskName);
                      ds.setData(tasks).then((result) {
                        print("Task Completed");
                      });
                    }),
              ),
            ],
          );
        });
  } //addDialog

  Future<bool> _updateDialog(BuildContext context, selectedDoc) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Update Data",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 1.0, right: 1.0),
                    child: TextField(
                      onChanged: (value) {
                        this.taskName = value;
                      },
                      decoration: InputDecoration(labelText: "Name"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 1.0, right: 1.0),
                    child: TextField(
                      onChanged: (value) {
                        this.taskDetails = value;
                      },
                      decoration: InputDecoration(labelText: "Details"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 1.0, right: 1.0),
                    child: TextField(
                      onChanged: (value) {
                        this.taskDate = value;
                      },
                      decoration: InputDecoration(labelText: "Date"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 1.0, right: 1.0),
                    child: TextField(
                      onChanged: (value) {
                        this.taskTime = value;
                      },
                      decoration: InputDecoration(labelText: "Time"),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Center(
                      child: Text(
                    "Select Task Type :",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: _myTaskType,
                            onChanged: _handleTaskType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text(
                            "Travel",
                            style: TextStyle(fontSize: 16.0),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 2,
                            groupValue: _myTaskType,
                            onChanged: _handleTaskType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text(
                            "Shopping",
                            style: TextStyle(fontSize: 16.0),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 3,
                            groupValue: _myTaskType,
                            onChanged: _handleTaskType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text(
                            "Gym",
                            style: TextStyle(fontSize: 16.0),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 4,
                            groupValue: _myTaskType,
                            onChanged: _handleTaskType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text(
                            "Party",
                            style: TextStyle(fontSize: 16.0),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 5,
                            groupValue: _myTaskType,
                            onChanged: _handleTaskType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text(
                            "Others",
                            style: TextStyle(fontSize: 16.0),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 45.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                      ),
                    ],
                  )
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                  elevation: 5.0,
                  color: Colors.redAccent,
                  highlightElevation: 1.0,
                  highlightColor: Colors.red,
                  minWidth: 75.0,
                  height: 47.0,
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        fontSize: 20.0),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              SizedBox(
                width: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 38.0),
                child: MaterialButton(
                    elevation: 5.0,
                    color: Colors.blueAccent,
                    highlightElevation: 1.0,
                    highlightColor: Colors.blue,
                    minWidth: 75.0,
                    height: 47.0,
                    child: Text(
                      "Update",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Raleway',
                          fontSize: 20.0),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Map<String, dynamic> updatedtask = {
                        'taskname': this.taskName,
                        'taskdate': this.taskDate,
                        'taskdetails': this.taskDetails,
                        'tasktime': this.taskTime,
                        'tasktype': taskVal
                      };

                      Firestore.instance
                          .collection("todolist")
                          .document(selectedDoc)
                          .updateData(updatedtask);

//                    Firestore.instance
//                        .collection("todolist")
//                        .document(selectedDoc)
//                        .updateData(newValues);
                    }),
              ),
            ],
          );
        });
  } //updateDialog

}

//
//GestureDetector(
//onTap: updateData(snapshot.data
//    .documents[index].documentID),
//onLongPress: deleteData(snapshot
//    .data
//    .documents[index]
//.documentID),
