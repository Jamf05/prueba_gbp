import 'package:prueba_gbp/app/injectors/repository_injector.dart';
import 'package:prueba_gbp/domain/use_case/security_use_case.dart';
import 'package:prueba_gbp/domain/use_case/user_use_case.dart';

class Injector {

  static Injector _singleton;

  factory Injector(){
    if ( _singleton == null ) _singleton = Injector._();
    return _singleton;
  }

  Injector._();

  SecurityUseCase provideSecurityUseCase(){
    return SecurityUseCaseImpl(
      RepositoryInjector().provideSecurityRepository()
    );
  }

  UserUseCase provideUserUseCase(){
    return UserUseCaseImpl(
      RepositoryInjector().provideUserRepository()
    );
  }

}