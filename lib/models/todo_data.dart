import 'dart:convert';
import 'dart:io';
import '../types/todo_task.dart';

class TodoData {
  final Map<String, List<TodoTask>> _data = {};

  Future<File> _getDatabaseFile() async {
    // final directory = await getApplicationDocumentsDirectory();
    return File('./data/todo_data.json');
  }

  Future<void> _loadData() async {
    final file = await _getDatabaseFile();
    if (await file.exists()) {
      final content = await file.readAsString();
      final jsonData = json.decode(content) as Map<String, dynamic>;
      _data.clear();
      jsonData.forEach((date, tasks) {
        _data[date] =
            (tasks as List)
                .map(
                  (task) => TodoTask(
                    title: task['title'],
                    description: task['description'],
                    color: task['color'],
                    createdAt: DateTime.parse(task['createdAt']),
                    isCompleted: task['isCompleted'],
                  ),
                )
                .toList();
      });
    }
  }

  Future<void> _saveData() async {
    final file = await _getDatabaseFile();
    final jsonData = _data.map(
      (date, tasks) => MapEntry(
        date,
        tasks
            .map(
              (task) => {
                'title': task.title,
                'description': task.description,
                'color': task.color.toARGB32(),
                'createdAt': task.createdAt.toIso8601String(),
                'isCompleted': task.isCompleted,
              },
            )
            .toList(),
      ),
    );
    await file.writeAsString(json.encode(jsonData));
  }

  Future<List<TodoTask>> getTasks(String date) async {
    await _loadData();
    return _data[date] ?? [];
  }

  Future<void> addTask(String date, TodoTask task) async {
    final today = DateTime.now();
    if (DateTime.parse(
      date,
    ).isBefore(DateTime(today.year, today.month, today.day))) {
      throw Exception("Cannot add tasks to past dates.");
    }
    await _loadData();
    _data.putIfAbsent(date, () => []);
    _data[date]!.add(task);
    await _saveData();
  }

  Future<void> updateTask(String date, int taskId, TodoTask updatedTask) async {
    await _loadData();
    if (_data.containsKey(date) &&
        taskId >= 0 &&
        taskId < _data[date]!.length) {
      _data[date]![taskId] = updatedTask;
      await _saveData();
    } else {
      throw Exception("Task not found for the given date and ID.");
    }
  }
}
