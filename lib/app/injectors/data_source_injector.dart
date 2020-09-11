import 'package:prueba_gbp/data/security_repository.dart';
import 'package:prueba_gbp/data/user_repository.dart';
import 'package:prueba_gbp/data_source/security_data_source.dart';
import 'package:prueba_gbp/data_source/user_data_source.dart';

class DataSourceInjector {

  static DataSourceInjector _dataSourceInjector;

  factory DataSourceInjector(){
    if ( _dataSourceInjector == null ) _dataSourceInjector = DataSourceInjector._();
    return _dataSourceInjector;
  }

  DataSourceInjector._();

  SecurityApiSource provideSecurityApiSource(){
    return SecurityApiSourceImpl("");
  }

  UserApiSource provideUserApiSource(){
    return UserApiSourceImpl("");
  }
}