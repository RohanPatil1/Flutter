import 'package:indianews18/data_model/news_data.dart';
import 'package:indianews18/utils/api_utils.dart';
import 'package:scoped_model/scoped_model.dart';

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
    _isLoading = false;
    notifyListeners();
  }

  getDataBySearch(search) async {
    _isLoading = true;
    notifyListeners();
    print("===================SEARCHING NEWS FOR :" + search);
    ApiUtils _apiUtils = ApiUtils();
    NewsData newsData = await _apiUtils.fetchNewsDataBySearch(search);
    _articles = newsData.articles;
    _isLoading = false;
    notifyListeners();
  }
}
