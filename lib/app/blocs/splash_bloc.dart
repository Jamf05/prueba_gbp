
import 'package:prueba_gbp/app/blocs/provider/bloc.dart';
import 'package:prueba_gbp/domain/use_case/security_use_case.dart';

class SplashBloc extends Bloc {

  final SecurityUseCase _securityUseCase;

  SplashBloc(this._securityUseCase);

  @override
  void dispose() {}

  Future<Map<String, dynamic>> getAuthenticationInfo(){
    return _securityUseCase.getAuth();
  }
}