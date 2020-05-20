import 'dart:math';

import 'package:flutter/material.dart';
import 'package:owllangu/words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Owl language'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 0;
  String eng = "";
  String rus = "";
  var firstTime = true;

  void _setRusText() {
    setState(() {
      rus = words[count].ru;
    });
  }

  void _successGoNext() {
    setState(() {
      count += 1;
      _getNewItems();
    });
  }

  void _notSuccessGoNext() {
    setState(() {
      count += 1;
      _getNewItems();
    });
  }

  void _init() {
    if (firstTime) {
      words.shuffle(new Random(DateTime.now().millisecondsSinceEpoch));
      _getNewItems();
      firstTime = false;
    }
  }

  void _getNewItems() {
    if (count < words.length) {
      eng = words[count].eng;
      rus = "";
    } else {
      eng = "Thats all";
      rus = "Thats all";
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    _init();
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      eng,
                      style: Theme.of(context).textTheme.bodyText1,
                    ))),
            Card(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      rus,
                      style: Theme.of(context).textTheme.bodyText1,
                    ))),
            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                OutlineButton(
                  child: Text("Show Later"),
                  onPressed: _notSuccessGoNext,
                ),
                OutlineButton(
                  child: Text("Show translation"),
                  onPressed: _setRusText,
                ),
                OutlineButton(
                  child: Text("I know it"),
                  onPressed: _successGoNext,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
