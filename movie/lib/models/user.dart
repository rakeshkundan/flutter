class User {
  late String name;
  late String about;
  late String phone;
  User(
    this.name,
    this.about,
    this.phone,
  );
  User.fromMap(Map<String, dynamic> json) {
    name = json['name'];
    about = json['about'];
    phone = json['phone'];
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'about': about,
        'phone': phone,
      };
}
