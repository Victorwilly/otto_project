import 'package:otto_customer/modules/authentication/create_account/confirm_pin.dart';
import 'package:otto_customer/modules/authentication/create_account/view_models/create_account_vm.dart';
import 'package:otto_customer/shared/widgets/all_package.dart';

class SetupPin extends StatefulWidget {
  const SetupPin({Key? key, this.viewModel}) : super(key: key);
  final CreateAccountViewModel? viewModel;

  @override
  State<SetupPin> createState() => _SetupPinState();
}

class _SetupPinState extends State<SetupPin> with TickerProviderStateMixin {
  late AnimationController _controller;
  int levelClock = 300;
  final GlobalKey<FormState> _setupPinKey = GlobalKey();
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
                pagePointer(firstNum: "4", color: AppColors.pink),
                HSpace(39.h),
                Styles.bold("Setup your PIN", color: AppColors.blue2, fontSize: 24.sp),
                HSpace(32.h),
                SizedBox(child: RichText(text: TextSpan(
                  // style: TextStyle(),
                  children: [
                    Styles.spanRegular("This PIN will be used to login to your account and authorization transaction ", color: AppColors.iconGrey, fontSize: 14.sp),
                  ],),),),
                HSpace(24.h), _buildPinInput(context, (){}, (val){}, ), HSpace(8.h),
                Styles.regular("No repeated or continuous numbers (e.g 0000, 1234)", color: AppColors.blue2, fontSize: 14.sp),
                HSpace(24.h),
                // buildResendOtp(context, (){}),
                // HSpace(deviceHeight(context)/2.4.h),
                HSpace(116.h),
                CustomButton(isActive: true, margin: 1, title: "Continue", onPress: () {
                      if(_setupPinKey.currentState!.validate()) {
                        _setupPinKey.currentState!.save();
                        // Navigator.pushNamed(context, RoutePaths.confirmPin);
                        Navigator.push(
                          context!,
                          MaterialPageRoute(
                            builder: (context) => ConfirmPin(viewModel: widget.viewModel),
                          ),
                        );
                      }
                }), HSpace(20.h)

              ],),
          ),
        ),
      ),
    );
  }

  Widget _buildPinInput(BuildContext context, Function()? onEditingComplete, Function(String)? onSubmit){
    return Column( children: [
      Container(
        // color: Colors.white,
        margin: EdgeInsets.only(right: 100.w),
        // padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _setupPinKey,
          child: PinPut(
            keyboardType: TextInputType.number,
            fieldsCount: 4, eachFieldHeight: 48.h, eachFieldWidth: 48.w,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            focusNode: _pinPutFocusNode,
            // controller: _pinPutController,
            controller: widget.viewModel!.pinPutController,
            validator: FieldValidator.validateOtp,
            onEditingComplete: () {
                // if(_setupPinKey.currentState!.validate()) {
              setState(() {
                  codeInputComplete = true;
                  if (codeInputComplete) {
                    _confirm = true;
                  } else {
                    _confirm = false;
                  }
              });
                // }
            },
            onSubmit: (val) async {
                  debugPrint('outcome -> $val');
                  widget.viewModel!.pinPutController.text = val;
            },
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
      ),
    ],);
  }
}
