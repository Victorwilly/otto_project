import 'package:otto_customer/shared/widgets/all_package.dart';


Widget pagePointer({String? firstNum, String? lastNum, Color? color}){
  return Container(
    width: 57.w,
    height: 22.h,
    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 1.h),
    // clipBehavior: Clip.antiAlias,
    decoration: ShapeDecoration(
      color: color??AppColors.aqua,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
    ),
    child: Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Styles.regular(
            '${firstNum??1} of ${lastNum??5}',
            color: AppColors.secondaryColor,
            fontSize: 12,
            // fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w500,
            // height: 0.14,
            // letterSpacing: 0.25,
          ),
        ],
      ),
    ),
  );
}