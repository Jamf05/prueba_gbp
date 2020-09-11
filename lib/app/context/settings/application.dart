import 'package:prueba_gbp/app/context/settings/app_settings.dart';

class Application {

  static Application _singleton;

  AppSettings appSettings;

  factory Application(){
    if(_singleton == null)_singleton=Application._();
    return _singleton;
  }
  Application._();
}