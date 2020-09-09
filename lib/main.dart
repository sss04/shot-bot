import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Shyam\'s Shot Counter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _makeCounter = 0;
  int _missCounter = 0;
  bool justMissed = false;
  var percentages = <double>[];
  var start = DateTime.now();

  void _showMissDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Can't end session on a miss"),
              content: Text("C'mon man."));
        });
  }

  Future<Null> _showEndDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Good session!"),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      width: 300.0,
                      height: 100.0,
                      child: Sparkline(
                        data: percentages,
                      )),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('$_makeCounter',
                            style:
                                TextStyle(fontSize: 24, color: Colors.green)),
                        Text('$_missCounter',
                            style: TextStyle(fontSize: 24, color: Colors.red))
                      ]),
                  Text(
                      "Percentage: " +
                          (_makeCounter / (_makeCounter + _missCounter) * 100)
                              .toStringAsFixed(3) +
                          "%",
                      style: TextStyle(fontSize: 24, color: Colors.black)),
                  Text(
                      "Total Shots: " +
                          (_makeCounter + _missCounter).toString(),
                      style: TextStyle(fontSize: 24, color: Colors.black)),
                      Text(
                      "Elapsed Time: " +
                          (DateTime.now().difference(start).inMinutes.toString()) + " mins",
                      style: TextStyle(fontSize: 24, color: Colors.black))
                ],
              ));
        });
  }

  void _incrementMakeCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _makeCounter++;
      justMissed = false;
      percentages.add(_makeCounter / (_makeCounter + _missCounter) * 100);
    });
  }

  void _incrementMissCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _missCounter++;
      justMissed = true;
      percentages.add(_makeCounter / (_makeCounter + _missCounter) * 100);
    });
  }

  void _clearCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _makeCounter = 0;
      _missCounter = 0;
      start = DateTime.now();
    });
  }

  void _stats() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (justMissed) {
        _showMissDialog();
      } else if (_missCounter + _makeCounter == 0) {
      } else {
        _showEndDialog();
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
    double percentage = _makeCounter / (_makeCounter + _missCounter) * 100;
    int totalShots = _makeCounter + _missCounter;
    if (totalShots == 0) {
      percentage = 0.000;
    }
    Color elColor = Colors.green;
    if (percentage > 50) {
      elColor = Colors.green;
    } else if (percentage > 30) {
      elColor = Colors.orange;
    } else {
      elColor = Colors.red;
    }
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    height: 170.0,
                    width: 170.0,
                    child: Container(
                        color: Colors.green,
                        child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: _incrementMakeCounter,
                            color: Colors.white))),
                SizedBox(
                    height: 170.0,
                    width: 170.0,
                    child: Container(
                        color: Colors.red,
                        child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: _incrementMissCounter,
                            color: Colors.white)))
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('$_makeCounter',
                      style: TextStyle(fontSize: 72, color: Colors.green)),
                  Text('$_missCounter',
                      style: TextStyle(fontSize: 72, color: Colors.red))
                ]),
            Card(
                child: Text(percentage.toStringAsFixed(3) + "%",
                    style: TextStyle(fontSize: 72, color: elColor))),
            Card(
                child: Text("Total Shots: " + totalShots.toString(),
                    style: TextStyle(fontSize: 48, color: Colors.black)))
          ],
        ),
      ),
      floatingActionButton: Row(mainAxisAlignment: MainAxisAlignment.spaceAround ,children: <Widget>[
        Spacer(flex: 8),
        FloatingActionButton(
          onPressed: _stats,
          tooltip: 'Show Stats',
          child: Icon(Icons.assessment),
        ),
        Spacer(flex: 1,),
        FloatingActionButton(
          onPressed: _clearCounter,
          tooltip: 'Clear Counter',
          child: Icon(Icons.autorenew),
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endTop, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
