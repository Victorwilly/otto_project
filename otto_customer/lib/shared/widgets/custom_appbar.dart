import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color.dart';

AppBar buildAppbar(
    {bool? centerTitle,
    PreferredSize? bottom,
    required BuildContext context,
    List<Widget>? actions,
    Widget? title}) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    title: title,
    centerTitle: centerTitle ?? true,
    bottom: bottom,
    leading: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: Row(
            children: [
              Platform.isAndroid
                  ? Icon(
                      Icons.arrow_back,
                      size: 24.sp,
                      color: AppColors.offBlack,
                    )
                  : Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.offBlack,
                      size: 24.sp,
                    ),
            ],
          )),
    ),
    actions: actions,
  );
}
