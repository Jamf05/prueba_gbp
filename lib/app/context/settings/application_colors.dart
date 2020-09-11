import 'package:flutter/material.dart';

class ApplicationColors {

  static ApplicationColors _singleton;

  final Color white = Colors.white;
  final Color blue  = Color(0xff5ca0d3);
  final Color darkBlue  = Color(0xff2c3848);
  final Color black  = Colors.black;
  final Color yellow = Color(0xfffcd307);
  final Color yellow2 = Color(0xff56583b);
  final Color gray = Color(0xff6b737f);
  
  factory ApplicationColors(){
    
    if(_singleton == null)_singleton=ApplicationColors._();

    return _singleton;
  }

  ApplicationColors._();
  
}