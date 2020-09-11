import 'package:prueba_gbp/app/ui/pages/movie_page.dart';
import 'package:prueba_gbp/app/ui/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:prueba_gbp/app/ui/pages/home_page.dart';

Map<String, Widget Function(BuildContext)> routes(BuildContext context) {
  return <String, Widget Function(BuildContext)>{
      SplashPage.route          : (BuildContext context)  => SplashPage(),
      HomePage.route            : (BuildContext context)  => HomePage(),
      MoviePage.route           : (BuildContext context)  => MoviePage(),
  };
}