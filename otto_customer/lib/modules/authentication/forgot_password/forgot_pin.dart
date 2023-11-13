import '../../../shared/widgets/all_package.dart';

class ForgotPin extends StatelessWidget {
  ForgotPin({Key? key}) : super(key: key);
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
                Styles.bold("Reset PIN?", color: AppColors.blue2, fontSize: 24.sp),
                HSpace(30.h),
                IntlPhoneField(
                  keyboardType: TextInputType.number,
                  iconPosition: IconPosition.trailing,
                  // dropdownIconPosition: IconPosition.trailing,
                  validator: FieldValidator.validate,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // controller: phoneNoController,
                  dropdownDecoration: BoxDecoration(
                    // color: AppColors.grey,
                    borderRadius: BorderRadius.circular(6.r),
                    // border: Border.all(color: borderTextFieldGreyColor, width: 1),
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 18.h, horizontal: 14.w),
                    // fillColor: dropDownColor,
                    filled: true,
                    fillColor: AppColors.grey,
                    hintText: 'Enter phone number',
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FWt.regular,
                      // color: Colors.black45,
                      color: AppColors.offBlack,
                      fontFamily: 'Inter',
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.sp),
                      borderSide: BorderSide(
                        color: AppColors.borderGrey,
                        width: 0.5.w,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.sp),
                      borderSide: BorderSide(
                        color: AppColors.borderGrey,
                        width: 0.5.w,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(8.sp)),
                        borderSide: const BorderSide(color: AppColors.primaryColor)),
                    errorBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(8.sp)),
                        borderSide: const BorderSide(color: Colors.red)),
                    labelStyle: TextStyle(
                        color: AppColors.blackText, fontSize: 12.sp, height: 1.4),
                  ),
                  initialCountryCode: 'NG',
                  onChanged: (phone) {
                    // if (formKey.currentState!.validate()) {
                    //   PhoneNumberValidator.validatePhoneNumber(
                    //       phone.completeNumber);
                    // }
                    // viewModel.completeNo = phone.completeNumber;
                    completeNo = "${phone.countryCode}-${phone.number}";
                  },
                ),
                HSpace(8.h),
                Styles.regular("A OTP (One Time Password) will be sent to the registered phone number.", color: AppColors.blackText, fontSize: 12.sp),
                // HSpace(56.h),
                HSpace(deviceHeight(context)/2.h),
                CustomButton(isActive: true, margin: 0.w, title: "Reset password", onPress: ()=> Navigator.pushNamed(context, RoutePaths.enterResetPin)),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
