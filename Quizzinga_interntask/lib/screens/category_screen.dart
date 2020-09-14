import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzinga/data_model/category_model.dart';
import 'package:quizzinga/repository/utils_repository.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  UtilsRepository _utilsRepository = UtilsRepository();

  @override
  void initState() {
    _utilsRepository.fetchCategoryList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1C1B20),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            color: Color(0xff8691A2),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Categories",
          style: TextStyle(
            color: Color(0xff7A7C7E),
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
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
          future: _utilsRepository.fetchCategoryList,
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
                  return CategoryBuildList(
                    categoryData: snapshot.data,
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

class CategoryBuildList extends StatelessWidget {
  final categoryData;

  const CategoryBuildList({Key key, this.categoryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: categoryData.length,
      itemBuilder: (BuildContext context, int index) {
        return CategoryCard(
          category: categoryData[index],
        );
      },
      staggeredTileBuilder: (index) =>
          StaggeredTile.count(1, index.isEven ? 1.2 : 1.2),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 1.0,
    ));
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      margin: EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.5,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            child: Image.network(
              category.image,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(8.0))),
              child: Text(
                category.name,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
