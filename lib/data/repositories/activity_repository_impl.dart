import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../domain/entities/activity.dart';
import '../../domain/repositories/activity_repository.dart';
import '../models/activity_model.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final pathString = join(dbPath, 'fitness.db');

    return await openDatabase(
      pathString,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE activities (
            id TEXT PRIMARY KEY,
            title TEXT,
            type TEXT,
            durationMinutes INTEGER,
            caloriesBurned REAL,
            date TEXT
          )
        ''');
      },
    );
  }

  @override
  Future<List<Activity>> getActivities() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('activities', orderBy: 'date DESC');
    return maps.map((map) => ActivityModel.fromMap(map)).toList();
  }

  @override
  Future<void> saveActivity(Activity activity) async {
    final db = await database;
    final model = ActivityModel(
      id: activity.id,
      title: activity.title,
      type: activity.type,
      durationMinutes: activity.durationMinutes,
      caloriesBurned: activity.caloriesBurned,
      date: activity.date,
    );
    await db.insert(
      'activities',
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteActivity(String id) async {
    final db = await database;
    await db.delete(
      'activities',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
