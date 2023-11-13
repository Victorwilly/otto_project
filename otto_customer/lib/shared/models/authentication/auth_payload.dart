// ignore_for_file: prefer_collection_literals, unnecessary_new, unnecessary_this

class AuthPayload<T> {
  String? accessToken;
  String? tokenType;
  int? expiresIn;

  AuthPayload({this.accessToken, this.tokenType, this.expiresIn});

  AuthPayload.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    return data;
  }
}


class AuthErrorPayload<T> {
  String? error;
  String? errorDescription;

  AuthErrorPayload({this.error, this.errorDescription});

  AuthErrorPayload.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    errorDescription = json['error_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['error_description'] = this.errorDescription;
    return data;
  }
}

