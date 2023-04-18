import 'package:pontos_turisticos/model/pontosTuristicos.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseProvider{
  static const _dbName = 'pontos_turisticos.db';
  static const _dbVersion = 1;

  DataBaseProvider._init();

  static final DataBaseProvider instance = DataBaseProvider._init();

  Database? _database;

  Future<Database> get database async {
    if (_database == null){
      _database = await _initDatabase();
    }
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dataBasePath = await getDatabasesPath();
    String dbPath = '${dataBasePath}/$_dbName';
    return await openDatabase(
        dbPath,
        version: _dbVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async{
    await db.execute('''
    CREATE TABLE ${PontoTuristico.NAME_TABLE} (
    ${PontoTuristico.CAMPO_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${PontoTuristico.CAMPO_NOME} TEXT NOT NULL,
    ${PontoTuristico.CAMPO_DESCRICAO} TEXT NOT NULL,
    ${PontoTuristico.CAMPO_DIFERENCIAIS} TEXT,
    ${PontoTuristico.CAMPO_DATA_INCLUSAO} TEXT,
    ${PontoTuristico.CAMPO_FINALIZADO} INTEGER NOT NULL DEFAULT 0
    )
    '''
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {}
}