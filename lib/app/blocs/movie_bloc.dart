import 'package:prueba_gbp/app/blocs/provider/bloc.dart';
import 'package:prueba_gbp/domain/use_case/user_use_case.dart';
import 'package:prueba_gbp/entities/dto/event.dart';
import 'package:prueba_gbp/entities/dto/result_model.dart';
import 'package:prueba_gbp/entities/models/actor_model.dart';
import 'package:prueba_gbp/entities/models/genre_model.dart';

class MovieBloc extends Bloc {

  final UserUseCase _userUseCase;

  MovieBloc(this._userUseCase);

  @override
  void dispose() {}

  Future<Result<Event<List<ActorModel>>>> getCastInfo(String peliId){
    return _userUseCase.getCast(peliId);
  }

  Future<Result<Event<List<GenreModel>>>> getGenresInfo(){
    return _userUseCase.getGenres();
  }
}