import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:prueba_gbp/entities/dto/result_model.dart';

class ApiBaseSource {
  final String baseUrl;
  final http.Client client;
  final String token;
  final Duration timeout = Duration(seconds: 30);
  ApiBaseSource(
    this.baseUrl,
    this.client,
    this.token,
  );
  Future<Result<T>> get<T>(String url, T Function(dynamic value) mapperFunction,
      {Map<String, String> headers}) async {
    try {
      headers = await getHeaders(headers);
      headers[HttpHeaders.contentTypeHeader] = 'application/json';
      headers[HttpHeaders.acceptHeader] = 'application/json';
      log(url, name: 'url');  
      log('GET', name: 'method');
      log(headers.toString(), name: 'headers');
      var response = await client.get(url, headers: headers).timeout(timeout);
      var responseManage = await _manageResponse(response, mapperFunction);
      return responseManage;
    } catch (ex) {
      log(ex.toString(), name: 'error');
      return Result<T>.error(message: "L10NConstants.defaultError");
    }
  }
  
  Future<Result<T>> post<T>(String url, Map<String, dynamic> body,
      T Function(dynamic value) mapperFunction,
      {Map<String, String> headers}) async {
    try {
      headers = await getHeaders(headers);
      headers[HttpHeaders.contentTypeHeader] = 'application/json';
      headers[HttpHeaders.acceptHeader] = 'application/json';
      log("POST METHOD");
      log(url, name: 'url');
      log('POST', name: 'method');
      log(headers.toString(), name: 'headers');
      log(json.encode(body), name: 'requestBody');
      var response = await client
          .post(url, body: json.encode(body), headers: headers)
          .timeout(timeout);
          var a = await _manageResponse(response, mapperFunction);
      return a;
    } catch (ex) {
      log(ex.toString(), name: 'error');
      return Result<T>.error(message: "L10NConstants.defaultError");
    }
  }

  Future<Result<T>> put<T>(String url, Map<String, dynamic> body,
      T Function(dynamic value) mapperFunction,
      {Map<String, String> headers}) async {
    try {
      headers = await getHeaders(headers);
      headers[HttpHeaders.contentTypeHeader] = 'application/json';
      headers[HttpHeaders.acceptHeader] = 'application/json';
      log(url, name: 'url');
      log('PUT', name: 'method');
      log(headers.toString(), name: 'headers');
      log(json.encode(body), name: 'requestBody');
      var response = await client
          .put(url, body: json.encode(body), headers: headers)
          .timeout(timeout);
      return await _manageResponse(response, mapperFunction);
    } catch (ex) {
      log(ex.toString(), name: 'error');
      return Result<T>.error(message: "L10NConstants.defaultError");
    }
  }

  Future<Result<T>> delete<T>(String url,
      T Function(dynamic value) mapperFunction,
      {Map<String, String> headers}) async {
    try {
      headers = await getHeaders(headers);
      headers[HttpHeaders.contentTypeHeader] = 'application/json';
      headers[HttpHeaders.acceptHeader] = 'application/json';
      log(url, name: 'url');
      log('DELETE', name: 'method');
      log(headers.toString(), name: 'headers');
      var response = await client
          .delete(url,headers: headers)
          .timeout(timeout);
      return await _manageResponse(response, mapperFunction);
    } catch (ex) {
      log(ex.toString(), name: 'error');
      return Result<T>.error(message: "L10NConstants.defaultError");
    }
  }

  Future<Result<T>> _manageResponse<T>(
      http.Response response, T Function(dynamic value) mapperFunction) async {
    log('MANAGE RESPONSE METHOD');
    log(response.statusCode.toString(), name: 'statusCode');
    log(response.body, name: 'responseBody');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Result<T>.success(mapperFunction(_getBody((response.body !=null) ? response.bodyBytes : null)));
    } else {
      return _manageError<T>(response);
    }
  }

  Result<T> _manageError<T>(http.Response response) {
    return _errorFromMap(response);
  }

  Result<T> _errorFromMap<T>(http.Response response) {
    try {
      Map<String, dynamic> body = jsonDecode(response.body);
      String description = body['message'];
      description = description ?? "L10NConstants.defaultError";
      int code = body.containsKey('statusCode') ? int.parse(body['statusCode']) : 0;
      return Result<T>.error(message: description, code: code);
    } catch (ex) {
      log(ex.toString(), name: 'error');
      return Result<T>.error(
          message: "L10NConstants.defaultError", code: response.statusCode);
    }
  }

  dynamic _getBody(body) {
    if(body!=null){
      var bodyString = utf8.decode(body);
      try {
        return json.decode(bodyString);
      } catch (ex) {
        log(ex.toString(), name: 'error');
        return bodyString;
      }
    }else{
      return {};
    }
  }

  Future<Map<String, String>> getHeaders(Map<String, String> headers) async {
    headers = headers ?? {};
    return headers;
  }
  
  // Future<Map<String, String>> loadToken(Map<String, String> headers) async {
  //   if (token != null) {
  //     log(token, name: 'token');
  //     headers[HttpHeaders.authorizationHeader] = 'JWT $token';
  //   }
  //   return headers;
  // }
}