// ignore_for_file: unnecessary_null_comparison, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, unused_catch_clause, empty_catches
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../router/route_paths.dart';
import '../../shared/models/api_model.dart';
import '../../shared/utils/assets.dart';
import '../../shared/utils/constants.dart';
import '../../shared/widgets/custom_dialog.dart';
import '../../shared/widgets/custom_snackbar.dart';
import '../config/app_config.dart';
import '../service-injector/service_injector.dart';
import 'store_service.dart';

class ApiService {
  ApiService(this.storeService);
  final StoreService storeService;

  Future<Map<String, String>> httpHeaders(
      [Map<String, String>? customHeaders]) async {
    final Map<String, String> h = customHeaders ?? <String, String>{};
    final String auth = si.storageService.getItemSync('token');

    if (h[HttpHeaders.contentTypeHeader] == null) {
      h[HttpHeaders.contentTypeHeader] = 'application/json; charset=UTF-8';
    }
    h[HttpHeaders.authorizationHeader] = 'Bearer $auth';

    return h;
  }

  dynamic _jsonEncodeDateHandler(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }

  String httpBody(dynamic body) {
    return jsonEncode(body, toEncodable: _jsonEncodeDateHandler);
  }

  Future<ApiResponse<T>> multiPartRequest<T>(String url,
      {T Function(dynamic)? transform,
      bool skipStatusCheck = false,
      bool? useToken,
      bool? notifbaseUrl,
      dynamic imageFiles,
      Map<String, String>? body,
      BuildContext? context,
      Map<String, String>? customHeaders,
      Map<String, dynamic>? params,
      String requestType = "POST"}) async {
    transform ??= (dynamic r) => r.body as T;

    final ApiResponse<T> apiResponse = ApiResponse<T>();

    try {
      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https(AppConfig.apiDomain(), AppConfig.apiPath(url), params)
          : Uri.http(AppConfig.apiDomain(), AppConfig.apiPath(url), params);

      Map<String, String> headers;

      if (useToken == true) {
        headers = await httpHeaders();
      } else {
        headers = {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        };
      }

      var request = http.MultipartRequest(requestType, uri);

      request.headers.addAll(headers);

      // debugPrint('ENDPOINT: $uri');
      // debugPrint('this is header authorization: ${headers["authorization"]}');
      // debugPrint('sign up body>>>>>>>>>>>: $body');

      if (imageFiles != null) {
        if (imageFiles.length > 0) {
          imageFiles.forEach((img) async {
            request.files
                .add(await http.MultipartFile.fromPath(img.field, img.path));
          });
        }
      }

      if (body != null) request.fields.addAll(body);
      var _data = await request.send().timeout(const Duration(seconds: 60));

      http.Response res = await http.Response.fromStream(_data)
          .timeout(const Duration(seconds: 20));

      final dynamic data = json.decode(res.body);
      // debugPrint('sign up body>>>>>>>>>>>: ${res.body}');
      if (res.statusCode == 200 || res.statusCode == 201) {
        if (data["hasErrors"] == true) {
          apiResponse.error = true;
          apiResponse.code = data["code"];
          String msg = "";

          if (data["errors"] is List) {
            for (int i = 0; i < data["errors"].length; i++) {
              msg += data["errors"][i].toString() + "\n";
            }
          } else {
            msg = data["errors"];
          }
          apiResponse.message = msg;

          return apiResponse;
        } else if (data["hasErrors"] == false && data["payload"] != null) {
          apiResponse.error = false;
          if (data["payload"] is String) {
            apiResponse.data = data["payload"];
            apiResponse.data = transform(data);
          } else {
            apiResponse.data = transform(data["payload"]);
          }
          apiResponse.code = data['code'];
          apiResponse.message = (data['description'] ?? '').toString();

          return apiResponse;
        } else {
          apiResponse.error = false;
          apiResponse.code = data['code'] ?? -1;
          apiResponse.message =
              (data['description'] ?? 'Something went wrong').toString();
        }
      } else if (int.parse(res.statusCode.toString()[0]) == 4) {
        showCustomDialog(
            context: context!,
            message: 'Your session has expired',
            lottie: LottieAssets.cancel,
            callback: () {
              Navigator.pushReplacementNamed(context, RoutePaths.signIn);
            });
        apiResponse.error = false;
        apiResponse.code = data['code'] ?? -1;
        apiResponse.message =
            (data['description'] ?? 'Something went wrong').toString();
        return apiResponse;
      } else {
        apiResponse.error = true;
        if (data['payload'] != null) {
          apiResponse.data = transform(data);
          apiResponse.message =
              (data['description'] ?? 'Error encountered').toString();
        }
        if (data['description'] != null) {
          apiResponse.message =
              (data['description'] ?? 'Error encountered').toString();
        }
      }
    } on TimeoutException catch (e) {
      apiResponse.error = true;
      apiResponse.code = AuthConstants.failedCode;
      apiResponse.message = ('Request timeout. Please try again').toString();

      return apiResponse;
    } on SocketException {
      apiResponse.error = true;
      apiResponse.code = AuthConstants.failedCode;
      apiResponse.message = ("No connection 🥲").toString();
      return apiResponse;
    } catch (e) {
      apiResponse.error = true;
      apiResponse.code = AuthConstants.failedCode;

      apiResponse.message = ('Error encountered').toString();
      return apiResponse;
    }

    return apiResponse;
  }

