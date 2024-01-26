import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:contactsapp/Contact.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  late Database db;

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  Future<void> initDB() async {
    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'contacts3.db'),
      onCreate: (database, version) async {
        await database.execute(
          """
            CREATE TABLE contacts (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT NOT NULL,
              phone_num INTEGER NOT NULL,
              email TEXT NOT NULL,
              company TEXT NOT NULL,
              address TEXT NOT NULL,
              birthday TEXT NOT NULL
            )
          """,
        );
      },
      version: 1,
    );
  }

  Future<int> InsertContact(Contact contact) async {
    int result = await db.insert('contacts', contact.toMap());
    return result;
  }

  Future<int> updateUser(Contact contact) async {
    int result = await db.update(
      'contacts',
      contact.toMap(),
      where: "id = ?",
      whereArgs: [contact.id],
    );
    return result;
  }

  Future<List<Contact>> RetrieveContacts() async {
    final List<Map<String, Object?>> queryResult = await db.query('contacts');
    return queryResult.map((e) => Contact.fromMap(e)).toList();
  }

  Future<void> deleteUser(int id) async {
    await db.delete(
      'contacts',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}