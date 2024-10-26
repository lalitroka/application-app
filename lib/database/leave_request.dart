import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LeaveRequestDatabase {
  static final LeaveRequestDatabase _instance =
      LeaveRequestDatabase._internal();
  factory LeaveRequestDatabase() => _instance;

  LeaveRequestDatabase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'leave_requests.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE leaveRequests(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            leaveType TEXT,
            fromDate TEXT,
            toDate TEXT,
            substitutePersonnel TEXT,
            workStatus TEXT,
            selectedLeaveType TEXT,
            reason TEXT,
            status TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db
              .execute('ALTER TABLE leaveRequests ADD COLUMN approverId TEXT');
        }
      },
    );
  }

  Future<void> insertLeaveRequest(Map<String, dynamic> leaveRequest) async {
    final db = await database;
    await db.insert(
      'leaveRequests',
      leaveRequest,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getLeaveRequests() async {
    final db = await database;
    return await db.query('leaveRequests');
  }
}
