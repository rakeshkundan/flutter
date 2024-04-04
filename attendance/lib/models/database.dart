import 'dart:io';

import 'package:attendance/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'Attendance.db';
  static const _databaseVersion = 1;
  static const userTable = 'User';
  static const name = 'name';
  static const department = 'department';
  static const employeeId = 'employeeId';
  static const email = 'email';
  // static final contactTable = 'Contacts';
  // static final contactName = 'cname';
  // static final contactNumber = 'cnum';
  // static final lastMessage = 'lmessage';
  // static final unreadMessage = 'unreadCount';
  // static final time = 'lmessageTime';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    final directory = await getDatabasesPath();
    final dirPath = '$directory/.databases';
    bool exists = await Directory(dirPath).exists();
    if (!exists) {
      await Directory(dirPath).create();
    }
    String path = join(dirPath, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $userTable (
            $name TEXT,
            $employeeId TEXT PRIMARY KEY NOT NULL,
            $department TEXT )''');

    // await db.execute('''
    // CREATE TABLE $contactTable(
    // $contactName TEXT,
    // $contactNumber TEXT PRIMARY KEY ,
    // $lastMessage TEXT,
    // $unreadMessage INTEGER,
    // $time TEXT
    // )
    // ''');
  }

  //
  // Future<int> insertContact(Contact contact) async {
  //   Database db = await instance.database;
  //   return await db.insert(contactTable, contact.toMap());
  // }

  // Future<List<Map<String, dynamic>>> querryAllContact() async {
  //   Database db = await instance.database;
  //   return await db.query(contactTable);
  // }

  Future<int> insertUser(User user) async {
    // print('i an here');
    Database db = await instance.database;
    return await db.insert(userTable, {
      'name': user.name,
      'employeeId': user.employeeId,
      'department': user.department,
    });
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRowsUser() async {
    Database db = await instance.database;
    return await db.query(userTable);
  }

  Future<List<Map<String, dynamic>>> queryRowsUser(name) async {
    Database db = await instance.database;
    return await db.query(userTable, where: "$name LIKE '%$name%'");
  }

  Future<int> queryRowCountUser() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $userTable')) ??
        0;
  }

  Future<int> updateUser(User user) async {
    Database db = await instance.database;
    String id = user.toMap()['employeeId'];
    return await db.update(userTable, user.toMap(),
        where: '$employeeId = ?', whereArgs: [id]);
  }

  Future<int> deleteUser(String employeeId) async {
    Database db = await instance.database;
    return await db
        .delete(userTable, where: '$employeeId = ?', whereArgs: [employeeId]);
  }

  Future<bool> deleteDb() async {
    bool databaseDeleted = false;

    try {
      final directory = await getDatabasesPath();
      final dirPath = '$directory/.databases';
      bool exists = await Directory(dirPath).exists();
      if (!exists) {
        await Directory(dirPath).create();
      }
      String path = join(dirPath, _databaseName);
      await deleteDatabase(path).whenComplete(() {
        databaseDeleted = true;
        _database = null;
      }).catchError((onError) {
        databaseDeleted = false;
      });
    } on DatabaseException {
      // print(error);
    } catch (error) {
      // print(error);
    }
    return databaseDeleted;
  }
}
