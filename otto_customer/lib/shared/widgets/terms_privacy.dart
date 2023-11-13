import 'package:otto_customer/shared/widgets/all_package.dart';


Widget buildTermsPrivacy() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 35.w),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(child: RichText(text: TextSpan(
            // style: TextStyle(),
            children: [
            Styles.spanRegular("By signing up, you accept OTTO’s ", color: AppColors.black3, fontSize: 12.sp),
            Styles.spanRegular("Terms and Conditions", color: AppColors.black3, fontWeight:FontWeight.w600, fontSize: 12.sp, underline: true, recognizer: () async{await launchURL(url: "https://otto.com/terms-of-service");}),
            Styles.spanRegular(" and ", color: AppColors.black3, fontSize: 12.sp,),
            Styles.spanRegular("Privacy Policy.", color: AppColors.black3,  fontWeight:FontWeight.w600, fontSize: 12.sp, underline: true, recognizer: () async{await launchURL(url: "https://otto.com/privacy-policy");}),
          ],),),),),],),
  );
}