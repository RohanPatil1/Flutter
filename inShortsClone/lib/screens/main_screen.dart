import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indianews18/data_model/article_scopedmodel.dart';
import 'package:indianews18/db_helper/db_helper.dart';
import 'package:indianews18/screens/saved_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pgCtrl = PageController();
  List<Map<String, dynamic>> articlesList;
  List<Map<String, dynamic>> articlesListQ;
  ScrollController scrollController = ScrollController();
  bool isTapped = false;
  Color titleColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ArticleScopedModel>(
      builder: (context, child, model) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isTapped) {
                      isTapped = false;
                    } else {
                      isTapped = true;
                    }
                  });
                },
                child: model.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : PageView.builder(
                        onPageChanged: (v) {
                          print(v);
                        },
                        controller: pgCtrl,
                        itemCount: model.articles.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                    flex: 4,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              model.articles[index].urlToImage),
                                        ),
                                      ),
                                    )),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.topCenter,
                                    margin: EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        GestureDetector(
                                          onDoubleTap: () async {
                                            print("========INSERT TITLE : " +
                                                model.articles[index].title);
                                            int i = await DatabaseHelper
                                                .instance
                                                .insertNews({
                                              DatabaseHelper.columnName: model
                                                  .articles[index].source.name,
                                              DatabaseHelper.columnUrlToImage:
                                                  model.articles[index]
                                                      .urlToImage,
                                              DatabaseHelper.columnUrl:
                                                  model.articles[index].url,
                                              DatabaseHelper.columnTitle:
                                                  model.articles[index].title,
                                              DatabaseHelper.columnPublishedAt:
                                                  model.articles[index]
                                                      .publishedAt,
                                              DatabaseHelper.columnDescrip:
                                                  model.articles[index]
                                                      .description,
                                              DatabaseHelper.columnContent:
                                                  "CONTENT",

                                            });

                                            print("Inserted ID : $i");

                                            setState(() {
                                              titleColor = Colors.blueAccent;
                                            });

                                            print("FETCHING ARTICLES QUERY");
                                            articlesListQ = await DatabaseHelper
                                                .instance
                                                .queryNews();
                                          },
                                          child: Text(
                                            model.articles[index].title,
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    color: titleColor,
                                                    letterSpacing: .5,
                                                    fontSize: 20.0)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Text(
                                          model.articles[index].description,
                                          style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16.0)),
                                          maxLines: 6,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Text(
                                          "Source : " +
                                              model.articles[index].source.name,
                                          style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.0)),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              AnimatedPositioned(
                top: isTapped ? 0.0 : -80,
                left: 0.0,
                right: 0.0,
                duration: Duration(milliseconds: 300),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    //          alignment: Alignment.center,

                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
//                  crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 12.0, left: 8.0, right: 8.0),
                            child: Text(
                              "Discover",
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 8.0, right: 8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "My Feed",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 4.0),
                                  height: 3.0,
                                  width: 30.0,
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, left: 8.0, right: 8.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.file_download,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () async {
                                await Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return SavedScreen(
                                    articlesListQ: articlesListQ,
                                  );
                                }));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                bottom: isTapped ? 0.0 : -80,
                duration: Duration(milliseconds: 300),
                left: 0.0,
                right: 0.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width,
                    //          alignment: Alignment.center,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          top: BorderSide(color: Colors.grey, width: 0.3)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
//                  crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 12.0, left: 8.0, right: 8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.info,
                                  color: Colors.blueAccent,
                                  size: 24,
                                ),
                                Text(
                                  "Relevance",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 12.0, left: 8.0, right: 8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.share,
                                  color: Colors.blueAccent,
                                  size: 24,
                                ),
                                Text(
                                  "Share",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 12.0, left: 8.0, right: 8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.bookmark,
                                  color: Colors.blueAccent,
                                  size: 24,
                                ),
                                Text(
                                  "Bookmark",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
