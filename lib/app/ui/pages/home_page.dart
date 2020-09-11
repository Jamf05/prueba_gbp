import 'dart:math';

import 'package:prueba_gbp/app/blocs/home_bloc.dart';
import 'package:prueba_gbp/app/context/settings/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:prueba_gbp/app/context/settings/app_settings.dart';
import 'package:prueba_gbp/app/context/settings/application_colors.dart';
import 'package:prueba_gbp/app/injectors/injector.dart';
import 'package:prueba_gbp/app/ui/base_state.dart';
import 'package:prueba_gbp/app/ui/custom/components/movie_horizontal.dart';
import 'package:prueba_gbp/entities/dto/event.dart';
import 'package:prueba_gbp/entities/dto/result_model.dart';
import 'package:prueba_gbp/entities/models/pelicula_model.dart';

class HomePage extends StatefulWidget {
  static final route = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage,HomeBloc> {

  Future<Result<Event<List<PeliculaModel>>>> futurePopular;
  Future<Result<Event<List<PeliculaModel>>>> futureTopRated;

  List<PeliculaModel> listPeliculasPopular = new List<PeliculaModel>();
  List<PeliculaModel> listPeliculasTopRated = new List<PeliculaModel>();
  
  @override
  void initState() {
    super.initState();
    futurePopular = bloc.getPopularInfo();
    futureTopRated = bloc.getTopRatedInfo();
  }

  @override
  HomeBloc getBlocInstance() {
    return HomeBloc(Injector().provideUserUseCase());
  }

  @override
  Widget build(BuildContext context) {
    Size size;
    if (size == null) size = MediaQuery.of(context).size;  
    return Scaffold(
      backgroundColor: ApplicationColors().darkBlue,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: _header(size)
            ),
            Positioned(
              child: _backgroundBody(size),
            ),
          ],
        )
      ),
    );
  }

  Widget _header(Size size){
    return Container(
      width: size.width,
      height: size.height*0.4,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: size.width*0.1),
      color: ApplicationColors().blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            l10n.homeTitle,
            style: AppSettings().homeTitleStyle,
          ),
          SizedBox(height: 20.0,),
          _searchBar(size)
        ],
      ),
    );
  }

  Widget _searchBar(Size size){
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.only(left: 20),
        width: size.width*0.8,
        height: 35.0,
        color: ApplicationColors().white.withOpacity(0.4),
        child: Row(
          children: [
            Icon(Icons.search, color: ApplicationColors().white,),
            SizedBox(width: 10),
            Text(
              l10n.search,
              style:  AppSettings().homeSubTitleStyle,
            )
          ],
        ),
      ),
    );
  }

  Widget _backgroundBody(Size size) {
    return Container(
      margin: EdgeInsets.only(top: size.height*0.35),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35.0),
          topRight: Radius.circular(35.0)
        ),
        child: Container(
          width: size.width,
          color: ApplicationColors().darkBlue,
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height* 0.04,),
              _buildRecommended(context),
              _buildTopRated(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommended( BuildContext context ){
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Text(
              l10n.popularSection,
              style: AppSettings().homeSubTitleStyle,
            )
          ),
          SizedBox(height: 5.0),
          FutureBuilder(
            future: bloc.loadingPopulares ? futurePopular : null,
            builder: (BuildContext context, AsyncSnapshot<Result<Event<List<PeliculaModel>>>> snapshot) {
              final Result<Event<List<PeliculaModel>>> result = snapshot.data; 
              bloc.loadingPopulares = false;
              if ( snapshot.hasData ){
                if(result.error != null){
                  return Container();
                }
                List<PeliculaModel> tempListPeliculas = result.data.payload.response;

                tempListPeliculas.forEach((element) {
                  listPeliculasPopular.add(element);
                });

                listPeliculasPopular = listPeliculasPopular.toSet().toList();

                return MovieHorizontal(
                  peliculas: listPeliculasPopular, 
                  siguientePagina: () async {
                    bloc.loadingPopulares = true;
                    futurePopular = bloc.getPopularInfo();
                    setState(() {});
                  },
                );
              } else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTopRated( BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Text(
              l10n.topSection,
              style: AppSettings().homeSubTitleStyle,
            ),
          ),
          SizedBox(height: 5.0),
          FutureBuilder(
            future: bloc.loadingTopRated ? futureTopRated : null,
            builder: (BuildContext context, AsyncSnapshot<Result<Event<List<PeliculaModel>>>> snapshot) {
              final Result<Event<List<PeliculaModel>>> result = snapshot.data; 
              bloc.loadingTopRated = false;
              if ( snapshot.hasData ){
                if(result.error != null){
                  return Container();
                }
                List<PeliculaModel> tempListPeliculas = result.data.payload.response;

                tempListPeliculas.forEach((element) {
                  listPeliculasTopRated.add(element);
                });

                listPeliculasTopRated = listPeliculasTopRated.toSet().toList();


                return MovieHorizontal(
                  peliculas: listPeliculasTopRated, 
                  siguientePagina: () async {
                    bloc.loadingTopRated = true;
                    futurePopular = bloc.getTopRatedInfo();
                    setState(() {});
                  },
                );
              } else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}