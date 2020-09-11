import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:prueba_gbp/app/context/settings/app_localizations.dart';
import 'package:prueba_gbp/app/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../ui/pages/splash_page.dart';

class CleanArchitectureApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        const Locale("en"),
        const Locale("es"),
      ],
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      routes: routes(context),
      // theme: ThemeData(
      // ),
    );
  }
}