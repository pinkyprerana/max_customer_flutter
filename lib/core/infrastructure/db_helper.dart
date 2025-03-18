import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/customer_model.dart';


class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'customers.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE customers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            mobile TEXT,
            email TEXT,
            address TEXT,
            latitude REAL,
            longitude REAL,
            geoAddress TEXT,
            image TEXT
          )
        ''');
      },
    );
  }

  Future<int> addCustomer(Customer customer) async {
    final db = await database;
    return db.insert('customers', customer.toMap());
  }

  Future<List<Customer>> getCustomers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('customers');
    return List.generate(maps.length, (i) => Customer.fromMap(maps[i]));
  }
}