  Future<dynamic> authPostApi<T>(
    String url,
    dynamic body,
    BuildContext context, {
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    Map<String, String>? customHeaders,
    Map<String, String>? params,
  }) async {
    transform ??= (dynamic r) => r.body as T;
    Map<String, dynamic>? apiResponse;

    try {
      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https(AppConfig.apiDomain(), AppConfig.apiPath(url), params)
          : Uri.http(AppConfig.apiDomain(), AppConfig.apiPath(url), params);

      Map<String, String> headers = {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
      };

      final http.Response res =
          await http.post(uri, headers: headers, body: body);

      final dynamic data = json.decode(res.body);

      debugPrint('sign in body>>>>>>>>>>>: ${res.body}');
      if (res.statusCode == 200 || res.statusCode == 201) {
        apiResponse = data;
      } else {
        apiResponse = data;
      }
    } on TimeoutException catch (e) {
      snackBar(
          context: context,
          message: 'Request timeout. Please try again',
          isError: true);

      return apiResponse;
    } on SocketException {
      snackBar(
          context: context,
          message: 'Kindly check your connection 🥲',
          isError: true);

      return apiResponse;
    } catch (e) {}

    return apiResponse;
  }

  Future<ApiResponse<T>> getApi<T>(
    String url, {
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    bool? useToken,
    BuildContext? context,
    Map<String, String>? customHeaders,
    Map<String, String>? params,
  }) async {
    transform ??= (dynamic r) => r.body as T;

    final ApiResponse<T> apiResponse = ApiResponse<T>();

    try {
      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https(AppConfig.apiDomain(), AppConfig.apiPath(url), params)
          : Uri.http(AppConfig.apiDomain(), AppConfig.apiPath(url), params);

      Map<String, String> headers;

      if (useToken == true) {
        headers = await httpHeaders();
      } else {
        headers = {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        };
      }

      print(uri);
      final http.Response res = await http.get(uri, headers: headers);
      print("api result:${res.statusCode}");
      final dynamic data = json.decode(res.body);

      if (res.statusCode == 200 || res.statusCode == 201) {
        if (data["hasErrors"] == true) {
          debugPrint('Body2: ${res.body}');
          apiResponse.error = true;
          apiResponse.code = data["code"];
          String msg = "";

          if (data["errors"] is List) {
            for (int i = 0; i < data["errors"].length; i++) {
              msg += data["errors"][i].toString() + "\n";
            }
          } else {
            msg = data["errors"];
          }
          apiResponse.message = msg;
          apiResponse.code = data['code'];

          return apiResponse;
        } else if (data["hasErrors"] == false && data["payload"] != null) {
          debugPrint('Body3: ${res.body}');
          apiResponse.error = false;
          apiResponse.code = data["code"];
          if (data["payload"] is String) {
            apiResponse.data = data["payload"];
            apiResponse.message = (data['payload'] ?? '').toString();
          } else {
            apiResponse.data = transform(data);
            apiResponse.message = (data['description'] ?? '').toString();
          }

          return apiResponse;
        } else {
          debugPrint('Body4: ${res.body}');
          apiResponse.error = false;
          apiResponse.data = transform(data);
          apiResponse.code = data["code"];
          apiResponse.message =
              (data['description'] ?? 'Something went wrong').toString();
          return apiResponse;
        }
      } else if (int.parse(res.statusCode.toString()[0]) == 4) {
        apiResponse.code = data["code"];
        showCustomDialog(
            context: context!,
            message: 'Your session has expired',
            lottie: LottieAssets.cancel,
            callback: () {
              Navigator.pushReplacementNamed(context, RoutePaths.signIn);
            });
        apiResponse.error = false;
        apiResponse.code = data['code'] ?? -1;
        apiResponse.message =
            (data['description'] ?? 'Something went wrong').toString();
        return apiResponse;
      } else {
        apiResponse.error = true;
        apiResponse.code = data["code"];
        if (data['payload'] != null) {
          apiResponse.data = transform(data);
          apiResponse.message =
              (data['description'] ?? 'Error encountered').toString();
        }
        if (data['description'] != null) {
          apiResponse.message =
              (data['description'] ?? 'Error encountered').toString();
        }
      }
    } on SocketException {
      apiResponse.error = true;
      debugPrint('Body5: ');
      apiResponse.code = AuthConstants.failedCode;
      apiResponse.message = ("No connection 🥲").toString();
    } catch (e) {
      debugPrint('Body6:');
      apiResponse.error = true;
      apiResponse.code = AuthConstants.failedCode;
    }

    return apiResponse;
  }

