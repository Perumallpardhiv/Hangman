import 'package:flutter/material.dart';

Widget letter(String ch, bool visible) {
  return Container(
    alignment: Alignment.center,
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
    ),
    child: Visibility(
      visible: visible,
      child: Text(
        ch,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    ),
  );
}
