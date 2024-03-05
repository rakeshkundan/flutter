// ignore_for_file: avoid_print, unused_local_variable

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
      // directory = await getDownloadsDirectory() ??
      //     await getApplicationDocumentsDirectory();
    }

    final exPath = directory.path;
    print("Saved Path: $exPath");
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<String> get _localPath async {
    final String directory = await getExternalDocumentPath();
    return directory;
  }

  static Future<void> writeCounter(data) async {
    final path = await _localPath;
    final downloaderUtils = DownloaderUtils(
      progressCallback: (current, total) {
        final progress = (current / total) * 100;
        print('Downloading: $progress');
      },
      file: File(
          '$path/${data['branch']}_${data['section']}_${data['session']}.xlsx'),
      progress: ProgressImplementation(),
      onDone: () {
        // OpenFile.open("$path/Cse01.xlsx");
        print('Download done');
        // OpenFile.open("$localpath/Cse01.xlsx");
      },
      deleteOnCancel: true,
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var auth = prefs.getString('authorization');

    final core = await Flowder.download(
        '$kBaseLink/api/attendance/downloadAttenance/?subjectId=${data['subject']}&session=${data['session']}&branch=${data['branch']}&section=${data['section']}&authorization=$auth',
        downloaderUtils);
  }
}
