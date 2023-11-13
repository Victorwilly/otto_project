import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:otto_customer/shared/widgets/all_package.dart';

class SuccessRegistration extends StatelessWidget {
  const SuccessRegistration({Key? key, this.referralCode}) : super(key: key);
  final String? referralCode;

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
                Image.asset(ImageAssets.successIcon, width: 104.w, height: 104.h),
                HSpace(32.h),
                Styles.bold("Success", color: AppColors.blue2, fontSize: 30.sp),
                HSpace(12.h),
                Styles.regular("Congratulations, your registration process has been completed successfully.", align: TextAlign.center, color: AppColors.blue2, fontSize: 14.sp),
                HSpace(32.h),
                Styles.regular("You also have a referral code, You get a 20% discount on transfer charges when your code is used", align: TextAlign.center, color: AppColors.blue2, fontSize: 14.sp),
                HSpace(24.h),
                Container(
                  height: 46.h,
                  padding: EdgeInsets.symmetric(
                      horizontal: 8.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: AppColors.white2.withOpacity(.50),
                    border: Border.all(color: AppColors.borderGrey, strokeAlign: BorderSide.strokeAlignCenter),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Styles.regular(referralCode??"723AWQE4",
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: AppColors.black4)),
                      Expanded(
                          child: InkWell(
                            onTap: () {
                              Clipboard.setData(ClipboardData(
                                  text: referralCode??""))
                                  .then((_) {
                                snackBar(
                                    context: context,
                                    message:
                                    'Code copied to clipboard',
                                    isError: false);
                              });
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.copy,
                                  color: AppColors.black4,
                                  size: 20.sp,
                                ),
                                WSpace(16.w),
                                Icon(
                                  Icons.file_upload_outlined,
                                  color: AppColors.black4,
                                  size: 20.sp,
                                ),
                                // Styles.regular("Copy",
                                //     fontWeight: FontWeight.w400,
                                //     fontSize: 12.sp,
                                //     color: primaryColor)
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                HSpace(24.h),
                CustomButton(isActive: true, margin: 0.w, title: "Set up Biometric", onPress: ()=> _authenticate(context) ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _authenticate(context) async {
    final localAuth = LocalAuthentication();

    try {
      bool canCheckBiometrics = await localAuth.canCheckBiometrics;
      if (canCheckBiometrics) {
        bool didAuthenticate = await localAuth.authenticate(
          localizedReason: 'Please authenticate to access this feature',
          // useErrorDialogs: true, // Show system authentication dialogs (e.g., Face ID, Touch ID)
          // stickyAuth: true, // If true, the user won't need to authenticate again for a while
          options: const AuthenticationOptions(useErrorDialogs: true, stickyAuth: true)
        );

        if (didAuthenticate) {
          // Authentication successful, you can perform the action you wanted here
          debugPrint('Biometric authentication successful');
          Navigator.pushNamed(context, RoutePaths.readyToGo);
        } else {
          // Authentication failed or user canceled
          debugPrint('Biometric authentication failed or canceled');
        }
      } else {
        // Biometrics not available on this device
        debugPrint('Biometrics not available on this device');
      }
    } catch (e) {
      // Handle errors
      debugPrint('Error: $e');
    }
  }

}


