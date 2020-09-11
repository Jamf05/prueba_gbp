import 'package:prueba_gbp/app/injectors/data_source_injector.dart';
import 'package:prueba_gbp/data/security_repository.dart';
import 'package:prueba_gbp/data/user_repository.dart';
import 'package:prueba_gbp/domain/use_case/security_use_case.dart';
import 'package:prueba_gbp/domain/use_case/user_use_case.dart';

class RepositoryInjector {

  static RepositoryInjector _singleton;

  factory RepositoryInjector(){
    if ( _singleton == null ) _singleton = RepositoryInjector._();
    return _singleton;
  }

  RepositoryInjector._();

  SecurityRepository provideSecurityRepository(){
    return SecurityRepositoryImpl(
      DataSourceInjector().provideSecurityApiSource()
    );
  }

  UserRepository provideUserRepository(){
    return UserRepositoryImpl(
      DataSourceInjector().provideUserApiSource()
    );
  }

}