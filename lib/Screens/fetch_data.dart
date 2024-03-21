import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_sample/Screens/add_data.dart';
import 'package:sqlite_sample/database/db_helper.dart';
import 'package:sqlite_sample/widgets/ui_helper.dart';

import '../models/notes_model.dart';

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  late DbHelper db;
  List<NotesModel> arrNotes = [];
  var titleController = TextEditingController();
  var descController = TextEditingController();

  getNotes() async{
    arrNotes = await db.getNotes();
    setState(() {

    });
  }

  addData(String title, String description) async{
    if(title == "" && description == ""){
      return log("Enter required fields");
    }else{
      bool check = await DbHelper().addNotes(NotesModel(title: title, desc: description));
      if(check){
        arrNotes = await db.getNotes();
        setState(() {

        });
      }
      return log("Data inserted");
    }
  }

  @override
  void initState() {
    super.initState();
    db = DbHelper.db;
    getNotes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch Data"),
        centerTitle: true,
      ),
      body: ListView.builder(itemBuilder: (context, index){
        return ListTile(
          leading: Text("${arrNotes[index].noteid}"),
          title: Text("${arrNotes[index].title}"),
          subtitle: Text("${arrNotes[index].desc}"),
        );
      }, itemCount:  arrNotes.length,),
      floatingActionButton: FloatingActionButton(onPressed: (){
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> AddData()));
        _showSheet();
      }, child: Icon(Icons.add),),
    );
  }

  _showSheet(){
    return showModalBottomSheet(context: context, builder: (BuildContext context){
      return Container(
        height: 400,
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Add Notes"),
            SizedBox(height: 15,),
            UIHelper.CustomTextField(controller: titleController, hintTxt: "Enter Title", iconData: Icons.title),
            UIHelper.CustomTextField(controller: descController, hintTxt: "Enter Description", iconData: Icons.description),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              addData(titleController.text, descController.text);
              Navigator.pop(context);
            }, child: Text("Save Data"))
          ],
        ),
      );
    });
  }
}
