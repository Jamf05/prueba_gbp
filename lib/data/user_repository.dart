import 'package:prueba_gbp/domain/use_case/user_use_case.dart';
import 'package:prueba_gbp/entities/dto/event.dart';
import 'package:prueba_gbp/entities/dto/result_model.dart';
import 'package:prueba_gbp/entities/models/actor_model.dart';
import 'package:prueba_gbp/entities/models/genre_model.dart';
import 'package:prueba_gbp/entities/models/pelicula_model.dart';

abstract class UserApiSource{
  Future<Result<Event<List<PeliculaModel>>>> getTopRated(int page);
  Future<Result<Event<List<PeliculaModel>>>> getPopular(int page);
  Future<Result<Event<List<ActorModel>>>> getCast(String peliId);
  Future<Result<Event<List<GenreModel>>>> getGenres();
}

class UserRepositoryImpl implements UserRepository {

  final UserApiSource _userApiSource;

  UserRepositoryImpl(this._userApiSource);

  Future<Result<Event<List<PeliculaModel>>>> getTopRated(int page){
    return _userApiSource.getTopRated(page);
  }

  Future<Result<Event<List<PeliculaModel>>>> getPopular(int page){
    return _userApiSource.getPopular(page);
  }

  Future<Result<Event<List<ActorModel>>>> getCast(String peliId) {
    return _userApiSource.getCast(peliId);
  }

  Future<Result<Event<List<GenreModel>>>> getGenres() {
    return _userApiSource.getGenres();
  }

}