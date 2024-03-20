import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/notes_model.dart';

class DbHelper {
  static final DbHelper db = DbHelper();
  Database? _database;
  static const Note_table = "notes_table";
  static const Note_id = "notes_id";
  static const Note_title = "notes_title";
  static const Note_desc = "notes_desc";

  Future<Database> getDb() async{
    if(_database != null){
      return _database!;
    }else{
      return await initDb();
    }
  }
  
  Future<Database> initDb() async{
    var directory = await getApplicationCacheDirectory();
    var dbpath = join(directory.path+"notesdb.db");
    return openDatabase(dbpath, version: 1, onCreate: (db, version){
      return db.execute("create table $Note_table ( $Note_id integer primary key autoincrement, $Note_title text, $Note_desc text )");
    });
  }

  Future<bool> addNotes(NotesModel notesModel) async{
      var db = await getDb();
      int count = await db.insert(Note_table, notesModel.toMap());
      return count>0;
  }
}
