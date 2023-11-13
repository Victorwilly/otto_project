// To parse this JSON data, do
//
//     final loginVerificationDto = loginVerificationDtoFromJson(jsonString);

import 'dart:convert';

LoginVerificationDto loginVerificationDtoFromJson(String str) => LoginVerificationDto.fromJson(json.decode(str));

String loginVerificationDtoToJson(LoginVerificationDto data) => json.encode(data.toJson());

class LoginVerificationDto {
  final bool? error;
  final String? message;
  final UserData? data;

  LoginVerificationDto({
    this.error,
    this.message,
    this.data,
  });

  factory LoginVerificationDto.fromJson(Map<String, dynamic> json) => LoginVerificationDto(
    error: json["error"],
    message: json["message"],
    data: json["data"] == null ? null : json["data"] is List ? UserData() : UserData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": data?.toJson(),
  };
}

class UserData {
  final int? id;
  final String? firstname;
  final String? lastname;
  final String? networkProvider;
  final String? countryCode;
  final String? phoneno;
  final dynamic email;
  final dynamic emailVerifiedAt;
  final int? isVerified;
  final int? isActive;
  final int? canLogin;
  final int? isCompleted;
  final int? the2Fa;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserData({
    this.id,
    this.firstname,
    this.lastname,
    this.networkProvider,
    this.countryCode,
    this.phoneno,
    this.email,
    this.emailVerifiedAt,
    this.isVerified,
    this.isActive,
    this.canLogin,
    this.isCompleted,
    this.the2Fa,
    this.createdAt,
    this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    networkProvider: json["network_provider"],
    countryCode: json["country_code"],
    phoneno: json["phoneno"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    isVerified: json["is_verified"],
    isActive: json["is_active"],
    canLogin: json["can_login"],
    isCompleted: json["is_completed"],
    the2Fa: json["2fa"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "network_provider": networkProvider,
    "country_code": countryCode,
    "phoneno": phoneno,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "is_verified": isVerified,
    "is_active": isActive,
    "can_login": canLogin,
    "is_completed": isCompleted,
    "2fa": the2Fa,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
