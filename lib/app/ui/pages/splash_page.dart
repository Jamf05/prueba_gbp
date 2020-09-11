import 'dart:async';

import 'package:prueba_gbp/app/blocs/splash_bloc.dart';
import 'package:prueba_gbp/app/context/settings/application_colors.dart';
import 'package:prueba_gbp/app/injectors/injector.dart';
import 'package:prueba_gbp/app/ui/base_state.dart';
import 'package:prueba_gbp/app/ui/custom/static_widgets.dart';
import 'package:prueba_gbp/app/ui/pages/home_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static final route = 'splash';
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage,SplashBloc> {

  bool _isAuthenticated = false;
  Future<Map<String, dynamic>> future;

  @override
  void initState() {
    super.initState();
    future = bloc.getAuthenticationInfo();
  }

  @override
  SplashBloc getBlocInstance() {
    return SplashBloc(Injector().provideSecurityUseCase());
  }

  @override
  Widget build(BuildContext context) {
    Size size;

    if (size == null) size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ApplicationColors().darkBlue,
      body: FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data["ok"]) {
              _isAuthenticated = snapshot.data["data"];
              initApp(context);
              return splashScreenWdiget();
            } else {
              return splashScreenWdiget();
            }
          } else {
            return splashScreenWdiget();
          }
        },
      ),
    );
  }

  Future<Timer> initApp( BuildContext context ) async {
    return new Timer(Duration(seconds: 1), ()=>_onDoneLoading(context) );
  }

  void _onDoneLoading( BuildContext context ){
    bool isLoginWithSocial = false;


    if (!_isAuthenticated){
      //isLoginWithSocial = await _isLoggedWithGoogle() || await _isLoggedWithFacebook();
      if(isLoginWithSocial){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
      }
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }
  }


 

}
