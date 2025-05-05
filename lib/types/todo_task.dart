import 'package:flutter/material.dart';

class TodoTask {
  final String title;
  final String description;
  final Color color;
  final DateTime createdAt;
  final bool isCompleted;

  TodoTask({
    required this.title,
    required this.description,
    required this.color,
    required this.createdAt,
    this.isCompleted = false,
  });

  // Add a copyWith method
  TodoTask copyWith({
    String? title,
    String? description,
    Color? color,
    DateTime? createdAt,
    bool? isCompleted,
  }) {
    return TodoTask(
      title: title ?? this.title,
      description: description ?? this.description,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
