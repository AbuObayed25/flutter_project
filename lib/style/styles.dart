import 'package:flutter/material.dart';

InputDecoration AppInputStyle(lable) {
  return InputDecoration(
      fillColor: Colors.black, border: OutlineInputBorder(), labelText: lable);
}

TextStyle HeadTextStyle() {
  return TextStyle(fontSize: 24, fontWeight: FontWeight.w600);
}

ButtonStyle AppButtonStyle() {
  return ElevatedButton.styleFrom(
      backgroundColor: Colors.greenAccent,
      foregroundColor: Colors.white,
      minimumSize: Size(double.infinity, 55),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
}

