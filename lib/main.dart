import 'package:flutter/material.dart';
import 'package:my_bloc_tutorial/counter_bloc.dart';
import 'package:my_bloc_tutorial/news_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final counterBloc = CounterBloc();

  _MyHomePageState();
  @override
  void dispose() {
    counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc Tutorial"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<int>(
                  stream: counterBloc.counterStream,
                  initialData: 0,
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return Center(
                        child: Text(
                          "${snapshot.data}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50.0,
                              color: Colors.red),
                        ),
                      );
                    if (snapshot.hasError) {
                      print(snapshot.error);
                    }

                    return Container();
                  }),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    child: Icon(Icons.add),
                    backgroundColor: Colors.black,
                    tooltip: "Increment",
                    onPressed: () {
                      counterBloc.eventSink.add(CounterAction.Increment);
                    },
                  ),
                  FloatingActionButton(
                    child: Icon(Icons.remove),
                    backgroundColor: Colors.black,
                    tooltip: "Decrement",
                    onPressed: () {
                      counterBloc.eventSink.add(CounterAction.Decrement);
                    },
                  ),
                  FloatingActionButton(
                    child: Icon(Icons.refresh),
                    tooltip: "Reset",
                    backgroundColor: Colors.black,
                    onPressed: () {
                      counterBloc.eventSink.add(CounterAction.Reset);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
