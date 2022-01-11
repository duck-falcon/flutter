import 'package:flutter/material.dart';
import '../db/tasks.dart';

class TasksNotifier extends ChangeNotifier {
  final List<Task> _tasks = [];

  TasksNotifier() {
    syncDb();
  }

  void syncDb() async {
    TasksDb.read().then((val) {
      // 将来的にリストの入れ替えを反映するように model 変更してこの sort を入れるようにしないといかん
      // val.sort((a, b) => a.pokeId.compareTo(b.pokeId));
      _tasks.clear();
      _tasks.addAll(val);
      for (int index = 0; index < val.length; index++) {
        debugPrint(val[index].title);
        debugPrint(val[index].text);
        debugPrint("hello$index");
      }
    });
    notifyListeners();
  }

  List<Task> get tasks => _tasks;

  void toggle(Task task) {
    if (isExist(task.id)) {
      delete(task.id);
    } else {
      add(task);
    }
  }

  bool isExist(int id) {
    if (_tasks.indexWhere((task) => task.id == id) < 0) {
      return false;
    }
    return true;
  }

  void add(Task task) async {
    await TasksDb.create(task);
    syncDb();
  }

  void delete(int id) async {
    await TasksDb.delete(id);
    syncDb();
  }
}

class Task {
  final int id;
  final String text;
  final String title;

  Task({required this.id, required this.title, required this.text});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'title': title,
    };
  }
}