  Future<ApiResponse<T>> getApiStreams<T>(
    String url, {
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    bool? useToken,
    BuildContext? context,
    Map<String, String>? customHeaders,
    Map<String, String>? params,
    Map<String, String>? paramss,
  }) async {
    transform ??= (dynamic r) => r.body as T;

    final ApiResponse<T> apiResponse = ApiResponse<T>();

    try {
      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https(AppConfig.apiDomain(), AppConfig.apiPath(url), paramss)
          : Uri.http(AppConfig.apiDomain(), AppConfig.apiPath(url), paramss);

      final String auth = si.storageService.getItemSync('token');
      var headers = {
        'Authorization': 'Bearer $auth',
        'Content-Type': 'application/json'
      };

      var request = http.Request('GET', uri);
      request.headers.addAll(headers);
      request.body = json.encode(params);
      http.StreamedResponse res = await request.send();

      var responseString = await res.stream.bytesToString();

      final dynamic data = json.decode(responseString);

      if (res.statusCode == 200 || res.statusCode == 201) {
        if (data["hasErrors"] == true) {
          apiResponse.error = true;
          String msg = "";

          if (data["errors"] is List) {
            for (int i = 0; i < data["errors"].length; i++) {
              msg += data["errors"][i].toString() + "\n";
            }
          } else {
            msg = data["errors"];
          }
          apiResponse.message = msg;

          return apiResponse;
        } else if (data["hasErrors"] == false && data["payload"] != null) {
          apiResponse.error = false;
          if (data["payload"] is String) {
            apiResponse.data = data["payload"];
            apiResponse.data = transform(data);
          } else {
            apiResponse.message = (data['description'] ?? '').toString();
            apiResponse.data = transform(data);
          }
          apiResponse.message = (data['description'] ?? '').toString();

          return apiResponse;
        } else {
          apiResponse.error = false;
          apiResponse.message =
              (data['description'] ?? 'Something went wrong').toString();
        }
      } else if (int.parse(res.statusCode.toString()[0]) == 4) {
        showCustomDialog(
            context: context!,
            message: 'Your session has expired',
            lottie: LottieAssets.cancel,
            callback: () {
              Navigator.pushReplacementNamed(context, RoutePaths.signIn);
            });
        apiResponse.error = false;
        apiResponse.code = data['code'] ?? -1;
        apiResponse.message =
            (data['description'] ?? 'Something went wrong').toString();
        return apiResponse;
      } else {
        apiResponse.error = true;
        if (data['payload'] != null) {
          apiResponse.data = transform(data);
          apiResponse.message =
              (data['description'] ?? 'Error encountered').toString();
        }
        if (data['description'] != null) {
          apiResponse.message =
              (data['description'] ?? 'Error encountered').toString();
        }
      }
    } on SocketException {
      apiResponse.error = true;

      apiResponse.message = ("No connection 🥲").toString();
    } catch (e) {
      apiResponse.error = true;

      apiResponse.message = ('Error encountered').toString();
    }

    return apiResponse;
  }

