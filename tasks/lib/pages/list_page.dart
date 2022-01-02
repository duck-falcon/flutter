import 'package:flutter/material.dart';
import 'package:tasks/body/tasks.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("StatelesPage"),
      ),
      body: const Tasks(),
    );
  }
}
