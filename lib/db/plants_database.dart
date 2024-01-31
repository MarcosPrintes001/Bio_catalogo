import 'package:bio_catalogo/model/plant.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PlantsDatabase {
  static final PlantsDatabase instance = PlantsDatabase._init();

  static Database? _database;

  PlantsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('plants.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tablePlants ( 
  ${PlantFields.id} $idType, 
  ${PlantFields.imagePath} $textType,
  ${PlantFields.name} $textType,
  ${PlantFields.hasLeafHair} $boolType,
  ${PlantFields.isGlabrous} $boolType,
  ${PlantFields.hasCompostLeaf} $boolType,
  ${PlantFields.hasSimpleLeaf} $boolType,
  ${PlantFields.hasStipule} $boolType,
  ${PlantFields.petalCount} $integerType,
  ${PlantFields.gpsLocation} $textType,
  ${PlantFields.observation} $textType
  )
''');
  }

  Future<Plant> create(Plant plant) async {
    final db = await instance.database;

    final id = await db.insert(tablePlants, plant.toJson());
    print(plant.observation);
    return plant.copy(id: id);
  }

  Future<Plant> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tablePlants,
      columns: PlantFields.values,
      where: '${PlantFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Plant.fromJson(maps.first);
    } else {
      throw Exception('ID $id não encontrado');
    }
  }

  Future<List<Plant>> readAllPlants() async {
    final db = await instance.database;

    const orderBy = PlantFields.id;

    final result = await db.query(tablePlants, orderBy: orderBy);

    return result.map((json) => Plant.fromJson(json)).toList();
  }

  Future<int> update(Plant plant) async {
    final db = await instance.database;

    return db.update(
      tablePlants,
      plant.toJson(),
      where: '${PlantFields.id} = ?',
      whereArgs: [plant.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tablePlants,
      where: '${PlantFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
