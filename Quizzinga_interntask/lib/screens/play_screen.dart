import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzinga/data_model/category_model.dart';
import 'package:quizzinga/data_model/question_model.dart';
import 'package:quizzinga/repository/utils_repository.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quizzinga/screens/main_screen.dart';

class PlayScreen extends StatefulWidget {
  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  UtilsRepository _utilsRepository = UtilsRepository();
  PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);

  @override
  void initState() {
    _utilsRepository.fetchQuestionList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1C1B20),
        leading: IconButton(
          icon: Icon(
            Icons.settings,
            color: Color(0xff8691A2),
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => SettingsDialog());
          },
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset(
                  "assets/images/coin.png",
                  width: 24.0,
                  height: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  "400",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff8691A2),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(-0.5, -1.0),
            stops: [0.0, 0.5, 0.5, 1],
            colors: [
              Color(0xff191E2A), //red
              Color(0xff191E2A), //red
              Color(0xff1E2331), //orange
              Color(0xff1E2331), //orange
            ],
            tileMode: TileMode.repeated,
          ),
        ),
        child: FutureBuilder(
          future: _utilsRepository.fetchQuestionList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
                break;
              case ConnectionState.waiting:
                return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
                break;
              case ConnectionState.active:
                return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
                break;
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Container(
                    child: Center(child: Text("Something Went Wrong")),
                  );
                } else {
                  print("'====SUCCESS====");
                  return QuestionBuildList(
                    questionData: snapshot.data,
                    pageController: pageController,
                  );
                }
                break;
            }
            return Container(
              color: Colors.red,
            );
          },
        ),
      ),
    );
  }
}

class QuestionBuildList extends StatelessWidget {
  final questionData;
  final pageController;

  const QuestionBuildList({Key key, this.questionData, this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PageView.builder(
      controller: pageController,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return QuestionUI(question: questionData[index]);
      },
    ));
  }
}

class QuestionUI extends StatelessWidget {
  final Question question;

  const QuestionUI({Key key, this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      margin: EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    child: Image.network(
                      question.options[index].image,
                      fit: BoxFit.cover,
                    ),
                  );
                },
                staggeredTileBuilder: (index) =>
                    StaggeredTile.count(1, index.isEven ? 1.0 : 1.0),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              )),
          Container(
            margin: EdgeInsets.only(top: 16.0),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(4.0),
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                      color: Color(0xff1D1C21),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.green,
                            spreadRadius: 4.0,
                            blurRadius: 7.0)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ),
                Container(
                  margin: EdgeInsets.all(4.0),
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                      color: Color(0xff1D1C21),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 2.4,
                            blurRadius: 5.0)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ),
                Container(
                  margin: EdgeInsets.all(4.0),
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                      color: Color(0xff1D1C21),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 2.4,
                            blurRadius: 5.0)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ),
                Container(
                  margin: EdgeInsets.all(4.0),
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                      color: Color(0xff1D1C21),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 2.4,
                            blurRadius: 5.0)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ),
                Container(
                  margin: EdgeInsets.all(4.0),
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                      color: Color(0xff1D1C21),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 2.4,
                            blurRadius: 5.0)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ),
                Container(
                  margin: EdgeInsets.all(4.0),
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                      color: Color(0xff1D1C21),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 2.4,
                            blurRadius: 5.0)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(4.0),
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            color: Color(0xffDDDDDD),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Center(
                          child: Text(
                            "C",
                            style: TextStyle(
                                color: Color(0xff1D1C21),
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(4.0),
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            color: Color(0xffDDDDDD),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Center(
                          child: Text(
                            "P",
                            style: TextStyle(
                                color: Color(0xff1D1C21),
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(4.0),
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            color: Color(0xffDDDDDD),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Center(
                          child: Text(
                            "U",
                            style: TextStyle(
                                color: Color(0xff1D1C21),
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(4.0),
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            color: Color(0xffDDDDDD),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Center(
                          child: Text(
                            "T",
                            style: TextStyle(
                                color: Color(0xff1D1C21),
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(4.0),
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            color: Color(0xffDDDDDD),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Center(
                          child: Text(
                            "K",
                            style: TextStyle(
                                color: Color(0xff1D1C21),
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(4.0),
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            color: Color(0xffDDDDDD),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Center(
                          child: Text(
                            "V",
                            style: TextStyle(
                                color: Color(0xff1D1C21),
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(4.0),
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            color: Color(0xff8BBC01),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Center(
                            child: Icon(
                          Icons.lightbulb_outline,
                          color: Colors.black87,
                        )),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(4.0),
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            color: Color(0xffDDDDDD),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Center(
                          child: Text(
                            "A",
                            style: TextStyle(
                                color: Color(0xff1D1C21),
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(4.0),
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            color: Color(0xffDDDDDD),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Center(
                          child: Text(
                            "F",
                            style: TextStyle(
                                color: Color(0xff1D1C21),
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(4.0),
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            color: Color(0xffDDDDDD),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Center(
                          child: Text(
                            "N",
                            style: TextStyle(
                                color: Color(0xff1D1C21),
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(4.0),
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            color: Color(0xffDDDDDD),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Center(
                          child: Text(
                            "D",
                            style: TextStyle(
                                color: Color(0xff1D1C21),
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(4.0),
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            color: Color(0xffDDDDDD),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Center(
                          child: Text(
                            "E",
                            style: TextStyle(
                                color: Color(0xff1D1C21),
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(4.0),
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            color: Color(0xffDDDDDD),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Center(
                          child: Text(
                            "Y",
                            style: TextStyle(
                                color: Color(0xff1D1C21),
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(4.0),
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            color: Color(0xff8BBC01),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Center(
                            child: Icon(
                          Icons.lightbulb_outline,
                          color: Colors.black87,
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
