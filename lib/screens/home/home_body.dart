import 'package:flutter/material.dart';
import 'package:todo/components/todo_item.dart';

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
  void onPressed() {
    int index = todoItems.length;
    Color getItemColor = colors.elementAt(index % colors.length);
    setState(() {
      todoItems.add(
        TodoItem(title: "Todo ${todoItems.length + 1}", color: getItemColor),
      );
    });
  }

  final List<TodoItem> todoItems = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: todoItems.length,
              itemBuilder: (context, index) => todoItems[index],
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
