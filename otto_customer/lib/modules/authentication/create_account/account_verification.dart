import 'package:otto_customer/shared/widgets/all_package.dart';


class AccountVerification extends StatefulWidget {
  const AccountVerification({Key? key, this.phoneNumber, this.dialCode}) : super(key: key);
  final String? phoneNumber;
  final String? dialCode;
  @override
  State<AccountVerification> createState() => _AccountVerificationState();
}

class _AccountVerificationState extends State<AccountVerification> with TickerProviderStateMixin {
  late AnimationController _controller;
  int levelClock = 300;
  String? intlPhoneNumber;



  @override
  void initState() {
    intlPhoneNumber = "${widget.dialCode}${widget.phoneNumber}";
    countDown();
    super.initState();
  }

  void countDown() {
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return BaseView<AccountVerificationViewModel>(
    //     vmBuilder: (context) => AccountVerificationViewModel(phoneNumber: widget.phoneNumber!,context: context, authenticationService: si.authenticationService),
    //     builder: _buildScreen);

    return ChangeNotifierProvider<AccountVerificationViewModel>(
      create: (_) => AccountVerificationViewModel(
        phoneNumber: widget.phoneNumber!,
        context: context,
        authenticationService: si.authenticationService,
      ),
      child: Consumer<AccountVerificationViewModel>(
        builder: (context, viewModel, _) => Stack(
          children: [
            _buildScreen(context, viewModel),
            newLoader(viewModel.newLoad)
          ],
        ),
      ),
    );
  }

  Widget _buildScreen(BuildContext context, AccountVerificationViewModel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.scaffoldBGColor,
      appBar: buildAppbar(context: context),
      body: SizedBox(
        height: deviceHeight(context).h,
        width: deviceWidth(context).w,
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              HSpace(39.h),
              pagePointer(firstNum: "2", color: AppColors.bgGrey),
              HSpace(39.h),
              Styles.bold("Account verification", color: AppColors.blue2, fontSize: 24.sp),
              HSpace(32.h),
                SizedBox(child: RichText(text: TextSpan(
                  // style: TextStyle(),
                  children: [
                    Styles.spanRegular("Please enter the 4 digit OTP code sent to the phone number ", color: AppColors.iconGrey, fontSize: 14.sp),
                    Styles.spanRegular("${intlPhoneNumber!.substring(0,6)}******${intlPhoneNumber!.substring(12)}.", color: AppColors.iconGrey, fontWeight:FontWeight.w700, fontSize: 16.sp,),
                  ],),),),
              HSpace(24.h), _buildPinInput(context, viewModel), HSpace(24.h),
                RichText(text: TextSpan(
                  // style: TextStyle(),
                  children: [
                    Styles.spanRegular("I din’t receive a code ", color: AppColors.grey2, fontSize: 14.sp),
                    Styles.spanRegular(" Resend Code", color: AppColors.blue2, fontWeight:FontWeight.w700, fontSize: 14.sp, recognizer: (){}),
                  ],),),
              HSpace(116.h),
              // CustomButton(isActive: true, margin: 1, title: "Continue", onPress: ()=> Navigator.pushNamed(context, RoutePaths.createAccount)), HSpace(20.h)
              ],),
          ),
        ),
      ),
    );
  }

  Widget _buildPinInput(BuildContext context, AccountVerificationViewModel viewModel){
    return Column( children: [
      Container(
        // color: Colors.white,
        margin: EdgeInsets.only(right: 100.w),
        child: PinPut(
          keyboardType: TextInputType.number,
          fieldsCount: 4, eachFieldHeight: 48.h, eachFieldWidth: 48.w,
          onEditingComplete: viewModel.onEditingComplete,
          onSubmit: viewModel.onSubmit,
          focusNode: viewModel.pinPutFocusNode,
          controller: viewModel.pinPutController,
          submittedFieldDecoration: _controller.isCompleted
              ? viewModel.pinPutDecoration.copyWith(
            color: AppColors.primaryColor.withOpacity(.1),
            border:
            Border.all(color: AppColors.primaryColor.withOpacity(.5)),
          )
              : viewModel.pinPutDecoration.copyWith(
            color: AppColors.primaryColor.withOpacity(.1),
            border: Border.all(
                color: AppColors.primaryColor.withOpacity(.5)),
          ),
          selectedFieldDecoration: viewModel.pinPutDecoration.copyWith(
              color: AppColors.primaryColor.withOpacity(.1),
              border: Border.all(color: AppColors.primaryColor)),
          followingFieldDecoration: viewModel.pinPutDecoration.copyWith(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    ],);
  }
}