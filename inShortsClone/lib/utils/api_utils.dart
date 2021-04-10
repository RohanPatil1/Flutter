import 'dart:convert';
import 'package:dio/dio.dart' as http_dio;
import 'package:indianews18/data_model/news_data.dart';

class ApiUtils {
  http_dio.Dio dio = http_dio.Dio();

    fetchNewsData() async {
    final key = "3c306b27306041a2a1b8564dd048044c";
    http_dio.Response response = await dio
        .get("https://newsapi.org/v2/top-headlines?country=in&apiKey=$key");
    print("Printing Response ===================");
    print(response);
    if (response.statusCode == 200) {
      print("200 RESPONSE");
      return NewsData.fromJson(json.decode(json.encode(response.data)));
    } else {
      print("[FAILED]RESPONSE CODE : " + response.statusCode.toString());
      return null;
    }
  }
  fetchNewsDataBySearch(String search) async {
    final key = "3c306b27306041a2a1b8564dd048044c";
    http_dio.Response response = await dio
        .get("https://newsapi.org/v2/everything?q=$search&apiKey=$key");
    print("Printing Response ===================");
    print(response);
    if (response.statusCode == 200) {
      print("200 RESPONSE");
      return NewsData.fromJson(json.decode(json.encode(response.data)));
    } else {
      print("[FAILED]RESPONSE CODE : " + response.statusCode.toString());
      return null;
    }
  }
}
