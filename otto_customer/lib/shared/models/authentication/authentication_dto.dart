// To parse this JSON data, do
//
//     final authenticationDto = authenticationDtoFromJson(jsonString);

import 'dart:convert';

AuthenticationDto authenticationDtoFromJson(String str) =>
    AuthenticationDto.fromJson(json.decode(str));

String authenticationDtoToJson(AuthenticationDto data) =>
    json.encode(data.toJson());

class AuthenticationDto {
  final bool? error;
  final String? message;
  final LoginData? data;

  AuthenticationDto({
    this.error,
    this.message,
    this.data,
  });

  factory AuthenticationDto.fromJson(Map<String, dynamic> json) =>
      AuthenticationDto(
        error: json["error"],
        message: json["message"],
        data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data?.toJson(),
      };
}

class LoginData {
  final User? user;
  final String? accessToken;
  final String? tokenType;

  LoginData({
    this.user,
    this.accessToken,
    this.tokenType,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        accessToken: json["accessToken"],
        tokenType: json["tokenType"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "accessToken": accessToken,
        "tokenType": tokenType,
      };
}

class User {
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
  final List<Role>? roles;

  User({
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
    this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        roles: json["roles"] == null
            ? []
            : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
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
        "roles": roles == null
            ? []
            : List<dynamic>.from(roles!.map((x) => x.toJson())),
      };
}

class Role {
  final int? id;
  final String? name;
  final String? slug;
  final String? description;
  final int? level;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final Pivot? pivot;

  Role({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.level,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.pivot,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        level: json["level"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "level": level,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "pivot": pivot?.toJson(),
      };
}

class Pivot {
  final int? userId;
  final int? roleId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Pivot({
    this.userId,
    this.roleId,
    this.createdAt,
    this.updatedAt,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        userId: json["user_id"],
        roleId: json["role_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "role_id": roleId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
