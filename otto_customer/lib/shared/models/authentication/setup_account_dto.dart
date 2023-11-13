// To parse this JSON data, do
//
//     final accountVerificationDto = accountVerificationDtoFromJson(jsonString);

import 'dart:convert';

SetupAccountDto accountVerificationDtoFromJson(String str) => SetupAccountDto.fromJson(json.decode(str));

String accountVerificationDtoToJson(SetupAccountDto data) => json.encode(data.toJson());

class SetupAccountDto {
  final bool? error;
  final String? message;
  final Data? data;

  SetupAccountDto({
    this.error,
    this.message,
    this.data,
  });

  factory SetupAccountDto.fromJson(Map<String, dynamic> json) => SetupAccountDto(
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
  final String? phoneno;
  final String? networkProvider;
  final String? countryCode;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  Data({
    this.phoneno,
    this.networkProvider,
    this.countryCode,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    phoneno: json["phoneno"],
    networkProvider: json["network_provider"],
    countryCode: json["country_code"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "phoneno": phoneno,
    "network_provider": networkProvider,
    "country_code": countryCode,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
