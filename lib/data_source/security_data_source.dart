import 'dart:collection';

import 'package:prueba_gbp/data/security_repository.dart';
import 'package:prueba_gbp/data_source/api_base_source.dart';
import 'package:prueba_gbp/entities/dto/event.dart';
import 'package:prueba_gbp/entities/dto/request_model/login_request.dart';
import 'package:prueba_gbp/entities/dto/request_model/response_request.dart';
import 'package:prueba_gbp/entities/dto/result_model.dart';
import 'package:prueba_gbp/entities/models/user_model.dart';
import 'package:http/http.dart' as http;


class SecurityApiSourceImpl extends ApiBaseSource implements SecurityApiSource {

  String _apiBaseUrl = "";

  SecurityApiSourceImpl(
    String baseUrl,
    {http.Client client,
    String token}):super(baseUrl, client ?? http.Client(), token);



  /*
  
    ######   ######## ########    ###    ##     ## ######## ##     ## 
  ##    ##  ##          ##      ## ##   ##     ##    ##    ##     ## 
  ##        ##          ##     ##   ##  ##     ##    ##    ##     ## 
  ##   #### ######      ##    ##     ## ##     ##    ##    ######### 
  ##    ##  ##          ##    ######### ##     ##    ##    ##     ## 
  ##    ##  ##          ##    ##     ## ##     ##    ##    ##     ## 
    ######   ########    ##    ##     ##  #######     ##    ##     ## 
  
  */

  @override
  Future<Map<String, dynamic>> getAuth() async {


    await Future.delayed(const Duration(seconds: 3), () {});
    
    //Application.aplicationUser = new UserModel();

    return {"ok": true, "data": false};
  }

  /*
  
  ##        #######   ######   #### ##    ## 
  ##       ##     ## ##    ##   ##  ###   ## 
  ##       ##     ## ##         ##  ####  ## 
  ##       ##     ## ##   ####  ##  ## ## ## 
  ##       ##     ## ##    ##   ##  ##  #### 
  ##       ##     ## ##    ##   ##  ##   ### 
  ########  #######   ######   #### ##    ## 
  
  */

  @override
  Future<Result<Event<UserModel>>> logIn(LoginRequest loginRequest) {
    
    // final key = Key.fromUtf8("asbAxsj98123As09.asd");
    // final iv = IV.fromLength(8);
    // final encrypter = Encrypter(Salsa20(key));

    // final encrypted = encrypter.encrypt(companyModel.passwordCompany, iv: iv);
    // companyModel.passwordCompany = encrypted.base64;

    var url = _apiBaseUrl+'user/auth';
    return post<Event<UserModel>>(
      url, loginRequest.toJson(), (value) {
      value = (value as LinkedHashMap<String, dynamic>);
      var event = Event<UserModel>.fromJson(value);
      event.payload.response =
          UserModel.fromJson(event.payload.body);
      return event;
    });
  }

  /*
  
    ######  #### ##    ##  ######   #### ##    ## 
  ##    ##  ##  ###   ## ##    ##   ##  ###   ## 
  ##        ##  ####  ## ##         ##  ####  ## 
    ######   ##  ## ## ## ##   ####  ##  ## ## ## 
        ##  ##  ##  #### ##    ##   ##  ##  #### 
  ##    ##  ##  ##   ### ##    ##   ##  ##   ### 
    ######  #### ##    ##  ######   #### ##    ## 
  
  */

  @override
  Future<Result<Event<ResponseRequest>>> signIn(UserModel userModel) async {
    var url = _apiBaseUrl+'user/reg';
    return post<Event<ResponseRequest>>(
      url, userModel.toJson(), (value) {
      value = (value as LinkedHashMap<String, dynamic>);
      var event = Event<ResponseRequest>.fromJson(value);
      event.payload.response =
          ResponseRequest.fromJson(event.payload.body);
      return event;
    });
  }

}