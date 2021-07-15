import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:my_bloc_tutorial/services/api_management.dart';

import 'news_Info.dart';

enum NewsAction {
  Fetch,
  Delete,
}

class NewsBloc {
  StreamController<List<Article>> _stateNewsStreamController =
      new StreamController<List<Article>>();
  StreamSink<List<Article>> get newsSink => _stateNewsStreamController.sink;
  Stream<List<Article>> get newsStream => _stateNewsStreamController.stream;

  StreamController<NewsAction> _eventNewsStreamController =
      new StreamController<NewsAction>();
  StreamSink<NewsAction> get eventNewsSink => _eventNewsStreamController.sink;
  Stream<NewsAction> get eventNewsStream => _eventNewsStreamController.stream;

  NewsBloc() {
    eventNewsStream.listen((event) async {
      if (event == NewsAction.Fetch) {
        try {
          print("Ready to get news");
          var news = await API_Manager.getNews();
          print(news);
          if (news != null)
            newsSink.add(news.articles);
          else
            newsSink.addError("Something wrong");
        } on Exception catch (e) {
          newsSink.addError("Something wrong");
        }
      } else {}
    });
  }

  void dispose() {
    _eventNewsStreamController.close();
    _stateNewsStreamController.close();
  }
}
