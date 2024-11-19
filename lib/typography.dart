import 'package:flutter/material.dart';
import 'dart:ui';
const String FONT_FAMILY='Poppins';

class FontClass {
  static TextStyle appBar = TextStyle(
    fontFamily: FONT_FAMILY,
    fontWeight: FontWeight.bold,
    fontSize: 22,
    color: Colors.white
  );
  static TextStyle title = TextStyle(
    fontFamily: FONT_FAMILY,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: Colors.white
  );
  static TextStyle subtitle = TextStyle(
    fontFamily: FONT_FAMILY,
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: Colors.white
  );
  static TextStyle contentText = TextStyle(
    fontFamily: FONT_FAMILY,
    fontWeight: FontWeight.bold,
    fontSize: 14,
    color: Colors.white
  );
  static TextStyle infoText = TextStyle(
    fontFamily: FONT_FAMILY,
    fontSize: 12,
  );

}