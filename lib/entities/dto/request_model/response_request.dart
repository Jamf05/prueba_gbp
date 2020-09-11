// To parse this JSON data, do
//
//     final responseRequest = responseRequestFromJson(jsonString);

import 'dart:convert';

ResponseRequest responseRequestFromJson(String str) => ResponseRequest.fromJson(json.decode(str));

String responseRequestToJson(ResponseRequest data) => json.encode(data.toJson());

class ResponseRequest {
    ResponseRequest({
        this.response,
    });

    String response;

    factory ResponseRequest.fromJson(Map<String, dynamic> json) => ResponseRequest(
        response: json["RESPONSE"],
    );

    Map<String, dynamic> toJson() => {
        "RESPONSE": response,
    };
}
