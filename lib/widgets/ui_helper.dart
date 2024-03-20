import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UIHelper{

  static CustomTextField({required TextEditingController controller, required String hintTxt, required IconData iconData}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintTxt,
          suffixIcon: Icon(iconData),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9)
          )
        ),
      ),
    );
  }
}