  Future<ApiResponse<T>> postApiNoToken<T>(
    String url,
    dynamic body, {
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    bool? useToken,
    BuildContext? context,
    Map<String, String>? customHeaders,
    Map<String, String>? params,
  }) async {
    transform ??= (dynamic r) => r.body as T;

    final ApiResponse<T> apiResponse = ApiResponse<T>();

    try {
      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https(AppConfig.apiDomain(), AppConfig.apiPath(url), params)
          : Uri.http(AppConfig.apiDomain(), AppConfig.apiPath(url), params);

      Map<String, String> headers;

      if (useToken == true) {
        headers = await httpHeaders();
      } else {
        headers = {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        };
      }

      final http.Response res =
          await http.post(uri, headers: headers, body: httpBody(body));

      final dynamic data = json.decode(res.body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        if (data["hasErrors"] == true) {
          apiResponse.error = true;
          String msg = "";

          if (data["errors"] is List) {
            for (int i = 0; i < data["errors"].length; i++) {
              msg += data["errors"][i].toString() + "\n";
            }
          } else {
            msg = data["errors"];
          }
          apiResponse.message = msg;

          return apiResponse;
        } else if (data["hasErrors"] == false && data["payload"] != null) {
          apiResponse.error = false;
          if (data["payload"] is String) {
            apiResponse.data = data["payload"];
            apiResponse.data = transform(data);
          } else {
            apiResponse.data = transform(data["payload"]);
          }
          apiResponse.message = (data['description'] ?? '').toString();

          return apiResponse;
        } else {
          apiResponse.error = false;
          apiResponse.data = transform(data);
          apiResponse.message =
              (data['description'] ?? 'Something went wrong').toString();
        }
      } else if (int.parse(res.statusCode.toString()[0]) == 4) {
        showCustomDialog(
            context: context!,
            message: 'Your session has expired',
            lottie: LottieAssets.cancel,
            callback: () {
              Navigator.pushReplacementNamed(context, RoutePaths.signIn);
            });
        apiResponse.error = false;
        apiResponse.code = data['code'] ?? -1;
        apiResponse.message =
            (data['description'] ?? 'Something went wrong').toString();
        return apiResponse;
      } else {
        apiResponse.error = true;
        if (data['payload'] != null) {
          apiResponse.data = transform(data);
          apiResponse.message =
              (data['description'] ?? 'Error encountered').toString();
        }
        if (data['description'] != null) {
          apiResponse.message =
              (data['description'] ?? 'Error encountered').toString();
        }
      }
    } on SocketException {
      apiResponse.error = true;
      apiResponse.message = ("No connection 🥲").toString();
    } catch (e) {
      apiResponse.error = true;

      apiResponse.message = ('Error encountered').toString();
    }

    return apiResponse;
  }

