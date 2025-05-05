import 'package:flutter/material.dart';
import 'package:todo/components/todo_item.dart';
import 'package:todo/types/todo_task.dart';

const colors = [
  Color.fromARGB(255, 225, 0, 0),
  Color.fromARGB(255, 255, 100, 0),
  Color.fromARGB(255, 230, 180, 0),
  Color.fromARGB(255, 0, 200, 0),
  Color.fromARGB(255, 0, 100, 255),
  Color.fromARGB(255, 150, 0, 255),
  Color.fromARGB(255, 255, 0, 150),
];

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final List<TodoTask> todoTasks = [];

  void onPressed() {
    int index = todoTasks.length;
    setState(() {
      todoTasks.add(
        TodoTask(
          title: "",
          description: "Description",
          color: colors.elementAt(index % colors.length),
          createdAt: DateTime.now(),
        ),
      );
    });
  }

  void _updateTodoTask(int index, TodoTask updatedTask) {
    setState(() {
      todoTasks[index] = updatedTask;
    });

    // Future: Add logic here to update the database or local storage
    // Example: await database.updateTodoTask(updatedTask);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: todoTasks.length,
              itemBuilder:
                  (context, index) => TodoItem(
                    todoTask: todoTasks[index],
                    onChange:
                        (updatedTask) => _updateTodoTask(index, updatedTask),
                  ),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(onPressed: onPressed, child: const Text("Add Todo")),
        ],
      ),
    );
  }
}
