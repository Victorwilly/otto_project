// ignore_for_file: prefer_if_null_operators, unnecessary_overrides

import 'dart:convert';

ApiResponse apiResponseFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse<T> {
  ApiResponse({
    this.data,
    this.totalCount,
    this.errors,
    this.error,
    this.code,
    this.message,
  });

  T? data;
  int? totalCount;
  List<dynamic>? errors;
  bool? error;
  int? code;
  String? message;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        data: json["data"] == null ? null : json["data"],
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        errors: json["errors"] == null
            ? null
            : List<String>.from(json["errors"].map((x) => x)),
        error: json["error"] == null ? null : json["error"],
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data,
        "totalCount": totalCount == null ? null : totalCount,
        "errors":
            errors == null ? null : List<dynamic>.from(errors!.map((x) => x)),
        "error": error == null ? null : error,
        "code": code == null ? null : code,
        "message": message == null ? null : message,
      };

  @override
  String toString() {
    return super.toString();
  }
}
