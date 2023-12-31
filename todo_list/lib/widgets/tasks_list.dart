import 'package:flutter/material.dart';
import 'tasks_tile.dart';
import 'package:provider/provider.dart';
import '../model/task_data.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return TasksTile(
              taskTitle: task.name,
              isChecked: task.isDone,
              toggleTask: (bool? value) {
                taskData.updateIsChecked(task);
              },
              onLongPress: () {
                taskData.deleteTask(task);
              },
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
