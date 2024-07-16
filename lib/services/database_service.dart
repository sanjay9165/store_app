import 'package:store/utilities/common_exports.dart';

class DatabaseService {
  factory DatabaseService() => _singleton;

  static final DatabaseService _singleton = DatabaseService._internal();
  late String _dbName;
  late String _tableName;
  late Database _db;

  DatabaseService._internal();

  // Initialise DatabaseName and TableName
  Future<void> initialiseApp() async {
    await dotenv.load(fileName: ".env");
    _dbName = (dotenv.env['DB_NAME'] ?? "");
    _tableName = (dotenv.env['TABLE_NAME'] ?? "");
  }

  // Open Database and Create Table if it is not present
  Future<void> getDatabase() async {
    try {
      final String databaseDirPath = await getDatabasesPath();
      final String databasePath = join(databaseDirPath, _dbName);
      _db = await openDatabase(
        version: 1,
        databasePath,
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $_tableName (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,description TEXT,stargazersCount INTEGER)'),
      );
    } catch (e) {
      log("ERROR ON CREATE: $e");
    }
  }

  // Insert store data into Database
  Future<void> insertStore(List<StoreModel> stores) async {
    try {
      Batch batch = _db.batch();
      for (StoreModel store in stores) {
        batch.insert(_tableName, store.toJson());
      }
      await batch.commit();
    } catch (e) {
      log("ERROR ON INSERT: $e");
    }
  }

  // Retrive all stores from Database
  Future<List<StoreModel>?> getAllStores() async {
    try {
      List<Map<String, Object?>> result = await _db.query(_tableName);

      List<StoreModel>? data = result
          .castToListOfMapOfStringDynamic()
          .map((e) => StoreModel.fromJson(e))
          .toList();
      return data;
    } catch (e) {
      log("ERROR ON FETCH: $e");
    }
    return null;
  }
}
