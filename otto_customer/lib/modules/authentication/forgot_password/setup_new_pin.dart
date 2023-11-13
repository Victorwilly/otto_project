
import '../../../shared/widgets/all_package.dart';

class SetupYourNewPin extends StatelessWidget {
  SetupYourNewPin({Key? key}) : super(key: key);
  String? completeNo;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HSpace(39.h),
                Styles.bold("Setup your new PIN", color: AppColors.blue2, fontSize: 24.sp),
                HSpace(32.h),
                CustomTextFormField(label: "PIN", hintText: "Enter new PIN", maxLines:1, suffixIcon: GestureDetector(onTap: (){}, child: Padding(padding: EdgeInsets.all(15.r),
                  child: SvgPicture.asset(1+1==1 ?SvgAssets.eye:SvgAssets.eyeSlash, width: 50.w, height: 20.h, ),
                ))),
                HSpace(16.h),
                CustomTextFormField(label: "Confirm PIN", hintText: "Confirm new PIN", maxLines:1, suffixIcon: GestureDetector(onTap: (){}, child: Padding(padding: EdgeInsets.all(15.r),
                  child: SvgPicture.asset(1+1==2 ?SvgAssets.eye:SvgAssets.eyeSlash, width: 20.w, height: 20.h,),
                ))),
                HSpace(deviceHeight(context)/2.h),
                CustomButton(isActive: true, margin: 0.w, title: "Continue", onPress: ()=> Navigator.pushNamed(context, RoutePaths.pinResetSuccess)),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
