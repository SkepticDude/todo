import 'package:flutter/material.dart';
import 'package:todo/types/todo_task.dart';

class TodoItem extends StatefulWidget {
  final TodoTask todoTask;
  final Function(TodoTask) onChange;

  const TodoItem({super.key, required this.todoTask, required this.onChange});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool isEditing = true;
  late TextEditingController _titleController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todoTask.title);
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _enterEditMode() {
    setState(() {
      isEditing = true;
    });
    // Request focus to the TextField
    _focusNode.requestFocus();
  }

  void _applyChanges() {
    setState(() {
      isEditing = false;
    });
    widget.onChange(widget.todoTask.copyWith(title: _titleController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.todoTask.color,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child:
                isEditing
                    ? Container(
                      padding: const EdgeInsets.all(6),
                      child: TextField(
                        controller: _titleController,
                        focusNode: _focusNode,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter task title",
                          hintStyle: TextStyle(color: Colors.white54),
                        ),
                      ),
                    )
                    : GestureDetector(
                      onTap: _enterEditMode,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          widget.todoTask.title,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
          ),
          isEditing
              ? IconButton(
                icon: const Icon(Icons.check, color: Colors.white),
                onPressed: _applyChanges,
                alignment: Alignment.center,
              )
              : const SizedBox(),
        ],
      ),
    );
  }
}
