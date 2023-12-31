import 'package:flutter/material.dart';

class TasksTile extends StatelessWidget {
  final bool isChecked;
  final String? taskTitle;
  final void Function(bool?) toggleTask;
  final VoidCallback onLongPress;

  const TasksTile(
      {super.key,
      this.isChecked = false,
      this.taskTitle = 'This is a task',
      required this.toggleTask,
      required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: onLongPress,
      leading: Text(
        '$taskTitle',
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
          fontSize: 20,
        ),
      ),
      trailing: Checkbox(
        checkColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: toggleTask,
      ),
    );
  }
}
