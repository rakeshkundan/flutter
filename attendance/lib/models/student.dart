class Student {
  final String name;
  final String scholarNumber;
  bool isPresent;
  Student({
    required this.name,
    required this.scholarNumber,
    this.isPresent = true,
  });
}
