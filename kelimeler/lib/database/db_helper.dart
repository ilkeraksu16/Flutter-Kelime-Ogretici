import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:kelimeler/model/kelime.dart';

class DbHelper{
  static Database _db;

  Future<Database> get db async{
    if(_db != null){
      return _db;
    }
    _db = await initDb(); 
    return _db;
  }

  initDb() async{
    var dbFolder = await getDatabasesPath();
    String path = join(dbFolder,"Kelimeler.db");
    return openDatabase(path, onCreate: _onCreate, version: 1);
  }

  Future<void> _onCreate(Database db, int version) async{
    await db.execute("Create Table Kelime(id Integer PRIMARY KEY AUTOINCREMENT, turkce TEXT, ingilizce TEXT)");
  }


  Future<List<Kelime>> getKelimeler(bool siralama) async{
    final dbClient =await db;
    if(siralama){
      var result = await dbClient.query('Kelime',orderBy: 'ingilizce ASC');
      return result.map((data) => Kelime.fromMap(data)).toList();
    }
    else{
      var result = await dbClient.query('Kelime');
      return result.map((data) => Kelime.fromMap(data)).toList();
    }
  }

  Future<int> insertKelime(Kelime kelime) async{
    var dbClient =await db;
    return await dbClient.insert('Kelime', kelime.toMap());
  }

  Future<int> updateKelime(Kelime kelime) async{
    final dbClient =await db;
    var result =dbClient.update('Kelime', kelime.toMap(), where: 'id = ?',whereArgs: [kelime.id]);
    return result;
  }

  Future<int> deleteGorev(int id) async{
    final dbClient =await db;
    var result = await dbClient.delete('Kelime', where: 'id = ?',whereArgs: [id]);
    return result;
  }

}