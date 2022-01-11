import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskCreate extends StatefulWidget {
  const TaskCreate({Key? key}) : super(key: key);

  @override
  State<TaskCreate> createState() => _TaskCreateState();
}

class _TaskCreateState extends State<TaskCreate> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _text = "";
  int _id = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksNotifier>(
        builder: (context, tasks, child) => Scaffold(
            appBar: AppBar(
              title: const Text('Add Task'),
            ),
            body: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "title", // ラベル
                      // hintText: 'Enter your email', // 入力ヒント
                    ),
                    validator: (value) {
                      debugPrint("title value validator: $value");
                      // _formKey.currentState.validate()でコールされる
                      if (value!.isEmpty) {
                        return 'Please enter some text'; // エラー表示のメッセージを返す
                      }
                      return null; // 問題ない場合はnullを返す
                    },
                    onSaved: (value) {
                      debugPrint("title value: $value");
                      // this._formKey.currentState.save()でコールされる
                      _title = value!;
                      debugPrint("title: $_title");
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      /*icon: Icon(Icons.email),
                      border: OutlineInputBorder(), // 外枠付きデザイン
                      filled: true, // fillColorで指定した色で塗り潰し
                      fillColor: Colors.greenAccent,*/
                      labelText: "text",
                      // hintText: 'Enter your email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // this._formKey.currentState.save()でコールされる
                      _text = value!;
                      debugPrint("text value: $value");
                      debugPrint("text: $_text");
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: TextButton(
                      onPressed: () {
                        // 各Fieldのvalidatorを呼び出す
                        if (_formKey.currentState!.validate()) {
                          // 入力データが正常な場合の処理
                          _formKey.currentState!.save();
                          /*debugPrint("title2: $_title");
                          debugPrint("text2: $_text");
                          debugPrint("id: $_id");*/
                          tasks.add(Task(id: tasks.tasks.length, title: _title, text: _text));
                          Navigator.pop(context);
                          // Navigator.pushNamed(context, '/list');
                        }
                      },
                      child: const Text('Add'),
                      // color: Colors.green,
                    ),
                  ),
                ],
              ),
            )));
  }
}
