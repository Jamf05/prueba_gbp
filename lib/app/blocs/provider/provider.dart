import 'package:prueba_gbp/app/blocs/home_bloc.dart';
import 'package:prueba_gbp/app/blocs/movie_bloc.dart';
import 'package:prueba_gbp/app/blocs/provider/bloc.dart';
import 'package:prueba_gbp/app/blocs/provider/bloc_cache.dart';
import 'package:prueba_gbp/app/blocs/splash_bloc.dart';

class Provider {
  static T of<T extends Bloc>(Function instance) {
    switch (T) {
      case SplashBloc:
        {
          return BlocCache.getBlocInstance("SplashBloc", instance);
        }
      case HomeBloc:
        {
          return BlocCache.getBlocInstance("HomeBloc", instance);
        }
      case MovieBloc:
        {
          return BlocCache.getBlocInstance("MovieBloc", instance);
        }
    }
    return null;
  }

  static void dispose<T extends Bloc>() {
    switch (T) {
      case SplashBloc:
        {
          BlocCache.dispose("SplashBloc");
          break;
        }
      case HomeBloc:
        {
          BlocCache.dispose("HomeBloc");
          break;
        }
      case MovieBloc:
        {
          BlocCache.dispose("MovieBloc");
          break;
        }
    }
  }
}
