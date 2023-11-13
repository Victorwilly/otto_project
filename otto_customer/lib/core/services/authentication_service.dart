import 'package:otto_customer/shared/models/authentication/account_verification_dto.dart';
import 'package:otto_customer/shared/models/authentication/authentication_dto.dart';
import 'package:otto_customer/shared/models/authentication/create_account_dto.dart';
import 'package:otto_customer/shared/models/authentication/login_verification_dto.dart';
import 'package:otto_customer/shared/models/authentication/request_login_dto.dart';
import '../../shared/models/authentication/auth_payload.dart';
import 'package:otto_customer/shared/widgets/all_package.dart';


class AuthenticationService {
  AuthenticationService({
    required this.storageService,
    required this.storeService,
    required this.apiService,
  });

  StorageService storageService;
  StoreService storeService;
  ApiService apiService;

  Future<AuthPayload> getAuthData() async {
    final Completer<AuthPayload> completer = Completer<AuthPayload>();
    final String data = si.storageService.getItemSync('auth_data');

    if (data.isEmpty) {
      completer.complete(null);
    } else {
      final AuthPayload auth = AuthPayload.fromJson(json.decode(data));
      completer.complete(auth);
    }
    return completer.future;
  }

  Future<ApiResponse<SetupAccountDto>> setupAccountService(
      Map<String, dynamic> requestData) {
    return si.apiService!.postApi<SetupAccountDto>(
      'auth/customer/account/verification',
      requestData,
      // context,
      transform: (dynamic res) {
        // debugPrint("setupAccountService transform message ${res["message"]}");
        return SetupAccountDto.fromJson(res);
        // return res;
      },
    );
  }

Future<ApiResponse<AccountVerificationDto>> accountVerificationService(
      Map<String, dynamic> requestData) {
    return si.apiService!.postApi<AccountVerificationDto>(
      'auth/customer/account/validate/otp',
      requestData,
      // context,
      transform: (dynamic res) {
        debugPrint("accountVerification transform message ${res["message"]}");
        return AccountVerificationDto.fromJson(res);
        // return res;
      },
    );
  }

Future<ApiResponse<CreateAccountDto>> createAccountService(
      Map<String, dynamic> requestData) {
    return si.apiService!.postApi<CreateAccountDto>(
      'auth/customer/account/create',
      requestData,
      // context,
      transform: (dynamic res) {
        debugPrint("createAccountService transform message ${res["message"]}");
        return CreateAccountDto.fromJson(res);
        // return res;
      },
    );
  }


  /// Login


  Future<ApiResponse<RequestLoginDto>> requestLoginService(
      Map<String, dynamic> requestData) {
    return si.apiService!.postApi<RequestLoginDto>(
      'auth/customer/account/request/login/otp',
      requestData,
      // context,
      transform: (dynamic res) {
        return RequestLoginDto.fromJson(res);
        // return res;
      },
    );
  }

  Future<ApiResponse<LoginVerificationDto>> loginVerificationService(
      Map<String, dynamic> requestData) {
    return si.apiService!.postApi<LoginVerificationDto>(
      'auth/customer/account/validate/login/otp',
      requestData,
      // context,
      transform: (dynamic res) {
        debugPrint("loginVerificationService transform message ${res["message"]}");
        return LoginVerificationDto.fromJson(res);
        // return res;
      },
    );
  }

  Future<ApiResponse<AuthenticationDto>> accountLoginService(
      Map<String, dynamic> requestData) {
    return si.apiService!.postApi<AuthenticationDto>(
      'auth/customer/account/login',
      requestData,
      // context,
      transform: (dynamic res) {
        return AuthenticationDto.fromJson(res);
        // return res;
      },
    );
  }

}
