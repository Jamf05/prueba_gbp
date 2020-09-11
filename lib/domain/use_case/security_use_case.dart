import 'package:prueba_gbp/entities/dto/event.dart';
import 'package:prueba_gbp/entities/dto/request_model/login_request.dart';
import 'package:prueba_gbp/entities/dto/request_model/response_request.dart';
import 'package:prueba_gbp/entities/dto/result_model.dart';
import 'package:prueba_gbp/entities/models/user_model.dart';

abstract class SecurityRepository{

  Future<Result<Event<UserModel>>> logIn(LoginRequest loginRequest);
  Future<Result<Event<ResponseRequest>>> signIn(UserModel userModel);
  Future<Map<String, dynamic>> getAuth();

}

abstract class SecurityUseCase{

  Future<Result<Event<UserModel>>> logIn(LoginRequest loginRequest);
  Future<Result<Event<ResponseRequest>>> signIn(UserModel userModel);
  Future<Map<String, dynamic>> getAuth();

}

class SecurityUseCaseImpl implements SecurityUseCase{

  final SecurityRepository _securityRepository;

  SecurityUseCaseImpl(this._securityRepository);

  @override
  Future<Map<String, dynamic>> getAuth() {
    return _securityRepository.getAuth();
  }

  @override
  Future<Result<Event<UserModel>>> logIn(LoginRequest loginRequest) {
    return _securityRepository.logIn(loginRequest);
  }

  @override
  Future<Result<Event<ResponseRequest>>> signIn(UserModel userModel) {
    return _securityRepository.signIn(userModel);
  }

}