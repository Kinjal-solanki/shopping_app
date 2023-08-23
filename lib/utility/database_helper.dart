import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../feature/shopping/Model/ShoppingList.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = await getDatabasesPath();
    path = join(path, 'shopping_list.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<int> insertShoppingList(ShoppingList shoppingList) async {
    Database db = await instance.database;
    return await db.insert('shopping_list', shoppingList.toJson());
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE shopping_list (
        id INTEGER PRIMARY KEY,
        title TEXT,
        price REAL,
        description TEXT,
        category TEXT,
        image TEXT,
        rating TEXT
      )
    ''');
  }

  Future<List<ShoppingList>> retrieveShoppingObject() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('shopping_list');
    return List.generate(maps.length, (i) {
      return ShoppingList(
        id: maps[i]['id'],
        title: maps[i]['title'],
        price: maps[i]['price'],
        description: maps[i]['description'],
        category: maps[i]['category'],
        image: maps[i]['image'],
        rating: json.decode(maps[i]['rating']),
      );
    });
  }
  }
