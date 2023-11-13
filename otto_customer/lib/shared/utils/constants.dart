// ignore_for_file: prefer_adjacent_string_concatenation, unnecessary_string_escapes, duplicate_ignore, constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:otto_customer/core/service-injector/service_injector.dart';

const String emptyEmailField = "Email field cannot be empty!";
const String emptyTextField = "Field cannot be empty!";
const String emptyPasswordField = "Password field cannot be empty";
const String invalidEmailField =
    "Email provided isn\'t valid.Try another email address";
const String passwordLengthError = "Password length must be greater than 8";
const String emptyUsernameField = "Username  cannot be empty";
const String usernameLengthError = "Username length must be greater than 6";
const String phoneNumberLengthError = "Phone number is invalid";
const String otpLengthError = "OTP code is invalid";
const String emailRegex = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
    "\\@" +
    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
    "(" +
    "\\." +
    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
    ")+";
const String emailRegexThree =
    r"^(?=[^@]{2,}@)([\w\.-]*[a-zA-Z0-9_]@(?=.{2,}\.[^.]*$)[\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z])$";

class AuthConstants {
  static String grantType = "password";
  static String defaultErrorMessage = "Something went wrong";
  static String userTypeId = "19275F4E-BCA1-415F-B221-8ABED761C248";
  static String roleName = "DATA OWNER";
  static String status = "True";
  static int successCode = 1;
  static int failedCode = -5;
}

class RequestConstants {
  static int acceptRequest = 2;
  static int declineRequest = 3;
}

class ConsentConstants {
  static int active = 1;
  static int inactive = 2;
}

class ConsentTabConstants {
  static int active = 0;
  static int inactive = 1;
}

class ManageConsentConstants {
  static int pause = 1;
  static int resume = 2;
  static int changeValidityPeriod = 3;
  static int revoke = 4;
}

enum DataOwnerAuthStatus {
  PENDING,
  APPROVED,
  FIP_AUTHENTICATION_FAILED,
  FIP_NOT_REACHABLE,
  PENDING_DATAOWNER_AUTHENTICATION,
  DELINKED,
}

const Map<String, dynamic> doAuthStatus = {
  'pending': 1,
  'approved': 2,
  'fipAuthFailed': 3,
  'fipNotReachable': 4,
  'pendingDOAuth': 5,
  'delinked': 6,
  'error': 7,
};

bool newNotifs = false;

enum UserType { monday }

typedef VoidFuture = Future<void> Function();
typedef DynamicFunction = dynamic Function();
typedef OnSavedFunction = void Function(String?);
typedef OnChangedFunction = void Function(Object?);
typedef OnFieldSubmittedFunction = void Function(Object?);
typedef OnValidateFunction = String? Function(String?);
typedef ValidateDropDownFunction = String? Function(Object?);
typedef VoidFunction = void Function(int?);
typedef VoidBoolFunction = void Function(bool?);


class UserAccess {
  static dynamic accessToken = jsonDecode(
      si.storageService.getItemSync("token")) ?? "";
  static dynamic userData = jsonDecode(
      si.storageService.getItemSync("auth_data")) ?? "";

}