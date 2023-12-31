import 'package:flutter/foundation.dart';
import 'task.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<Task> _tasks = [
    Task(name: 'Task 1', isDone: false),
    Task(name: 'Task 2', isDone: true),
    Task(name: 'Task 3', isDone: false),
  ];
  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  void addData(String? data) {
    _tasks.add(Task(name: data));
    notifyListeners();
  }

  void updateIsChecked(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  int get taskCount {
    return _tasks.length;
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
