import 'package:attendance/models/student.dart';
import 'package:flutter/cupertino.dart';

class StudentDetail extends ChangeNotifier {
  bool allMarkedTrue = false;
  String subjectCode = "";
  String sectionName = '';
  String subjectName = "";

  List<Student> data = [
    Student(
      name: "Rakesh kundan",
      scholarNumber: "211112011",
      isPresent: true,
    ),
  ];
  List<String> absent = [];
  List<Student> get getData => data;
  Future<void> setData(var rawData) async {
    subjectCode = rawData['subCode'];
    sectionName = rawData['section'];
    // print(rawData);
    List<dynamic> detail = rawData['data'];
    data = [];
    for (int i = 0; i < detail.length; i++) {
      data.add(
        Student(
          name: detail[i]['Name of Student'],
          scholarNumber: detail[i]['Scholar No.'].toString(),
        ),
      );
    }
    absent = [];
    notifyListeners();
  }

  bool isPresent(int i) {
    return data[i].isPresent;
  }

  List<String> get absenties => absent;

  Future<void> markAllAbsent(bool? val) async {
    allMarkedTrue = val!;
    if (val) {
      for (int i = 0; i < data.length; i++) {
        data[i].isPresent = false;
      }
    } else {
      for (int i = 0; i < data.length; i++) {
        data[i].isPresent = true;
      }
    }
    notifyListeners();
  }

  void setIsPresent(int i) {
    data[i].isPresent = !data[i].isPresent;
    if (!data[i].isPresent) {
      absent.add(data[i].scholarNumber);
    } else {
      absent.remove(data[i].scholarNumber);
    }
    absent.sort();
    notifyListeners();
  }

  List<Student>? get studentData => data;
}
