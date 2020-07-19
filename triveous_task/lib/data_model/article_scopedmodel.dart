import 'package:scoped_model/scoped_model.dart';
import 'package:triveous_task/data_model/news_data.dart';
import 'package:triveous_task/utils/api_utils.dart';

class ArticleScopedModel extends Model {
  List<Article> _articles = [];

  List<Article> get articles => _articles;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  getData() async {
    _isLoading = true;
    notifyListeners();

    ApiUtils _apiUtils = ApiUtils();
    NewsData newsData = await _apiUtils.fetchNewsData();
    _articles = newsData.articles;
    List<Article> _sarticles = [];


    for (Article i in articles) {
      print("===========");
     print(i.source.name);
    }

    for (Article i in articles) {
      if (i.source.name == "Hindustan Times") {
        _sarticles.add(i);
      }
    }
    _articles = _sarticles;

    _isLoading = false;
    notifyListeners();
  }

  sortData(String source) async {
    _isLoading = true;
    notifyListeners();

    ApiUtils _apiUtils = ApiUtils();
    NewsData newsData = await _apiUtils.fetchNewsData();
    _articles = newsData.articles;

    List<Article> _sarticles = [];
    for (Article i in articles) {
      if (i.source.name == source) {
        _sarticles.add(i);
      }
    }
    _articles = _sarticles;
    _isLoading = false;
    notifyListeners();
  }

}
