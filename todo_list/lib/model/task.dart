class Task {
  String? name;
  bool isDone;
  Task({this.isDone = false, this.name = 'This Is a Task'});
  void toggleDone() {
    isDone = !isDone;
  }
}
