import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color.dart';

class Loader extends StatelessWidget {
  final double? radius;
  final Color color;
  const Loader({this.radius, this.color = AppColors.primaryColor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45.w,
      height: 45.h,
      child: Platform.isAndroid
          ? CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(color))
          : CupertinoActivityIndicator(
              radius: radius ?? 20,
              color: AppColors.primaryColor,
            ),
    );
  }
}
