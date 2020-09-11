import 'dart:collection';

import 'package:prueba_gbp/data/user_repository.dart';
import 'package:prueba_gbp/data_source/api_base_source.dart';
import 'package:http/http.dart' as http;
import 'package:prueba_gbp/entities/dto/event.dart';
import 'package:prueba_gbp/entities/dto/result_model.dart';
import 'package:prueba_gbp/entities/models/actor_model.dart';
import 'package:prueba_gbp/entities/models/genre_model.dart';
import 'package:prueba_gbp/entities/models/pelicula_model.dart';

class UserApiSourceImpl extends ApiBaseSource implements UserApiSource {

  String _apikey    = '3f3b0a75bfb0e6e245bb40722d9f5184';
  String _url       = 'https://api.themoviedb.org/';
  String _lenguaje  = 'en-US';

  bool _cargando     = false;
  
  UserApiSourceImpl(
    String baseUrl, {http.Client client, String token}
  ) : super(baseUrl,client ?? http.Client(), token);

  @override
  Future<Result<Event<List<PeliculaModel>>>> getPopular(int page) {
    var url = _url+'3/movie/popular?api_key=$_apikey&language=$_lenguaje&page=$page';
    return get<Event<List<PeliculaModel>>>(
      url, ( dynamic value ) {

      value = (value as LinkedHashMap<String, dynamic>);
      var event = Event<List<PeliculaModel>>.fromJson(value);
      final List<PeliculaModel> _itemsResponse = new List();

      if ( event.payload.body != null ){
        Map<String, dynamic> mapItems = event.payload.body;
        List<dynamic> items = mapItems["results"];
        for ( var item in items ){
          final PeliculaModel _selectItemModel = PeliculaModel.fromJsonMap(item);
          _itemsResponse.add(_selectItemModel);
        }
      }

      event.payload.response = _itemsResponse;
      return event;
    });
  }

  @override
  Future<Result<Event<List<PeliculaModel>>>> getTopRated(int page) {
    var url = _url+'3/movie/top_rated?api_key=$_apikey&language=$_lenguaje&page=$page';
    return get<Event<List<PeliculaModel>>>(
      url, ( dynamic value ) {

      value = (value as LinkedHashMap<String, dynamic>);
      var event = Event<List<PeliculaModel>>.fromJson(value);
      final List<PeliculaModel> _itemsResponse = new List();

      if ( event.payload.body != null ){
        Map<String, dynamic> mapItems = event.payload.body;
        List<dynamic> items = mapItems["results"];
        for ( var item in items ){
          final PeliculaModel _selectItemModel = PeliculaModel.fromJsonMap(item);
          _itemsResponse.add(_selectItemModel);
        }
      }

      event.payload.response = _itemsResponse;
      return event;
    });
  }

  @override
  Future<Result<Event<List<ActorModel>>>> getCast(String peliId) {
    var url = _url+'3/movie/$peliId/credits?api_key=$_apikey&language=$_lenguaje&page=1';
    return get<Event<List<ActorModel>>>(
      url, ( dynamic value ) {

      value = (value as LinkedHashMap<String, dynamic>);
      var event = Event<List<ActorModel>>.fromJson(value);
      final List<ActorModel> _itemsResponse = new List();

      if ( event.payload.body != null ){
        Map<String, dynamic> mapItems = event.payload.body;
        List<dynamic> items = mapItems["cast"];
        for ( var item in items ){
          final ActorModel _selectItemModel = ActorModel.fromJsonMap(item);
          _itemsResponse.add(_selectItemModel);
        }
      }

      event.payload.response = _itemsResponse;
      return event;
    });
  }

  @override
  Future<Result<Event<List<GenreModel>>>> getGenres() {
    var url = _url+'3/genre/movie/list?api_key=$_apikey&language=$_lenguaje&page=1';
    return get<Event<List<GenreModel>>>(
      url, ( dynamic value ) {

      value = (value as LinkedHashMap<String, dynamic>);
      var event = Event<List<GenreModel>>.fromJson(value);
      final List<GenreModel> _itemsResponse = new List();

      if ( event.payload.body != null ){
        Map<String, dynamic> mapItems = event.payload.body;
        List<dynamic> items = mapItems["genres"];
        for ( var item in items ){
          final GenreModel _selectItemModel = GenreModel.fromJson(item);
          _itemsResponse.add(_selectItemModel);
        }
      }

      event.payload.response = _itemsResponse;
      return event;
    });
  }
  
}