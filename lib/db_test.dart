import 'package:flutter/foundation.dart';
import 'package:flutter_catatan/models/catatan.dart';

import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE catatan(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        judul TEXT,
        deskripsi TEXT,
        waktu_pengingat INT,
        interval_pengingat INT,
        lampiran TEXT
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'testing',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createCatatan(CatatanModel catatan) async {
    final db = await SQLHelper.db();

    final id = await db.insert(
      'catatan',
      catatan.toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<List<CatatanModel>> getCatatan() async {
    final db = await SQLHelper.db();

    final List<Map<String, dynamic>> maps = await db.query('catatan');

    return List.generate(maps.length, (i) {
      return CatatanModel(
        id: maps[i]['id'],
        judul: maps[i]['judul'],
        deskripsi: maps[i]['deskripsi'],
        waktu_pengingat: maps[i]['waktu_pengingat'],
        interval_pengingat: maps[i]['interval_pengingat'],
        lampiran: maps[i]['lampiran'],
      );
    });
  }

  static Future<int> updateCatatan(CatatanModel catatan) async {
    final db = await SQLHelper.db();

    final result = await db.update('catatan', catatan.toMap(),
        where: "id = ?", whereArgs: [catatan.id]);
    return result;
  }

  static Future<void> deleteCatatan(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("catatan", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an catatan: $err");
    }
  }
}
