import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:otto_customer/shared/widgets/space.dart';

import '../utils/color.dart';
import '../utils/styles.dart';
import 'custom_button.dart';

void showCustomDialog(
    {required BuildContext context,
    required String message,
    String btnText = "Okay",
    required String lottie,
    bool isDismissable = false,
    required VoidCallback callback}) {
  showDialog<bool>(
    barrierDismissible: isDismissable,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.white,
        content: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  child: Lottie.asset(
                    lottie,
                    height: 100.0.h,
                    repeat: true,
                    reverse: true,
                    animate: true,
                  ),
                ),
              ),
              HSpace(12.h),
              Styles.medium(message, color: AppColors.black),
              HSpace(16.h),
              CustomButton(
                  margin: 0.w,
                  title: btnText,
                  isActive: true,
                  nonActiveBtnColor: AppColors.primaryColor.withOpacity(0.4),
                  txtColor: AppColors.white,
                  txtSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  onPress: callback),
            ],
          ),
        ),
      );
    },
  );
}
