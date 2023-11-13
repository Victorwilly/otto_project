import 'package:flutter/material.dart';

void customPrint(var s1) {
  String s = s1.toString();
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(s).forEach((match) => debugPrint(match.group(0)));
}


