import 'package:flutter/material.dart';

class StatelessPage extends StatefulWidget {
  const StatelessPage({Key? key}) : super(key: key);

  @override
  State<StatelessPage> createState() => _StatelessPageState();
}

class _StatelessPageState extends State<StatelessPage> {
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
