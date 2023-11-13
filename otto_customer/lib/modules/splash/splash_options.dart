import 'package:otto_customer/shared/models/authentication/login_verification_dto.dart';
import 'package:otto_customer/shared/utils/constants.dart';
import 'package:otto_customer/shared/widgets/all_package.dart';

import '../authentication/login/returning_login.dart';

class SplashOptions extends StatelessWidget {
  const SplashOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        height: deviceHeight(context).h, width: deviceWidth(context).w,
        child: Stack(
          children: [
            Positioned(
              right: 0.w,
              left: 0.w,
              top: 0.h,
              child: Image.asset(
                width: deviceHeight(context).w,
                // height: 200.h,
                ImageAssets.intro,
              ),
            ),

            Positioned(
              bottom: 80.h,
              right: 0.w,
              left: 0.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                // HSpace(80.h),
                HSpace(23.h),
                Padding(padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Styles.extraBold("Share smiles with Otto", align: TextAlign.center, fontSize: 30.sp, color: AppColors.blue,)),
                HSpace(12.h),
                Padding(padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Styles.regular("Buy or send your loved ones gift cards from your favourite brands and vendors.", align: TextAlign.center, fontSize: 14.sp, color: AppColors.black2,)),
                HSpace(33.h),
                CustomButton(isActive: true, margin: 24.w, title: "Get Started", onPress: () => Navigator.pushNamed(context, RoutePaths.setupAccount)),
                HSpace(8.h),
                // CustomButton(isActive: true, margin: 24.w, title: "Log In", txtColor: AppColors.black, btnColor: AppColors.white, onPress: () => Navigator.pushNamed(context, RoutePaths.signIn)),
                CustomButton(isActive: true, margin: 24.w, title: "Log In", txtColor: AppColors.black, btnColor: AppColors.white, onPress: () {
                    UserData? userData;
                    try {
                      debugPrint(" UsrData raw${si.storageService.getItemSync("auth_data")}");
                      debugPrint(" UsrData ${UserAccess.userData}");
                      userData = UserAccess.userData;
                    } catch (e) {
                      debugPrint("$e");
                    }
                  if(userData == null) {
                            Navigator.pushNamed(context, RoutePaths.newSignIn);
                          } else {
                    Navigator.push(
                      context!, MaterialPageRoute(builder: (context) => ReturnLogin(
                      user: userData,),
                    ),
                    );
                  }
                        }),
                HSpace(16.h),
                buildTermsPrivacy(),
              ],),
            ),
          ],
        ),
      )
    );
  }

}
