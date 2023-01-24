import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abdullah Test',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<Page> _pages = [
    Page('Thing 1', Icons.beach_access_sharp),
    Page('Thing 2', Icons.airplane_ticket_outlined),
    Page('Thing 3', Icons.card_giftcard_rounded),
  ];

  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPageIndex = 0;

  void _openPage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  Widget _getGameByIndex(int index) {
    switch (index) {
      case 0:
        return Thing1Game();
      case 1:
        return Thing2Game();
      case 2:
        return Thing3Game();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerItemWidgets = widget._pages
        .asMap()
        .map((int index, Page page) => MapEntry<int, Widget>(
            index,
            ListTile(
              title: Text(page.title),
              leading: Icon(page.iconData),
              selected: _currentPageIndex == index,
              onTap: () {
                _openPage(index);
                Navigator.pop(context);
              },
            )))
        .values
        .toList();
    drawerItemWidgets.insert(
      0,
      DrawerHeader(
        child: Text('The button to open what is already on the navbar'),
        decoration: BoxDecoration(
          color: Colors.teal,
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Abdullah Test"),
      ),
      body: Center(
        child: _getGameByIndex(_currentPageIndex),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: drawerItemWidgets,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        items: widget._pages
            .map((Page page) => BottomNavigationBarItem(
                  icon: Icon(page.iconData),
                  label: page.title,
                ))
            .toList(),
        onTap: _openPage,
      ),
    );
  }
}

class Page {
  final String title;
  final IconData iconData;
  Page(this.title, this.iconData);
}

class Thing1Game extends StatefulWidget {
  @override
  _Thing1GameState createState() => _Thing1GameState();
}

class _Thing1GameState extends State<Thing1Game> {
  int _score = 0;

  void _incrementScore() {
    setState(() {
      _score++;
    });
  }

  void _uncrementScore() {
    setState(() {
      _score--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Score: $_score'),
        RaisedButton(
          child: Text('Add Number'),
          onPressed: _incrementScore,
        ),
        RaisedButton(
          child: Text('Subtract Number'),
          onPressed: _uncrementScore,
        ),
      ],
    );
  }
}

class Thing2Game extends StatefulWidget {
  @override
  _Thing2GameState createState() => _Thing2GameState();
}

class _Thing2GameState extends State<Thing2Game> {
  int _countdown = 10;
  Timer? _timer;
  bool _isRunning = false;

  _Thing2GameState() {
    _timer = null;
  }
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _countdown--;
        if (_countdown == 0) {
          _timer!.cancel();
          _timer = null;
        }
      });
    });
    setState(() {
      _isRunning = true;
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
      setState(() {
        _isRunning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Countdown: $_countdown'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter countdown',
            ),
            onChanged: (text) {
              _countdown = int.parse(text);
            },
          ),
        ),
        _isRunning
            ? RaisedButton(
                child: Text('Stop Timer'),
                onPressed: _stopTimer,
              )
            : RaisedButton(
                child: Text('Start Timer'),
                onPressed: _startTimer,
              ),
      ],
    );
  }
}

class Thing3Game extends StatefulWidget {
  @override
  _Thing3GameState createState() => _Thing3GameState();
}

class _Thing3GameState extends State<Thing3Game> {
  int _randomNumber = 0;

  void _generateRandomNumber() {
    setState(() {
      _randomNumber = Random().nextInt(100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Random Number: $_randomNumber'),
        RaisedButton(
          child: Text('Generate Random Number'),
          onPressed: _generateRandomNumber,
        ),
      ],
    );
  }
}
