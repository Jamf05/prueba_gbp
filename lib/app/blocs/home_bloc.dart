import 'package:prueba_gbp/app/blocs/provider/bloc.dart';
import 'package:prueba_gbp/domain/use_case/user_use_case.dart';
import 'package:prueba_gbp/entities/dto/event.dart';
import 'package:prueba_gbp/entities/dto/result_model.dart';
import 'package:prueba_gbp/entities/models/pelicula_model.dart';

class HomeBloc extends Bloc {

  final UserUseCase _userUseCase;

  int _popularesPage = 0;
  int _topRatedPage = 0;

  bool loadingPopulares = true;
  bool loadingTopRated = true;

  HomeBloc(this._userUseCase);

  @override
  void dispose() {}

  Future<Result<Event<List<PeliculaModel>>>> getPopularInfo(){
    _popularesPage++;
    return _userUseCase.getPopular(_popularesPage);
  }

  Future<Result<Event<List<PeliculaModel>>>> getTopRatedInfo(){
    _topRatedPage++;
    return _userUseCase.getTopRated(_topRatedPage);
  }


  
}