import 'dart:async';

import 'package:prueba_gbp/app/context/app.dart';
import 'package:prueba_gbp/app/context/settings/app_settings.dart';
import 'package:prueba_gbp/app/context/settings/application.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Application().appSettings = AppSettings();
    runZoned<Future<void>>(()async {
      runApp(CleanArchitectureApp());
    },
  );
}