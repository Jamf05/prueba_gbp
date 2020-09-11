import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorsDelegate extends LocalizationsDelegate<Errors> {
  const ErrorsDelegate();

  @override
  bool isSupported(Locale locale)=>['en','es'].contains(locale.languageCode);
  
  @override
  Future<Errors> load(Locale locale) {

    Intl.defaultLocale = locale.languageCode;
    return SynchronousFuture<Errors>(Errors(locale));
  }
      
  @override
  bool shouldReload(ErrorsDelegate old)=>false;
}
    
class Errors {
  final Locale locale;
  Errors(this.locale);

  static Errors of (BuildContext context){
    return Localizations.of<Errors>(context,Errors);
  }

  static Map<String,Map<int,String>> _errors = {
    'en':{
      404 : "Not Found"
    },
    'es':{
      404 : "Lo sentimos, no hemos encontrado la informacion que ha solicitado",
      500 : "Se presento un error inesperado"
    },
  };

  String getText(int key){
    var text = _errors.containsKey(locale.languageCode)
    ? _errors['es'][key]
    //? _errors[locale.languageCode][key]
    : _errors['es'][key];

    return text != null ? text : 'Error inesperado';
  }

  String getErrorMessage( int errorCode ){
    return getText(errorCode);
  }

  bool containsError( int errorCode ){
    return _errors['es'].containsKey(errorCode);
  }

}