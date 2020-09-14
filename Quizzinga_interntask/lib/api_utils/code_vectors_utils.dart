import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as http_dio;
import 'package:quizzinga/data_model/category_model.dart';
import 'package:quizzinga/data_model/question_model.dart';

//These method will be called by the UtilsRepository->Screen(initState())
class ApiUtils {
  http_dio.Dio dio = http_dio.Dio();

  Future<List<Category>> fetchCategories() async {
    http_dio.Response response =
        await dio.get("https://quizapi.codevector.in/quiz/categories/");
    print("PRINTING RESPONSE");
    print(response);
    if (response.statusCode == 200) {
      print("200 RESPONSE");


      final parsed =
          json.decode(jsonEncode(response.data)).cast<Map<String, dynamic>>();

      return parsed.map<Category>((json) => Category.fromJson(json)).toList();
    } else {
      return null;
    }
  }

  Future<List<Question>> fetchQuestions() async {
    http_dio.Response response =
    await dio.get("https://quizapi.codevector.in/quiz/questions/");
//    print("PRINTING RESPONSE");
//    print(response);
    if (response.statusCode == 200) {
      print("200 RESPONSE");

//      List<dynamic> questionsList = List();
//      questionsList = data["results"].map((result) =>   Question.fromJson(result)).toList();

      final parsed =
      json.decode(jsonEncode(response.data["results"])).cast<Map<String, dynamic>>();

      return parsed.map<Question>((json) => Question.fromJson(json)).toList();
    } else {
      return null;
    }
  }
}
