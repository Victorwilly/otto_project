import '../../../shared/widgets/all_package.dart';

class PinResetSuccess extends StatelessWidget {
  const PinResetSuccess({Key? key}) : super(key: key);

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
                Styles.bold("Successful!!", color: AppColors.blue2, fontSize: 20.sp),
                HSpace(12.h),
                Styles.regular("Your PIN has been successfully reset, click below to login manually", align: TextAlign.center, color: AppColors.blue2, fontSize: 14.sp),
                HSpace(deviceHeight(context)/2.h),
                CustomButton(isActive: true, margin: 0.w, title: "Login", txtColor: AppColors.black, btnColor: AppColors.white, onPress: () => Navigator.pushNamed(context, RoutePaths.signIn)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
