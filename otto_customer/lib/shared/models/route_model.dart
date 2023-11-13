import 'package:flutter/material.dart';

class RouteOption {
  RouteOption({
    @required this.path,
    this.title,
    this.persist = false,
    this.redirectTo,
  });

  String? title;
  String? path;
  String? redirectTo;
  bool persist;
}
