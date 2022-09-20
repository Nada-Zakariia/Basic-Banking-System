import 'package:bank_app/database/data.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class SqlDb {
  AllData allUsers = AllData();
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'data.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "history" (
        'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        'sender' TEXT NOT NULL ,
        'receiver' TEXT NOT NULL,
        'balance' INTEGER NOT NULL  
      )
''');
    await db.execute('''
      CREATE TABLE "users" (
        'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        'email' TEXT NOT NULL ,
        'balance' INTEGER NOT NULL, 
        'name' TEXT NOT NULL,
        'imageUrl' TEXT NOT NULL 
        
      )
''');
  }
  _onUpgrade(Database db, int oldversion, int newversion) async {
    
  }

  mydeleteDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'data.db');
    await deleteDatabase(path);
  }

  read(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

  insert(String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, values);
    return response;
  }

  update(String table, Map<String, Object?> values, String? mywhere) async {
    Database? mydb = await db;
    int response = await mydb!.update(table, values, where: mywhere);
    return response;
  }

  delete(String table, String? mywhere) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table, where: mywhere);
    return response;
  }

  insertAllData() async {
    Database? mydb = await db;
    for (int i = 0; i < allUsers.users.length; i++) {
      // ignore: unused_local_variable
      int response = await mydb!.insert("users", allUsers.users[i]);
    }
  }
}
