
import 'dart:convert';

CreateAccountDto createAccountDtoFromJson(String str) => CreateAccountDto.fromJson(json.decode(str));

String createAccountDtoToJson(CreateAccountDto data) => json.encode(data.toJson());

class CreateAccountDto {
  final bool? error;
  final String? message;
  final Data? data;

  CreateAccountDto({
    this.error,
    this.message,
    this.data,
  });

  factory CreateAccountDto.fromJson(Map<String, dynamic> json) => CreateAccountDto(
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
  final String? firstname;
  final String? lastname;
  final String? phoneno;
  final String? networkProvider;
  final String? countryCode;
  final String? referralCode;
  final bool? isActive;
  final bool? isVerified;
  final bool? canLogin;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  Data({
    this.firstname,
    this.lastname,
    this.phoneno,
    this.networkProvider,
    this.countryCode,
    this.referralCode,
    this.isActive,
    this.isVerified,
    this.canLogin,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    firstname: json["firstname"],
    lastname: json["lastname"],
    phoneno: json["phoneno"],
    networkProvider: json["network_provider"],
    countryCode: json["country_code"],
    referralCode: json["referral_code"],
    isActive: json["is_active"],
    isVerified: json["is_verified"],
    canLogin: json["can_login"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "phoneno": phoneno,
    "network_provider": networkProvider,
    "country_code": countryCode,
    "referral_code": referralCode,
    "is_active": isActive,
    "is_verified": isVerified,
    "can_login": canLogin,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
