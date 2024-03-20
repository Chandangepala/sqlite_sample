import 'package:sqlite_sample/database/db_helper.dart';

class NotesModel {
  int? noteid;
  String title;
  String desc;

  NotesModel({required this.title, required this.desc, this.noteid});

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
        title: map[DbHelper.Note_title],
        desc: map[DbHelper.Note_desc],
        noteid: map[DbHelper.Note_id]);
  }

  Map<String, dynamic> toMap(){
    return {
      DbHelper.Note_id:noteid,
      DbHelper.Note_title:title,
      DbHelper.Note_desc:desc
    };
  }
}
