import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_bloc_tutorial/news_Info.dart';
import 'package:my_bloc_tutorial/news_bloc.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final newsBloc = NewsBloc();
  @override
  void initState() {
    print("Go");
    newsBloc.eventNewsSink.add(NewsAction.Fetch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News list"),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<List<Article>>(
          stream: newsBloc.newsStream,
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasError) {
              var error = snapshot.error ?? "Error";
              return Center(
                child: Text(
                  error.toString(),
                ),
              );
            }
            if (snapshot.hasData)
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var article = snapshot.data![index];
                  print(article);
                  var formattedTime =
                      DateFormat('dd MMM - HH:mm').format(article.publishedAt);
                  return Container(
                    height: 100,
                    margin: const EdgeInsets.all(8),
                    child: Row(
                      children: <Widget>[
                        Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                article.urlToImage,
                                fit: BoxFit.cover,
                              )),
                        ),
                        SizedBox(width: 16),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(formattedTime),
                              Text(
                                article.title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                article.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            return Container();
          }),
    );
  }
}
