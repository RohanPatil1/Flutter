import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:triveous_task/data_model/article_scopedmodel.dart';
import 'package:triveous_task/data_model/news_data.dart';
import 'package:triveous_task/screens/web_content_screen.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  PageController pgCtrl = PageController();
  List<Article> articleLists;
  ScrollController scrollController = ScrollController();
  bool isTapped = false;
  Color titleColor = Colors.black;
  TabController tabController;
  String currSource = "Hindustan Times";

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(vsync: this, length: 10);

    super.initState();
  }

  String value = "0";
  List<String> sources = [
    "Hindustan Times",
    "Livemint",
    "The Times of India",
    "Moneycontrol",
    "TechRadar",
    "News18",
    "NDTV News",
    "InsideSport",
    "The Hindu",
    "Zoom"
  ];

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ArticleScopedModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            leading: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            title: Text("News App"),
            bottom: TabBar(
              controller: tabController,
              isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              onTap: (index) {
                setState(() {
                  value = index.toString();
                  currSource = sources[index];
//                  model.getData();
                  model.sortData(currSource);
                });
              },
              tabs: <Widget>[
                Tab(
                  child: Container(
                    child: Text("Hindustan Times"),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text("Livemint"),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text("The Times of India"),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text("Moneycontrol"),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text("Tech Radar"),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text("News18"),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text("NDTV News"),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text("InsideSport"),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text("The Hindu"),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text("Zoom"),
                  ),
                ),
              ],
            ),
          ),
          body: model.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Container(
                  child: ListView.builder(
                    itemCount: model.articles.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return WebContent(
                              url: model.articles[index].url,
                            );
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 1.0,
                                        blurRadius: 3.0)
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0))),
                              margin: EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16.0)),
                                    child: Image.network(
                                      model.articles[index].urlToImage,
                                      width: MediaQuery.of(context).size.width,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      model.articles[index].title,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      model.articles[index].description,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Time :" +
                                          model.articles[index].publishedAt,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )),
        );
      },
    );
  }
}
