// To parse this JSON data, do
//
//     final accountVerificationDto = accountVerificationDtoFromJson(jsonString);

import 'dart:convert';

AccountVerificationDto accountVerificationDtoFromJson(String str) => AccountVerificationDto.fromJson(json.decode(str));

String accountVerificationDtoToJson(AccountVerificationDto data) => json.encode(data.toJson());

class AccountVerificationDto {
  final bool? error;
  final String? message;
  final List<dynamic>? data;

  AccountVerificationDto({
    this.error,
    this.message,
    this.data,
  });

  factory AccountVerificationDto.fromJson(Map<String, dynamic> json) => AccountVerificationDto(
    error: json["error"],
    message: json["message"],
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
  };
}
