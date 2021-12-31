import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/homer': (context) =>
            const MyHomePage(title: 'Flutter Demo Home Page'),
        '/stateless': (context) => const StatelesPage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class StatelesPage extends StatelessWidget {
  const StatelesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("StatelesPage"),
        ),
        body: Center(
            child: Column(children: <Widget>[
          const Text("書き換えしないページ"),
          TextButton(
            child: const Text("home page link"),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          )
        ])));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
