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
  int listSize = 0;
  String topText = "";
  String bottomText = "";
  int know = 0;
  int forgot = 0;
  bool firstTime = true;
  bool showEng = true;

  void _successGoNext() {
    setState(() {
      count += 1;
      know += 1;
      _getNewItems();
    });
  }

  void _notSuccessGoNext() {
    setState(() {
      forgot += 1;
      words.add(words[count]);
      count += 1;
      _getNewItems();
    });
  }

  void _changeLanguage() {
    setState(() {
      showEng = !showEng;
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
    listSize = words.length;
    if (count < listSize) {
      if (showEng) {
        topText = words[count].eng.toLowerCase();
      } else {
        topText = words[count].ru.toLowerCase();
      }
      bottomText = "";
    } else {
      topText = "Thats all";
      bottomText = "Thats all";
    }
  }

  void _setRusText() {
    setState(() {
      if (bottomText == "") {
        if (showEng) {
          bottomText = words[count].ru.toLowerCase();
        } else {
          bottomText = words[count].eng.toLowerCase();
        }
      } else {
        bottomText = "";
      }
    });
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '$know / $forgot',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      OutlineButton(
                        child: Text("Change language"),
                        onPressed: _changeLanguage,
                      ),
                      Text(
                        '$count / $listSize',
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ])),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            topText,
                            textScaleFactor: 1.5,
                            style: Theme.of(context).textTheme.bodyText1,
                          ))),
                  Card(
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            bottomText,
                            textScaleFactor: 1.5,
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
                ])
          ],
        ),
      ),
    );
  }
}
