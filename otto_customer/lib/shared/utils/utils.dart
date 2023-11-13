// ignore_for_file: unnecessary_null_comparison, null_check_always_fails

import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../router/main_router.dart';
export 'dims.dart';
export 'styles.dart';

String capitalizeText(String text, {required bool eachWord}) {
  if (text == null) {
    return null!;
  } else if (text.length <= 1) {
    return text.toUpperCase();
  } else {
    final List<String> list = text.split('');
    list[0] = list[0].toUpperCase();

    if (eachWord == true) {
      for (int i = 1; i < text.length; i++) {
        if (list[i] == ' ') {
          list[i + 1] = list[i + 1].toUpperCase();
        }
      }
    }

    return list.join('');
  }
}

// ignore: constant_identifier_names
enum ViewState { IDLE, BUSY, RETRIEVED, ERROR }

bool isValidEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

String formatDate(DateTime dateTime) {
  return DateFormat('dd MMM yyyy').format(dateTime);
}

String formatTime(DateTime dateTime) {
  return DateFormat('HH:mm').format(dateTime);
}

String formatDateApi(DateTime dateTime) {
  return DateFormat('yyyy-mm-dd').format(dateTime);
}

///design height(responsiveness)
double? logicalHeight() {
  final largestPhysicalSize = PlatformDispatcher.instance.views
      .map((v) => v.physicalSize)
      .reduce((curr, next) => curr.width * curr.height > next.width * next.height ? curr : next);

  final devicePixelRatio = PlatformDispatcher.instance.views
  .map((v) => v.devicePixelRatio)
      .first;
  debugPrint("New logicalHeight ${largestPhysicalSize.height / devicePixelRatio}");
  return largestPhysicalSize.height / devicePixelRatio;
}

///design width(responsiveness)
double? logicalWidth() {
  final largestPhysicalSize = PlatformDispatcher.instance.views
      .map((v) => v.physicalSize)
      .reduce((curr, next) => curr.width * curr.height > next.width * next.height ? curr : next);

  final devicePixelRatio = PlatformDispatcher.instance.views
      .map((v) => v.devicePixelRatio)
      .first;
  debugPrint("New logicalWidth ${largestPhysicalSize.width / devicePixelRatio}");
  return largestPhysicalSize.width / devicePixelRatio;
}

double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

// enum ViewState { IDLE, BUSY, RETRIEVED, ERROR }

navPush(BuildContext context, String route) {
  Navigator.push(context, MainRouter.generateRoute(RouteSettings(name: route)));
}

navPushReplace(BuildContext context, String route) {
  Navigator.pushReplacement(
      context, MainRouter.generateRoute(RouteSettings(name: route)));
}

navPop(BuildContext context) {
  Navigator.pop(context);
}

String formatNumbers({required double amount}) {
  final oCcy = NumberFormat("#,##0.##", "en_NG");
  String formattedAmount = oCcy.format(amount);
  return formattedAmount;
}

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}

class FormUtils {
  FormUtils._();

  static bool isValidEmail(String email) {
    final emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    return emailValid;
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    final phoneValid = RegExp(r"0[789][01]\d{8}").hasMatch(phoneNumber);

    return phoneValid;
  }

  static bool hasDigits(String text) {
    final hasDigits = text.contains(RegExp(r'[0-9]'));
    return hasDigits;
  }

  static bool hasUppercase(String text) {
    final hasUppercase = text.contains(RegExp(r'[A-Z]'));
    return hasUppercase;
  }

  static bool hasLowercase(String text) {
    final hasLowercase = text.contains(RegExp(r'[a-z]'));
    return hasLowercase;
  }

  static bool hasSpecialCharacters(String text) {
    final hasSpecialCharacters =
        text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    return hasSpecialCharacters;
  }

  static bool hasMinLength(String text, {int minLength = 8}) {
    final hasMinLength = text.length >= minLength;
    return hasMinLength;
  }
}

class Helper {
  static String obscureCharacters(
      {required String text, int? startIndex, int? toIndex}) {
    late String hashedText;
    // String reducedText = text.substring(0, text.lastIndexOf('@'));

    // String character reducedText.substring(reducedText.length - 3);
    hashedText = text.replaceRange(1, 4, "****");
    return hashedText;
  }
}

launchURL({required String url}) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

