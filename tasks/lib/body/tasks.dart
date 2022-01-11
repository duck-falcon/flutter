import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart' as path;
import '../models/task.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

// task の中身
class _TasksState extends State<Tasks> {
  final List<int> _items = List<int>.generate(50, (int index) => index);

  @override
  Widget build(BuildContext context) {
    debugPrint("kokodayo");
    debugPrint(Provider.of<TasksNotifier>(context).tasks[0].title);
    return /*Consumer<TasksNotifier>(
        builder: (contexts, tasks, child) => */
        Column(
      children: [
        Expanded(
          child: ReorderableListView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            children: <Widget>[
              for (int index = 0;
                  index < Provider.of<TasksNotifier>(context).tasks.length;
                  index++)
                TaskBox(
                  key: Key('$index'),
                  thumbnail: Container(
                    decoration: const BoxDecoration(color: Colors.pink),
                  ),
                  title: Provider.of<TasksNotifier>(context).tasks[index].title,
                  // title: "hello",
                  subtitle:
                      Provider.of<TasksNotifier>(context).tasks[index].text,
                  // subtitle: "world",
                  author: '$index',
                  // publishDate: Provider.of<TasksNotifier>(context).tasks[index].title,
                  publishDate: "nov 28",
                  readDuration: '5 mins',
                ),
            ],
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final int item = _items.removeAt(oldIndex);
                _items.insert(newIndex, item);
              });
            },
          ),
        ),
        const _CreateTask()
      ],
    ) /*)*/;
  }
}

class _CreateTask extends StatefulWidget {
  const _CreateTask({Key? key}) : super(key: key);

  @override
  State<_CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<_CreateTask> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              child: const Text("task_create page link"),
              onPressed: () {
                Navigator.pushNamed(context, '/task_create');
              },
            ),
          ]),
    );
  }
}

class _BoxContents extends StatefulWidget {
  const _BoxContents({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.publishDate,
    required this.readDuration,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  State<_BoxContents> createState() => _BoxContentsState();
}

// task の中身の形式
class _BoxContentsState extends State<_BoxContents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                widget.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                widget.author,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '${widget.publishDate} - ${widget.readDuration}',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// task を入れる箱の指定
class TaskBox extends StatefulWidget {
  const TaskBox({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.publishDate,
    required this.readDuration,
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  State<TaskBox> createState() => _TaskBoxState();
}

class _TaskBoxState extends State<TaskBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, // 箱内部カラー
            border: Border.all(
                color: Colors.blue, //set border color
                width: 3.0), //set border width
            borderRadius: const BorderRadius.all(
                Radius.circular(10.0)), //set rounded corner radius
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                  blurRadius: 10, color: Colors.black, offset: Offset(1, 3))
            ] //make rounded corner of border
            ),
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 0.5, // 付箋 縦:横 = 1:aspectRatio
              child: widget.thumbnail,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _BoxContents(
                  title: widget.title,
                  subtitle: widget.subtitle,
                  author: widget.author,
                  publishDate: widget.publishDate,
                  readDuration: widget.readDuration,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