  Future<ApiResponse<T>> postApi<T>(
    String url,
    dynamic body, {
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    bool useToken = false,
    Map<String, String>? customHeaders,
    Map<String, String>? params,
  }) async {
    transform ??= (dynamic r) => r.body as T;

    // final ApiResponse<T> apiResponse = ApiResponse<T>();
    ApiResponse<T> apiResponse = ApiResponse<T>();

    try {
      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https(AppConfig.apiDomain(), AppConfig.apiPath(url), params)
          : Uri.http(AppConfig.apiDomain(), AppConfig.apiPath(url), params);

      Map<String, String> headers;

      if (useToken == true) {
        headers = await httpHeaders();
      } else {
        headers = {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        };
      }

      final http.Response res = await http
          .post(uri, headers: headers, body: httpBody(body))
          .timeout(const Duration(seconds: 60));

      if (res.statusCode == 200 || res.statusCode == 201) {
        final dynamic data = json.decode(res.body);

        debugPrint("Post DAta response code ${res.statusCode}");
        debugPrint("Post res body ${res.body}");
        debugPrint("Post DAta full response $uri}");
        debugPrint("Post DAta data ${data}");

        // apiResponse = ApiResponse.fromJson(data);
        apiResponse.error = data["error"];
        apiResponse.message = data["message"];
        apiResponse.code = res.statusCode;
        apiResponse.data = transform(data);
        return apiResponse;
      } else if (res.statusCode == 401) {
        final dynamic data = json.decode(res.body);

        debugPrint("Post DAta response code ${res.statusCode}");
        debugPrint("Post res body ${res.body}");
        debugPrint("Post DAta full response $uri}");
        debugPrint("Post DAta data ${data}");

        apiResponse.error = data["error"];
        apiResponse.message = data["message"];
        apiResponse.code = res.statusCode;
        return apiResponse;
      } else {
        if (res.body.startsWith("<HTML>")) {
          apiResponse.error = true;
          apiResponse.message = "Server Error";

          debugPrint("Post DAta response code ${res.statusCode}");
          debugPrint("Post res body ${res.body}");
          debugPrint("Post DAta full response $uri}");
        } else {
          final dynamic data = json.decode(res.body);

          debugPrint("Post DAta response code ${res.statusCode}");
          debugPrint("Post res body ${res.body}");
          debugPrint("Post DAta full response $uri}");
          debugPrint("Post DAta data ${data}");

          apiResponse.error = data["error"];
          apiResponse.message = data["message"];
          apiResponse.data = transform(data);
          apiResponse.code = res.statusCode;
          return apiResponse;
        }
      }
    } on SocketException {
      apiResponse.error = true;
      apiResponse.message = ("No connection 🥲").toString();
    } on TimeoutException {
      apiResponse.error = true;
      apiResponse.message = ("Server Error 🥲").toString();
    } catch (e) {
      apiResponse.error = true;
      // apiResponse.message = ('Error encountered').toString();
      // apiResponse.message = "api $e";
      rethrow;
    }
    return apiResponse;
  }

