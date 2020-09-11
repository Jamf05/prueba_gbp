import 'package:flutter/material.dart';
import 'package:prueba_gbp/app/blocs/provider/bloc.dart';
import 'package:prueba_gbp/app/blocs/provider/provider.dart';
import 'package:prueba_gbp/app/context/settings/app_localizations.dart';

abstract class BaseState<T extends StatefulWidget,K extends Bloc> extends State<T>{
  AppLocalizations l10n;
  K bloc;

  @override
  void initState() {
    super.initState();
    bloc = Provider.of<K>(getBlocInstance);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    l10n = AppLocalizations.of(context);
  }

  @override
  void dispose() {
    Provider.dispose<K>();
    super.dispose();
  }

  K getBlocInstance();
}