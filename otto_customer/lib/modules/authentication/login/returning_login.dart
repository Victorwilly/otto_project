import 'package:otto_customer/modules/authentication/login/view_models/login_vm.dart';
import 'package:otto_customer/modules/authentication/login/view_models/return_login_vm.dart';
import 'package:otto_customer/shared/models/authentication/login_verification_dto.dart';

import '../../../shared/widgets/all_package.dart';

class ReturnLogin extends StatefulWidget {
  const ReturnLogin({Key? key, this.user}) : super(key: key);
  final UserData? user;

  @override
  State<ReturnLogin> createState() => _ReturnLoginState();
}

class _ReturnLoginState extends State<ReturnLogin>  with TickerProviderStateMixin {
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
    return ChangeNotifierProvider<ReturnLoginViewModel>(
      create: (_) => ReturnLoginViewModel(
        context: context,
        userData: widget.user,
        authenticationService: si.authenticationService,
      ),
      child: Consumer<ReturnLoginViewModel>(
        builder: (context, viewModel, _) => Stack(
          children: [
            _buildScreen(context, viewModel),
            newLoader(viewModel.newLoad)
          ],
        ),
      ),
    );
  }

  Widget _buildScreen(BuildContext context, ReturnLoginViewModel viewModel) {
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
                Styles.bold("Welcome, ${widget.user!.firstname??""}", color: AppColors.blue2, fontSize: 24.sp),
                HSpace(32.h),
                SizedBox(child: RichText(text: TextSpan(
                  // style: TextStyle(),
                  children: [
                    Styles.spanRegular("Please enter your PIN to Log in.", color: AppColors.iconGrey, fontSize: 14.sp),
                  ],),),),
                HSpace(24.h), _buildPinInput(context, viewModel), HSpace(8.h),
                RichText(text: TextSpan(
                  // style: TextStyle(),
                  children: [
                    Styles.spanRegular("Forgot PIN? ", color: AppColors.blue2, fontSize: 14.sp),
                    Styles.spanRegular(" Tap to reset", color: AppColors.blue3, fontWeight:FontWeight.w700, fontSize: 14.sp, recognizer: ()=> Navigator.pushNamed(context, RoutePaths.forgotPin)),
                  ],),),
                HSpace(24.h),
                // buildResendOtp(context, (){}),
                HSpace(deviceHeight(context)/2.3.h),
                // HSpace(116.h),
                // CustomButton(isActive: true, margin: 1, title: "Continue", onPress: ()=> Navigator.pushNamed(context, RoutePaths.bottomNav)),
                HSpace(20.h),
                Center(
                  child: RichText(text: TextSpan(
                    // style: TextStyle(),
                    children: [
                      Styles.spanRegular("Not your account? ", color: AppColors.blue2, fontSize: 14.sp),
                      Styles.spanRegular(" Log Out", color: AppColors.blue3, fontWeight:FontWeight.w700, fontSize: 14.sp, recognizer: viewModel.validateLogout),
                    ],),),
                ),

              ],),
          ),
        ),
      ),
    );
  }

  Widget _buildPinInput(BuildContext context, ReturnLoginViewModel viewModel){
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

