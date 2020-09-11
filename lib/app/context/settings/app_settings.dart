import 'package:flutter/material.dart';
import 'package:prueba_gbp/app/context/settings/application_colors.dart';

class AppSettings {
  
  static AppSettings _singleton;

  final TextStyle homeTitleStyle = TextStyle(
    color: ApplicationColors().white,
    fontSize: 30,
    fontWeight: FontWeight.bold
  );

  final TextStyle homeSubTitleStyle = TextStyle(
    color: ApplicationColors().white,
    fontSize: 15,
    fontWeight: FontWeight.bold
  );

  final TextStyle homeMovieTitle = TextStyle(
    color: ApplicationColors().white,
    fontSize: 13,
    fontWeight: FontWeight.normal
  );
  
  factory AppSettings(){
    
    if(_singleton == null)_singleton=AppSettings._();

    return _singleton;
  }

  AppSettings._();

}