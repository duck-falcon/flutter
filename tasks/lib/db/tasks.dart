import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';
import '../const/db.dart';

class TasksDb {
  static Future<Database> openDb() async {
    return await openDatabase(
      join(await getDatabasesPath(), taskFileName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $taskTableName(id INTEGER PRIMARY KEY, title TEXT, text TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> create(Task task) async {
    var db = await openDb();
    await db.insert(
      taskTableName,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Task>> read() async {
    var db = await openDb();
    final List<Map<String, dynamic>> maps = await db.query(taskTableName);
    return List.generate(maps.length, (index) {
      return Task(
          id: maps[index]['id'],
          title: maps[index]['title'],
          text: maps[index]['text']);
    });
  }

  static Future<void> update(Task task) async {
    var db = await openDb();
    await db.update(
      taskTableName,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
    db.close();
  }

  static Future<void> delete(int id) async {
    var db = await openDb();
    await db.delete(
      taskTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
