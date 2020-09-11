import 'package:prueba_gbp/entities/dto/event.dart';
import 'package:prueba_gbp/entities/dto/result_model.dart';
import 'package:prueba_gbp/entities/models/actor_model.dart';
import 'package:prueba_gbp/entities/models/genre_model.dart';
import 'package:prueba_gbp/entities/models/pelicula_model.dart';

abstract class UserRepository {
  Future<Result<Event<List<PeliculaModel>>>> getTopRated(int page);
  Future<Result<Event<List<PeliculaModel>>>> getPopular(int page);
  Future<Result<Event<List<ActorModel>>>> getCast(String peliId);
  Future<Result<Event<List<GenreModel>>>> getGenres();
}

abstract class UserUseCase {
  Future<Result<Event<List<PeliculaModel>>>> getTopRated(int page);
  Future<Result<Event<List<PeliculaModel>>>> getPopular(int page);
  Future<Result<Event<List<ActorModel>>>> getCast(String peliId);
  Future<Result<Event<List<GenreModel>>>> getGenres();

}

class UserUseCaseImpl implements UserUseCase {

  final UserRepository _userRepository;

  UserUseCaseImpl(this._userRepository);

  @override
  Future<Result<Event<List<PeliculaModel>>>> getTopRated(int page) {
    return _userRepository.getTopRated(page);
  }

  @override
  Future<Result<Event<List<PeliculaModel>>>> getPopular(int page) {
    return _userRepository.getPopular(page);
  }

  @override
  Future<Result<Event<List<ActorModel>>>> getCast(String peliId) {
    return _userRepository.getCast(peliId);
  }

  @override
  Future<Result<Event<List<GenreModel>>>> getGenres() {
    return _userRepository.getGenres();
  }
}