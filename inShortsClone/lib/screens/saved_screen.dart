import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indianews18/data_model/news_data.dart';
import 'package:indianews18/db_helper/db_helper.dart';

class SavedScreen extends StatelessWidget {
  final List<Map<String, dynamic>> articlesListQ;

  const SavedScreen({Key key, this.articlesListQ}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          title: Text(
            "Offline Mode",
            style: GoogleFonts.lato(
                textStyle: TextStyle(
                    color: Colors.white, letterSpacing: .5, fontSize: 20.0)),
          ),
        ),
        body: ListView.builder(
          itemCount: articlesListQ.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> article = articlesListQ[index];
            var _list = article.values.toList();
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
//                          image: AssetImage("assets/img.jpg")
                            image: NetworkImage(_list[7].toString()),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _list[5].toString(),
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Colors.black87,
                                    letterSpacing: .5,
                                    fontSize: 20.0)),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            _list[2].toString(),
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
                            "Source : " + _list[3].toString(),
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
        ));
  }
}