  Future<ApiResponse<T>> putApi<T>(
    String url,
    dynamic body, {
    bool? useOtherBaseUrl,
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    BuildContext? context,
    Map<String, String>? params,
  }) async {
    transform ??= (dynamic r) => r.body as T;

    final ApiResponse<T> apiResponse = ApiResponse<T>();

    try {
      final Map<String, String> headers = await httpHeaders();
      final Uri uri;
      if (useOtherBaseUrl == null) {
        uri = AppConfig.apiProtocol.startsWith('https')
            ? Uri.https(AppConfig.apiDomain(), AppConfig.apiPath(url), params)
            : Uri.http(AppConfig.apiDomain(), AppConfig.apiPath(url), params);
      } else {
        uri = AppConfig.apiProtocol.startsWith('https')
            ? Uri.https(AppConfig.apiDomain(), AppConfig.apiPath(url), params)
            : Uri.http(AppConfig.apiDomain(), AppConfig.apiPath(url), params);
      }

      final http.Response res = await http.put(
        uri,
        headers: headers,
      );

      final dynamic data = json.decode(res.body);

      if (res.statusCode == 200 || res.statusCode == 201) {
        apiResponse.data = transform(data);
        apiResponse.code = data['code'];
      } else if (int.parse(res.statusCode.toString()[0]) == 4) {
        showCustomDialog(
            context: context!,
            message: 'Your session has expired',
            lottie: LottieAssets.cancel,
            callback: () {
              Navigator.pushReplacementNamed(context, RoutePaths.signIn);
            });
        apiResponse.error = false;
        apiResponse.code = data['code'] ?? -1;
        apiResponse.message =
            (data['description'] ?? 'Something went wrong').toString();
        return apiResponse;
      } else {
        apiResponse.error = true;
        apiResponse.data = transform(data);
        apiResponse.code = data['code'];
        apiResponse.message =
            (data['description'] ?? 'Error encountered').toString();
      }
    } catch (e) {}

    return apiResponse;
  }
}

// Future<ApiResponse<T>> postApiAuthDomain<T>(
//   String url,
//   dynamic body, {
//   T Function(dynamic)? transform,
//   bool skipStatusCheck = false,
//   bool? useToken,
//   BuildContext? context,
//   Map<String, String>? customHeaders,
//   Map<String, String>? params,
// }) async {
//   transform ??= (dynamic r) => r.body as T;
//
//   final ApiResponse<T> apiResponse = ApiResponse<T>();
//
//   try {
//     final Uri uri = AppConfig.apiProtocol.startsWith('https')
//         ? Uri.https(AppConfig.apiDomain(), AppConfig.apiPath(url), params)
//         : Uri.http(AppConfig.apiDomain(), AppConfig.apiPath(url), params);
//
//     Map<String, String> headers;
//
//     if (useToken == true) {
//       headers = await httpHeaders();
//     } else {
//       headers = {
//         HttpHeaders.acceptHeader: 'application/json',
//         HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
//       };
//     }
//
//     final http.Response res =
//         await http.post(uri, headers: headers, body: httpBody(body));
//
//     final dynamic data = json.decode(res.body);
//
//     if (res.statusCode == 200 || res.statusCode == 201) {
//       if (data["hasErrors"] == true) {
//         apiResponse.hasErrors = true;
//         apiResponse.code = data["code"];
//         String msg = "";
//
//         if (data["errors"] is List) {
//           for (int i = 0; i < data["errors"].length; i++) {
//             msg += data["errors"][i].toString() + "\n";
//           }
//         } else {
//           msg = data["errors"];
//         }
//         apiResponse.description = msg;
//         apiResponse.code = data['code'];
//         return apiResponse;
//       } else if (data["hasErrors"] == false && data["payload"] != null) {
//         apiResponse.hasErrors = false;
//         apiResponse.code = data["code"];
//         if (data["payload"] is String) {
//           apiResponse.payload = data["payload"];
//           apiResponse.description = (data['payload'] ?? '').toString();
//         } else {
//           apiResponse.payload = transform(data);
//           apiResponse.description = (data['description'] ?? '').toString();
//         }
//
//         return apiResponse;
//       } else {
//         apiResponse.hasErrors = false;
//         apiResponse.payload = transform(data);
//         apiResponse.code = data["code"];
//         apiResponse.description =
//             (data['description'] ?? 'Something went wrong').toString();
//       }
//     } else if (int.parse(res.statusCode.toString()[0]) == 4) {
//       apiResponse.code = data["code"];
//       showCustomDialog(
//           context: context!,
//           message: 'Your session has expired',
//           lottie: LottieAssets.cancel,
//           callback: () {
//             Navigator.pushReplacementNamed(context, RoutePaths.signIn);
//           });
//       apiResponse.hasErrors = false;
//       apiResponse.code = data['code'] ?? -1;
//       apiResponse.description =
//           (data['description'] ?? 'Something went wrong').toString();
//       return apiResponse;
//     } else {
//       apiResponse.hasErrors = true;
//       apiResponse.code = data["code"];
//       if (data['payload'] != null) {
//         apiResponse.payload = transform(data);
//         apiResponse.description =
//             (data['description'] ?? 'Error encountered').toString();
//       }
//       if (data['description'] != null) {
//         apiResponse.description =
//             (data['description'] ?? 'Error encountered').toString();
//       }
//     }
//   } on SocketException {
//     apiResponse.hasErrors = true;
//     apiResponse.code = AuthConstants.failedCode;
//     apiResponse.description = ("No connection 🥲").toString();
//   } catch (e) {
//     apiResponse.hasErrors = true;
//     apiResponse.code = AuthConstants.failedCode;
//   }
//
//   return apiResponse;
// }

