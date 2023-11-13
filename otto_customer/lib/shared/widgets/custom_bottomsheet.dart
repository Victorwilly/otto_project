import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:otto_customer/shared/utils/assets.dart';
import 'package:otto_customer/shared/widgets/custom_button.dart';
import 'package:otto_customer/shared/widgets/space.dart';

import '../utils/color.dart';
import '../utils/styles.dart';

showCustomModal(
    {required BuildContext ctx,
    String? headerText,
    required bool isSuccess,
    required String message,
    bool? dismiss,
    required String buttonText,
    String? buttonTextTwo,
    VoidCallback? secondCallback,
    required VoidCallback callback}) {
  showModalBottomSheet(
      isScrollControlled: dismiss ?? true,
      elevation: 5,
      context: ctx,
      isDismissible: dismiss ?? false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r), topRight: Radius.circular(15.r)),
      ),
      builder: (ctx) => ActionBottomSheet(children: [
            HSpace(50.h),
            HSpace(30.h),
            !isSuccess
                ? Center(
                    child: SizedBox(
                      height: 150.h,
                      child: Lottie.asset(LottieAssets.warning),
                    ),
                  )
                : Center(
                    child: SizedBox(
                      height: 150.h,
                      child: Lottie.asset(LottieAssets.success),
                    ),
                  ),
            HSpace(24.h),
            Center(
              child: Styles.semiBold(headerText ?? 'Success!',
                  color: !isSuccess
                      ? AppColors.warningColor
                      : AppColors.primaryColor,
                  fontSize: 24.sp,
                  align: TextAlign.center),
            ),
            HSpace(24.h),
            Center(
              child: Styles.regular(message,
                  fontSize: 16.sp,
                  fontWeight: FWt.regular,
                  align: TextAlign.center,
                  color: AppColors.black),
            ),
            HSpace(50.h),
            HSpace(20.h),
            CustomButton(
                margin: 0.w,
                title: buttonText,
                isActive: true,
                txtColor: AppColors.white,
                txtSize: 17.sp,
                fontWeight: FontWeight.normal,
                onPress: callback),
            HSpace(20.h),
            !isSuccess
                ? CustomButton(
                    margin: 0.w,
                    btnColor: Colors.transparent,
                    title: buttonTextTwo!,
                    isActive: true,
                    txtColor: AppColors.primaryColor,
                    txtSize: 17.sp,
                    fontWeight: FontWeight.normal,
                    onPress: secondCallback ?? () {})
                : const SizedBox.shrink(),
            !isSuccess ? HSpace(20.h) : const SizedBox.shrink()
          ]));
}

class ContentModal {
  static modal(
      {required BuildContext ctx,
      required List<Widget> children,
      bool dismiss = false}) {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 5,
        context: ctx,
        isDismissible: dismiss,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r)),
        ),
        builder: (ctx) => ActionBottomSheet(children: children));
  }
}

class ActionBottomSheet extends StatelessWidget {
  const ActionBottomSheet(
      {Key? key,
      this.title,
      this.description,
      this.descriptionAction,
      this.warning,
      this.action1,
      this.action2,
      this.onTapAction1,
      this.onTapAction2,
      this.widget,
      this.children})
      : super(key: key);
  final String? title;
  final String? description;
  final String? descriptionAction;
  final String? warning;
  final String? action1;
  final String? action2;
  final Function()? onTapAction1;
  final Function()? onTapAction2;
  final Widget? widget;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.r), topRight: Radius.circular(18.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 20.w),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children!),
      ),
      onClosing: () => Navigator.pop(context),
    );
  }
}
