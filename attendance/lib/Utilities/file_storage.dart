// ignore_for_file: avoid_print, unused_local_variable

// import 'dart:html';
import 'dart:io';
import 'package:attendance/constants.dart';
import 'package:flowder/flowder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

// To save the file in the device
class FileStorage {
  static Future<String> getExternalDocumentPath() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    Directory directory = Directory("");
    if (Platform.isAndroid) {
      directory = Directory("/storage/emulated/0/Download");
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    final exPath = directory.path;
    // print("Saved Path: $exPath");
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<String> get _localPath async {
    final String directory = await getExternalDocumentPath();
    return directory;
  }

  static Future<void> writeCounter({
    data,
    required void Function(dynamic, dynamic) progressIndicator,
    required VoidCallback onDone,
  }) async {
    // print(data);
    final path = await _localPath;
    int i = 1;
    String dirPath =
        '$path/${data['branch']}_${data['section']}_${data['session']}.xlsx';
    // print();
    // print(dirPath);
    while (await File(dirPath).exists()) {
      dirPath =
          '$path/${data['branch']}_${data['section']}_${data['session']}($i).xlsx';
      i++;
      // print(dirPath);
    }

    final downloaderUtils = DownloaderUtils(
      progressCallback: progressIndicator,
      file: File(dirPath
          // '$path/${data['branch']}_${data['section']}_${data['session']}.xlsx',
          ),
      progress: ProgressImplementation(),
      onDone: onDone,
      deleteOnCancel: true,
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var auth = prefs.getString('authorization');
    var newAuth = Uri.encodeFull(auth!);
    // print(Uri.encodeFull(
    //     '$kBaseLink/api/attendance/downloadAttendance/?subjectId=${data['subject']}&session=${data['session']}&branch=${data['branch']}&section=${data['section']}&authorization=$auth'));

    final core = await Flowder.download(
        Uri.encodeFull(
            '$kBaseLink/api/attendance/downloadAttendance/?subjectId=${data['subject']}&session=${data['session']}&branch=${data['branch']}&section=${data['section']}&authorization=$newAuth'),
        downloaderUtils);
  }
}
