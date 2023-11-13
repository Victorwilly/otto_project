// To parse this JSON data, do
//
//     final requestLoginDto = requestLoginDtoFromJson(jsonString);

import 'dart:convert';

RequestLoginDto requestLoginDtoFromJson(String str) => RequestLoginDto.fromJson(json.decode(str));

String requestLoginDtoToJson(RequestLoginDto data) => json.encode(data.toJson());

class RequestLoginDto {
  final bool? error;
  final String? message;
  final Data? data;

  RequestLoginDto({
    this.error,
    this.message,
    this.data,
  });

  factory RequestLoginDto.fromJson(Map<String, dynamic> json) => RequestLoginDto(
    error: json["error"],
    message: json["message"],
    data: json["data"] == null ? null : json["data"] is List ? Data() : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final String? countryCode;
  final String? phoneno;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  Data({
    this.countryCode,
    this.phoneno,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    countryCode: json["country_code"],
    phoneno: json["phoneno"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "country_code": countryCode,
    "phoneno": phoneno,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
