import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;
  bool _anivFlag = true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      drawer: Drawer(
          child: ListView(children: <Widget>[
        /* コンテナでヘッダ部分を作る */
        SwitchListTile(
          title: const Text('記念日'),
          value: _anivFlag,
          onChanged: (bool value) {
            setState(() {
              _anivFlag = value;
            });
          },
          secondary: const Icon(Icons.favorite, color: Colors.teal),
        ),
        /* SwitichListTileが続く */
        /* Dividerなど他のものが含まれてもOK */
      ])),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              const Text("2番目のテキスト"),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Icon(
                      Icons.favorite,
                      color: Colors.pink,
                      size: 24.0,
                    ),
                    Icon(
                      Icons.audiotrack,
                      color: Colors.green,
                      size: 30.0,
                    ),
                    Icon(
                      Icons.beach_access,
                      color: Colors.blue,
                      size: 36.0,
                    ),
                  ]),
              TextButton(
                child: const Text("stateless page link"),
                onPressed: () {
                  Navigator.pushNamed(context, '/stateless');
                },
              ),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
