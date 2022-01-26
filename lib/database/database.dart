import 'dart:async';
import 'dart:io';

import 'package:friends_app/models/friends.dart';
import 'package:friends_app/models/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  
  DatabaseHelper._privateContrustor();
  static final DatabaseHelper instance = DatabaseHelper._privateContrustor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDB();

  Future<Database> _initDB() async{
    Directory documents = await getApplicationDocumentsDirectory();
    String path = join(documents.path, 'friends.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
    "CREATE TABLE users(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, emailId TEXT, mobileNumber TEXT, password TEXT)"
    );

    await db.execute(
    "CREATE TABLE friends(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, emailId TEXT, mobileNumber TEXT)"
    );
  }

  Future<List> getUsers(number,password) async {
    Database db = await instance.database;
    var users = await db.rawQuery("Select * from users WHERE mobileNumber = '$number' AND password = '$password'");
    List usersList = users.isNotEmpty
        ? users.map((c) => User.fromJson(c)).toList()
        : [];
    return usersList;
  }

  Future<List<Friend>> getFriends() async {
    Database db = await instance.database;
    var friends = await db.query('friends', orderBy: 'firstName');
    List<Friend> friendsList = friends.isNotEmpty
        ? friends.map((c) => Friend.fromJson(c)).toList()
        : [];
    return friendsList;
  }

  Future<int> addUser(User user) async {
    Database db = await instance.database;
    return await db.insert('users', user.toJson());
  }

  Future<int> addFriend(Friend friend) async {
    Database db = await instance.database;
    return await db.insert('friends', friend.toJson());
  }
}
