import 'package:flutter/material.dart';
import 'package:owllangu/words_view_model.dart';

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
  final model = WordsViewModel.instance;

  void _successGoNext() {
    setState(() {
      model.successGoNext();
    });
  }

  void _notSuccessGoNext() {
    setState(() {
      model.notSuccessGoNext();
    });
  }

  void _changeLanguage() {
    setState(() {
      model.changeLanguage();
    });
  }

  void _revert() {
    setState(() {
      model.revert();
    });
  }

  void _init() async {
    var a = await model.init();
    setState(() {
      a;
    });
  }

  void _showTranslation() {
    setState(() {
      model.showTranslation();
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    print (" Widget build, model.showEng:= ${model.showEng}");
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
                        "${model.know} / ${model.forgot}",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      OutlineButton(
                        child: Text("Change language"),
                        onPressed: _changeLanguage,
                      ),
                      OutlineButton(
                        child: Text("Revert"),
                        onPressed: _revert,
                      ),
                      Text(
                        '${model.count} / ${model.listSize}',
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
                            "${model.topText}",
                            textScaleFactor: 1.5,
                            style: Theme.of(context).textTheme.bodyText1,
                          ))),
                  Text(
                    '${model.currentStats}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Card(
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "${model.bottomText}",
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
                        onPressed: _showTranslation,
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
