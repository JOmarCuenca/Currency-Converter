abstract class Singleton {

  /*

    As an example of how a Singleton must be initialized in order to work globally.
    This comment will exist while we find out how to properly build the abstract singleton class.

    static final DatabaseService _serviceInstance = DatabaseService._internal();

    factory DatabaseService() => DatabaseService._serviceInstance;

    DatabaseService._internal(){
      super.initializer = this._init();
    }

    Future<void> _init() async {
      this._dbPath = new Future(() async => join(await getDatabasesPath(),LANGUAGES_DB_NAME));
      final path = await this._dbPath;
      this._database = openDatabase(
        path,
        onCreate: (db,version) async {
          return await db.execute(
            """CREATE TABLE $RECENT_LANGUAGES_TABLE(
              id            INTEGER PRIMARY KEY AUTOINCREMENT,
              langId        TEXT,
              useDate       TEXT
            )"""
          );
        },
        version: 0
      );
    }
   */

  late Future<void> _waiter;

  /// This property indicates if the Service is ready to be used.
  Future<void> get readyService => this._waiter;

  set initializer(Future serviceToWait){
    this._waiter = serviceToWait;
  }
}