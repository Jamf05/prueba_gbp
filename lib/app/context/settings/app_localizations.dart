import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale)=>['en','es'].contains(locale.languageCode);
  
  @override
  Future<AppLocalizations> load(Locale locale) {

    Intl.defaultLocale = locale.languageCode;
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }
      
  @override
  bool shouldReload(AppLocalizationsDelegate old)=>false;
}
    
class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of (BuildContext context){
    return Localizations.of<AppLocalizations>(context,AppLocalizations);
  }

  static Map<String,Map<String,String>> _localizedValues = {
    'en':{
      "helloWorld":"Hello world",
      "homePage"  :"Home Page",
      "popularSection" : "RECOMMENDED FOR YOU",
      "topSection"     : "TOP RATED",
      "homeTitle"      : "Hello, what do you want to whatch ?",
      "search"         : "Search",
      "watchNow"       : "Watch now",
      "genre"          : "Genre",
      "release"        : "Release"
      
    },
    'es':{
      "helloWorld"  :"Hola mundo",
      "homePage"    :"Pagina de inicio"
    },
  };

  String getText(String key){
    var text = _localizedValues.containsKey(locale.languageCode)
    ? _localizedValues['en'][key]
    // ? _localizedValues[locale.languageCode][key]
    : _localizedValues['en'][key];

    return text != null ? text : 'default';
  }

  String get helloWorld{
    return getText('helloWorld');
  }

  String get homePage{
    return getText('homePage');
  }

  String get popularSection{
    return getText('popularSection');
  }

  String get topSection{
    return getText('topSection');
  }

  String get homeTitle{
    return getText('homeTitle');
  }

  String get search{
    return getText('search');
  }

  String get watchNow{
    return getText('watchNow');
  }

  String get genre{
    return getText('genre');
  }

  String get release{
    return getText('release');
  }

}