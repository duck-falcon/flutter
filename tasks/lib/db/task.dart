import 'package:flutter/material.dart';

class Task {
  final int id;
  final String text;
  final int priority;

  Task({required this.id, required this.text, required this.priority});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'priority': priority,
    };
  }
}
