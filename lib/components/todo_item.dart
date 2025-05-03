import 'package:flutter/material.dart';

class TodoItem extends StatefulWidget {
  final String title;
  final Color color;
  const TodoItem({super.key, required this.title, required this.color});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(5),
      ),
      height: 50,
      padding: const EdgeInsets.all(10),
      child: Text(
        widget.title,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
