import 'package:flutter/material.dart';

Widget textField(controller,labelText, selectedIcon, selectedColor, status, type,hint,errorMessage) {
  return Padding(
    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10,top: 20),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          icon: Icon(
            selectedIcon,
            size: 30,
            color: selectedColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Color.fromRGBO(255, 216, 3, 1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: Color.fromRGBO(255, 216, 3, 1)),
            gapPadding: 4,
          ),
        hintText: hint,
        errorText: errorMessage,
//        errorBorder: OutlineInputBorder()
      ),
      obscureText: status,
      keyboardType: type,
    ),
  );
}
