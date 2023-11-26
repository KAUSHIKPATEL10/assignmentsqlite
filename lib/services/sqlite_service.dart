import 'package:assignmentsqlite/models/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService{
  static const String databaseName = "database.db";
  static Database? db;

  static Future<Database> initizateDb() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return db?? await openDatabase(
              path,
        version: 1,

        onCreate: (Database db, int version) async {
          await createTables(db);

        });

  }

  static Future<void> createTables(Database database) async{
    await database.execute("""CREATE TABLE IF NOT EXISTS Notes (
        Id TEXT NOT NULL,
        Title TEXT NOT NULL,
        Description TEXT NOT NULL,
      )      
      """);
  }

  static Future<int> createItem(Note note) async {

    final Database db = await SqliteService.initizateDb();
    final id = await db.insert('Notes', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return  id;
  }


  // Read all notes
  static Future<List<Note>> getItems() async {
    final db = await SqliteService.initizateDb();
    await db.query('Notes', orderBy: NoteColumn.title);
    await db.query('Notes', orderBy: NoteColumn.description);

    final List<Map<String, Object?>> queryResult = await db.query('Notes');
    return queryResult.map((e) => Note.fromMap(e)).toList();
  }
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
        join(path, 'database.db'),
        onCreate: (database, version) async {
          await database.execute( "CREATE TABLE properties(id INTEGER PRIMARY KEY AUTOINCREMENT, address TEXT NOT NULL)",
          );
        },
        version: 1,
        onUpgrade: (database, oldVersion, newVersion){()=> 2;}
    );
  }
}
