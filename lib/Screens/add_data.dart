import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_sample/database/db_helper.dart';
import 'package:sqlite_sample/models/notes_model.dart';
import 'package:sqlite_sample/widgets/ui_helper.dart';
import 'dart:developer';

class AddData extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AddDataState();

}

class _AddDataState extends State<AddData>{
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  addData(String title, String description) async{
    if(title == "" && description == ""){
      return log("Enter required fields");
    }else{
      DbHelper().addNotes(NotesModel(title: title, desc: description));
      return log("Data inserted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UIHelper.CustomTextField(controller: titleController, hintTxt: "Enter Title", iconData: Icons.title),
          UIHelper.CustomTextField(controller: descriptionController, hintTxt: "Enter Description", iconData: Icons.description),
          SizedBox(height: 25,),
          ElevatedButton(onPressed: (){
            addData(titleController.text, descriptionController.text);
          }, child: Text("SaveData"))
        ],
      ),
    );
  }

}