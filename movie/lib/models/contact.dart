class Contact {
  late String name;
  late String phone;
  late String lastMessage;
  late int unreadMessage;
  late String time;
  Contact(
      this.name, this.phone, this.lastMessage, this.unreadMessage, this.time);
  Contact.fromMap(Map<String, dynamic> json) {
    name = json['cname'];
    phone = json['cnum'];
    lastMessage = json['lmessage'];
    unreadMessage = json['unreadCount'];
    time = json['lmessageTime'];
  }

  Map<String, dynamic> toMap() => {
        'cname': name,
        'cnum': phone,
        'lmessage': lastMessage,
        'unreadCount': unreadMessage,
        'lmessageTime': time
      };
}
