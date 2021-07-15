import 'dart:convert';

import 'package:http/http.dart' as http;

import '../news_Info.dart';

// ignore: camel_case_types
class API_Manager {
  static Future<NewsModel> getNews() async {
    var client = http.Client();
    List<Article> initialList = [];
    var newsModel =
        NewsModel(status: "Failed", totalResults: 0, articles: initialList);

    try {
      print("Start response");
      // var response = await client.get(Uri.http(
      //   "https://jsonplaceholder.typicode.com",
      //   "/posts",
      // ));
      var url = Uri.parse(
          'http://newsapi.org/v2/everything?domains=wsj.com&apiKey=33c59d429ab943009161b3bbe68e2a37');
      var response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        print(jsonString);
        newsModel = NewsModel.fromJson(jsonMap);
        print(newsModel.totalResults);
      }
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }
}
