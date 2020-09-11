import 'package:prueba_gbp/entities/dto/payload_event.dart';

class Event<T> {
  String status;
  int statusCode;
  String message;
  PayloadEvent<T> payload;
  Event.empty();
  Event(
    this.status,
    this.statusCode,
    this.message,
    this.payload,
  );
  factory Event.fromJson(Map<String, dynamic> json) => Event(
    json.containsKey('status_code') ? json['status_code'].toString() : '200',
    json.containsKey('status_code') ? json['status_code'] : 200,
    json.containsKey('status_message') ? json['status_message'] as String : 'ok',
    json.containsKey('results') ? PayloadEvent.fromJson(json) :
    json.containsKey('genres') ? PayloadEvent.fromJson(json) :
    json.containsKey('cast')    ? PayloadEvent.fromJson(json) : null,
  );
}