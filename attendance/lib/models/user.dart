class User {
  late String name;
  late String department;
  late String employeeId;
  User(
    this.name,
    this.department,
    this.employeeId,
  );
  User.fromMap(Map<String, dynamic> json) {
    name = json['name'];
    department = json['department'];
    employeeId = json['employeeId'];
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'department': department,
        'employeeId': employeeId,
      };
}
