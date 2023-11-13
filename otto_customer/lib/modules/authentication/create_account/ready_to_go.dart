import 'package:otto_customer/shared/widgets/all_package.dart';

class ReadyToGo extends StatelessWidget {
  const ReadyToGo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBGColor,
      appBar: buildAppbar(context: context),
      body: SizedBox(
        width: deviceWidth(context),
        height: deviceHeight(context),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HSpace(39.h),
                Image.asset(ImageAssets.successIcon, width: 104.w, height: 104.h,),
                HSpace(32.h),
                Styles.bold("You are ready to go!", color: AppColors.blue2, fontSize: 20.sp),
                HSpace(12.h),
                Styles.regular("Thank you for completing your account setup with us. Now, let's explore the app together!", align: TextAlign.center, color: AppColors.blue2, fontSize: 14.sp),
                HSpace(deviceHeight(context)/2.h),
                CustomButton(isActive: true, margin: 0.w, title: "Get Started", txtColor: AppColors.black, btnColor: AppColors.white, onPress: () => Navigator.pushNamed(context, RoutePaths.newSignIn)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
