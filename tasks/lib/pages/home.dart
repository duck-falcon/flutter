import 'package:flutter/material.dart';
import 'package:tasks/body/home_body.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _anivFlag = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ])),
      body: const HomeBody(),
    );
  }
}
