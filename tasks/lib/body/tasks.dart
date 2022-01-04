import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart' as path;
import 'package:tasks/db/task.dart';
import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;

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
    // Create an absolute path to databse
    const String databaseName = 'tasks.db';
    String databasePath;
    // SQL command literal
    const String initSQL =
        'CREATE TABLE tasks (id INTEGER PRIMARY KEY, text TEXT, priority INTEGER)';

    if (Platform.isWindows || Platform.isLinux) {
      databasePath = path.join(Directory.current.path, 'data');
      debugPrint(databasePath);
      // Directory(databasePath).create();

      // Initialize FFI
      sqflite_ffi.sqfliteFfiInit();
      // Change the default factory
      sqflite.databaseFactory = sqflite_ffi.databaseFactoryFfi;
    } else {
      databasePath = sqflite.getDatabasesPath() as String;
    }

    final String pathToDb = path.join(databasePath, databaseName);

    // Open or connect database
    final Future<sqflite.Database> database = sqflite.openDatabase(pathToDb,
        onCreate: (sqflite.Database db, int version) async {
      await db.execute(initSQL);
    });

    Future<void> insertTask(Task memo) async {
      final sqflite.Database db = await database;
      await db.insert(
        'tasks',
        memo.toMap(),
        conflictAlgorithm: sqflite.ConflictAlgorithm.replace,
      );
    }

    Future<List<Task>> getTasks() async {
      final sqflite.Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query('memo');
      return List.generate(maps.length, (i) {
        return Task(
          id: maps[i]['id'],
          text: maps[i]['text'],
          priority: maps[i]['priority'],
        );
      });
    }

    final todo = Task(
      id: 0,
      text: 'Flutterで遊ぶ',
      priority: 1,
    );

    insertTask(todo);
    List<Task> tasks = getTasks() as List<Task>;

    /*final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);*/

    return ReorderableListView(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      children: <Widget>[
        for (int index = 0; index < _items.length; index++)
          /*ListTile(
            key: Key('$index'),
            tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
            title: Text('Item ${_items[index]}'),
            subtitle: TextButton(
              child: const Text("stateless page link"),
              onPressed: () {
                Navigator.pushNamed(context, '/list');
              },
            ),
            isThreeLine: true,
          )*/
          TaskBox(
            key: Key('$index'),
            thumbnail: Container(
              decoration: const BoxDecoration(color: Colors.pink),
            ),
            title: 'Flutter 1.0 Launch',
            subtitle: 'Flutter continues to improve and expand its horizons. '
                'This text should max out at two lines and clip',
            author: 'Dash',
            publishDate: 'Dec 28',
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