// Future<ApiResponse<T>> postApiPassAuthDomain<T>(
//   String url,
//   dynamic body, {
//   T Function(dynamic)? transform,
//   bool skipStatusCheck = false,
//   bool? useToken,
//   BuildContext? context,
//   Map<String, String>? customHeaders,
//   Map<String, String>? params,
// }) async {
//   transform ??= (dynamic r) => r.body as T;
//
//   final ApiResponse<T> apiResponse = ApiResponse<T>();
//
//   try {
//     final Uri uri = AppConfig.apiProtocol.startsWith('https')
//         ? Uri.https(AppConfig.apiDomain(), AppConfig.apiPath(url), params)
//         : Uri.http(AppConfig.apiDomain(), AppConfig.apiPath(url), params);
//
//     Map<String, String> headers;
//
//     if (useToken == true) {
//       headers = await httpHeaders();
//     } else {
//       headers = {
//         HttpHeaders.acceptHeader: 'application/json',
//         HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
//       };
//     }
//
//     final http.Response res =
//         await http.post(uri, headers: headers, body: httpBody(body));
//
//     final dynamic data = json.decode(res.body);
//     if (res.statusCode == 200 || res.statusCode == 201) {
//       if (data["hasErrors"] == true) {
//         apiResponse.hasErrors = true;
//         String msg = "";
//
//         if (data["errors"] is List) {
//           for (int i = 0; i < data["errors"].length; i++) {
//             msg += data["errors"][i].toString() + "\n";
//           }
//         } else {
//           msg = data["errors"];
//         }
//         apiResponse.code = data['code'];
//         apiResponse.description = msg;
//
//         return apiResponse;
//       } else if (data["hasErrors"] == false && data["payload"] != null) {
//         apiResponse.hasErrors = false;
//         if (data["payload"] is String) {
//           apiResponse.payload = data["payload"];
//           apiResponse.payload = transform(data);
//         } else {
//           apiResponse.payload = transform(data);
//         }
//         apiResponse.description = (data['description'] ?? '').toString();
//         apiResponse.code = data['code'];
//         return apiResponse;
//       } else {
//         apiResponse.hasErrors = false;
//         apiResponse.code = data['code'];
//         apiResponse.payload = transform(data);
//         apiResponse.description =
//             (data['description'] ?? 'Something went wrong').toString();
//       }
//     } else if (int.parse(res.statusCode.toString()[0]) == 4) {
//       showCustomDialog(
//           context: context!,
//           message: 'Your session has expired',
//           lottie: LottieAssets.cancel,
//           callback: () {
//             Navigator.pushReplacementNamed(context, RoutePaths.signIn);
//           });
//       apiResponse.hasErrors = false;
//       apiResponse.code = data['code'] ?? -1;
//       apiResponse.description =
//           (data['description'] ?? 'Something went wrong').toString();
//       return apiResponse;
//     } else {
//       apiResponse.hasErrors = true;
//       if (data['payload'] != null) {
//         apiResponse.payload = transform(data);
//         apiResponse.description =
//             (data['description'] ?? 'Error encountered').toString();
//       }
//       if (data['description'] != null) {
//         apiResponse.description =
//             (data['description'] ?? 'Error encountered').toString();
//       }
//       apiResponse.code = data['code'];
//     }
//   } on TimeoutException catch (e) {
//     apiResponse.hasErrors = true;
//
//     apiResponse.code = AuthConstants.failedCode;
//     apiResponse.description =
//         ('Request timeout. Please try again').toString();
//
//     return apiResponse;
//   } on SocketException {
//     apiResponse.hasErrors = true;
//     apiResponse.code = AuthConstants.failedCode;
//
//     apiResponse.description = ("No connection 🥲").toString();
//     return apiResponse;
//   } catch (e) {
//     apiResponse.code = AuthConstants.failedCode;
//     apiResponse.hasErrors = true;
//
//     apiResponse.description = ('Error encountered').toString();
//   }
//
//   return apiResponse;
// }// Future<ApiResponse<T>> getApi<T>(
//   //   String url, {
//   //   bool? useOtherBaseUrl,
//   //   T Function(dynamic)? transform,
//   //   bool skipStatusCheck = false,
//   //   BuildContext? context,
//   //   Map<String, String>? customHeaders,
//   //   Map<String, String>? params,
//   // }) async {
//   //   transform ??= (dynamic r) => r.body as T;
//   //
//   //   final ApiResponse<T> apiResponse = ApiResponse<T>();
//   //   final Uri uri;
//   //
//   //   try {
//   //     if (useOtherBaseUrl == null) {
//   //       uri = AppConfig.apiProtocol.startsWith('https')
//   //           ? Uri.https(AppConfig.apiDomain(), AppConfig.apiPath(url), params)
//   //           : Uri.http(AppConfig.apiDomain(), AppConfig.apiPath(url), params);
//   //     } else {
//   //       uri = AppConfig.apiProtocol.startsWith('https')
//   //           ? Uri.https(AppConfig.apiDomain(), AppConfig.apiPath(url), params)
//   //           : Uri.http(AppConfig.apiDomain(), AppConfig.apiPath(url), params);
//   //     }
//   //
//   //     Map<String, String> headers = await httpHeaders();
//   //     // debugPrint("uri==== $uri");
//   //     final http.Response res = await http.get(uri, headers: headers);
//   //
//   //     dynamic data;
//   //     // debugPrint("body==== ${res.body}", wrapWidth: 1024);
//   //
//   //     if (res.statusCode == 200 || res.statusCode == 201) {
//   //       data = json.decode(res.body);
//   //       if ((data != null && data['hasErrors'] == false)) {
//   //         apiResponse.hasErrors = false;
//   //         apiResponse.description =
//   //             (data['description'] ?? 'Error encountered').toString();
//   //         apiResponse.payload = transform(data);
//   //       } else {
//   //         apiResponse.hasErrors = true;
//   //         apiResponse.payload = transform(data);
//   //         apiResponse.description =
//   //             (data['description'] ?? 'Error encountered').toString();
//   //       }
//   //     } else if (int.parse(res.statusCode.toString()[0]) == 4) {
//   //       showCustomDialog(
//   //           context: context!,
//   //           message: 'Your session has expired',
//   //           lottie: LottieAssets.cancel,
//   //           callback: () {
//   //             Navigator.pushReplacementNamed(context, RoutePaths.signIn);
//   //           });
//   //
//   //       return apiResponse;
//   //     }
//   //   } on SocketException {
//   //     apiResponse.hasErrors = true;
//   //     apiResponse.description = ("No internet connection 🥲").toString();
//   //   } catch (e) {
//   //     apiResponse.hasErrors = true;
//   //
//   //     apiResponse.description = ('Error encountered').toString();
//   //   }
//   //   return apiResponse;
//   // }
