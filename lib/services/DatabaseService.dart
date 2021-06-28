import 'package:currency_converter/models/Rate.dart';
import 'package:currency_converter/services/Singleton.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const MONEY_CHANGES_DB_NAME = "MoneyValues.db";
const MONEY_RATES_TABLE = "money_rates";

class DatabaseService extends Singleton {
  late Future<Database> _database;
  late Future<String> _dbPath;

  Iterable<String> _knownIDs = [];

  static final DatabaseService _serviceInstance = DatabaseService._internal();

  factory DatabaseService() => DatabaseService._serviceInstance;

  DatabaseService._internal(){
    super.initializer = this._init();
  }

  Future<void> _init() async {
    this._dbPath = new Future(() async => join(await getDatabasesPath(),MONEY_CHANGES_DB_NAME));
    final path = await this._dbPath;
    this._database = openDatabase(
      path,
      onCreate: (db,version) async {
        return await db.execute(
          """CREATE TABLE $MONEY_RATES_TABLE(
            id        INTEGER PRIMARY KEY AUTOINCREMENT,
            rateId    TEXT,
            fromTag   TEXT,
            toTag     TEXT,
            rate      REAL,
            date      TEXT
          )"""
        );
      },
      version: 1
    );
  }

  Future<List<Rate>> getRates() async {
    final db = await this._database;
    final results = await db.query(MONEY_RATES_TABLE);
    final iterResult = results.map((e) => Rate.fromJson(e));
    this._knownIDs = iterResult.map((e) => e.id);
    return iterResult.toList();
  }

  Future<void> saveRates(List<Rate> r) async {
    final db = await this._database;

    for(var element in r) {
      final newInfo = {
        ...element.toJson(),
        "rateId"  : element.id,
        "date"    : element.creationDate.toIso8601String()
      };
      if(this._knownIDs.contains(element.id))
        await db.update(MONEY_RATES_TABLE, newInfo, where: "rateId = ?", whereArgs: [element.id]);
      else
        await db.insert(MONEY_RATES_TABLE, newInfo);
    }
    
  }

  Future<void> deleteRates(Rate r) async {
    final db = await this._database;

    int count = 0;

    // Delete the rate from the db
    count += await db.delete(MONEY_RATES_TABLE, where: "rateId = ?", whereArgs: [r.id]);
    // Also delete the inverse rate if it exists
    count += await db.delete(MONEY_RATES_TABLE, where: "rateId = ?", whereArgs: [r.inverse.id]);

    if(count < 1) throw new Exception("There weren't any successful delete operations for id ${r.id}");
  }
}