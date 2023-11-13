import 'package:otto_customer/modules/authentication/login/view_models/enter_login_pin_vm.dart';

import '../../../shared/widgets/all_package.dart';

class EnterLoginVerification extends StatefulWidget {
  const EnterLoginVerification({Key? key, this.phoneNumber, this.dialCode}) : super(key: key);
  final String? phoneNumber;
  final String? dialCode;

  @override
  State<EnterLoginVerification> createState() => _EnterLoginVerificationState();
}

class _EnterLoginVerificationState extends State<EnterLoginVerification> with TickerProviderStateMixin {
  late AnimationController _controller;
  int levelClock = 300;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  bool _confirm = false;
  var codeInputComplete;
  bool isLoading = false;

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      color: AppColors.grey,
      border: Border.all(color: AppColors.borderGrey),
      borderRadius: BorderRadius.circular(4.0),
    );
  }

  @override
  void initState() {
    super.initState();
    countDown();
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

    return ChangeNotifierProvider<EnterLoginVerificationViewModel>(
      create: (_) => EnterLoginVerificationViewModel(
        phoneNumber: widget.phoneNumber!,
        context: context,
        authenticationService: si.authenticationService,
      ),
      child: Consumer<EnterLoginVerificationViewModel>(
        builder: (context, viewModel, _) => Stack(
          children: [
            _buildScreen(context, viewModel),
            newLoader(viewModel.newLoad)
          ],
        ),
      ),
    );
  }

  Widget _buildScreen(BuildContext context, EnterLoginVerificationViewModel viewModel) {
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
                Styles.bold("Login verification", color: AppColors.blue2, fontSize: 24.sp),
                HSpace(32.h),
                SizedBox(child: RichText(text: TextSpan(
                  // style: TextStyle(),
                  children: [
                    Styles.spanRegular("Please enter the 4 digit OTP code sent to the phone number ", color: AppColors.iconGrey, fontSize: 14.sp),
                  ],),),),
                HSpace(24.h), _buildPinInput(context, viewModel), HSpace(8.h),
                // RichText(text: TextSpan(
                //   // style: TextStyle(),
                //   children: [
                //     Styles.spanRegular("Forgot PIN? ", color: AppColors.blue2, fontSize: 14.sp),
                //     Styles.spanRegular(" Tap to reset", color: AppColors.blue3, fontWeight:FontWeight.w700, fontSize: 14.sp, recognizer: ()=> Navigator.pushNamed(context, RoutePaths.forgotPin)),
                //   ],),),
                HSpace(24.h),
                // buildResendOtp(context, (){}),
                HSpace(deviceHeight(context)/2.h),
                // HSpace(116.h),
                // CustomButton(isActive: true, margin: 1, title: "Continue", onPress: ()=> Navigator.pushNamed(context, RoutePaths.bottomNav)), HSpace(20.h)
              ],),
          ),
        ),
      ),
    );
  }

  Widget _buildPinInput(BuildContext context, EnterLoginVerificationViewModel viewModel){
    return Column( children: [
      Container(
        // color: Colors.white,
        margin: EdgeInsets.only(right: 100.w),
        // padding: const EdgeInsets.all(15.0),
        child: PinPut(
          keyboardType: TextInputType.number,
          fieldsCount: 4, eachFieldHeight: 48.h, eachFieldWidth: 48.w,
          onEditingComplete: viewModel.onEditingComplete,
          onSubmit: viewModel.onSubmit,
          focusNode: _pinPutFocusNode,
          controller: _pinPutController,
          submittedFieldDecoration: _controller.isCompleted
              ? _pinPutDecoration.copyWith(
            // borderRadius: BorderRadius.circular(20.0),
            color: AppColors.primaryColor.withOpacity(.1),
            border:
            Border.all(color: AppColors.primaryColor.withOpacity(.5)),
          )
              : _pinPutDecoration.copyWith(
            // borderRadius: BorderRadius.circular(20.0),
            color: AppColors.primaryColor.withOpacity(.1),
            border: Border.all(
                color: AppColors.primaryColor.withOpacity(.5)),
          ),
          selectedFieldDecoration: _pinPutDecoration.copyWith(
              color: AppColors.primaryColor.withOpacity(.1),
              border: Border.all(color: AppColors.primaryColor)),
          followingFieldDecoration: _pinPutDecoration.copyWith(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    ],);
  }
}
