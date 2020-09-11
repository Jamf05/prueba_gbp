import 'package:prueba_gbp/domain/use_case/security_use_case.dart';
import 'package:prueba_gbp/entities/dto/event.dart';
import 'package:prueba_gbp/entities/dto/request_model/login_request.dart';
import 'package:prueba_gbp/entities/dto/request_model/response_request.dart';
import 'package:prueba_gbp/entities/dto/result_model.dart';
import 'package:prueba_gbp/entities/models/user_model.dart';

abstract class SecurityApiSource {

  Future<Result<Event<UserModel>>> logIn(LoginRequest loginRequest);
  Future<Result<Event<ResponseRequest>>> signIn(UserModel userModel);
  Future<Map<String, dynamic>> getAuth();

}

class SecurityRepositoryImpl implements SecurityRepository{

  final SecurityApiSource _securityApiSource;

  SecurityRepositoryImpl(this._securityApiSource);

  @override
  Future<Map<String, dynamic>> getAuth() {
    return _securityApiSource.getAuth();
  }

  @override
  Future<Result<Event<UserModel>>> logIn(LoginRequest loginRequest) {
    return _securityApiSource.logIn(loginRequest);

  }

  @override
  Future<Result<Event<ResponseRequest>>> signIn(UserModel userModel) {
    return _securityApiSource.signIn(userModel);
  }

}