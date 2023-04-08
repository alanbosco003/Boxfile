import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'bookmodel.dart';

class DatabaseDB {
  Future<Database> bookdb() async {
    return openDatabase(
      join(await getDatabasesPath(), 'databaseone.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE bookone (id INTEGER PRIMARY KEY AUTOINCREMENT, created TEXT, title TEXT, content TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<int> insertBook(Book book) async {
    final db = await openDatabase('databaseone.db');
    var id = await db.insert(
      'bookone',
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<Book>> showbook() async {
    // Get a reference to the database.
    final db = await openDatabase('databaseone.db');
    final List<Map<String, dynamic>> maps = await db.query('bookone');
    // log(maps.toString());
    return List.generate(maps.length, (i) {
      return Book(
        id: maps[i]['id'],
        created: maps[i]['created'],
        title: maps[i]['title'],
        content: maps[i]['content'],
      );
    });
  }

  Future<void> updateBook(Book book) async {
    final db = await openDatabase('databaseone.db');
    await db.update(
      'bookone',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<void> deleteBook(int? id) async {
    final db = await openDatabase('databaseone.db');
    await db.delete(
      'bookone',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
