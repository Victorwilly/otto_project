import 'package:otto_customer/modules/authentication/create_account/view_models/create_account_vm.dart';
import 'package:otto_customer/shared/widgets/all_package.dart';
import 'package:otto_customer/shared/widgets/new_loading.dart';
import 'package:provider/provider.dart';


class ConfirmPin extends StatefulWidget {
  const ConfirmPin({Key? key, this.viewModel}) : super(key: key);
  final CreateAccountViewModel? viewModel;


  @override
  State<ConfirmPin> createState() => _ConfirmPinState();
}

class _ConfirmPinState extends State<ConfirmPin> with TickerProviderStateMixin {
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
    // return BaseView<CreateAccountViewModel>(
    //     vmBuilder: (context) => widget.viewModel!,
    //     builder: _buildScreen);

    return ChangeNotifierProvider<CreateAccountViewModel>(
      create: (_) => widget.viewModel!,
      child: Consumer<CreateAccountViewModel>(
        builder: (context, viewModel, _) => Stack(
          children: [
            _buildScreen(context, viewModel),
            newLoader(viewModel.newLoad)
          ],
        ),
      ),
    );
  }

  Widget _buildScreen(BuildContext context, CreateAccountViewModel viewModel) {
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
                pagePointer(firstNum: "5", color: AppColors.pink),
                HSpace(39.h),
                Styles.bold("Confirm PIN", color: AppColors.blue2, fontSize: 24.sp),
                HSpace(32.h),
                SizedBox(child: RichText(text: TextSpan(
                  // style: TextStyle(),
                  children: [
                    Styles.spanRegular("This PIN will be used to login to your account and authorization transaction ", color: AppColors.iconGrey, fontSize: 14.sp),
                  ],),),),
                HSpace(24.h), _buildPinInput(context, viewModel),
                HSpace(24.h),
                // buildResendOtp(context, (){}),
                // HSpace(deviceHeight(context)/2.4.h),
                HSpace(116.h),
                // CustomButton(isActive: true, margin: 1, title: "Continue", onPress: ()=> Navigator.pushNamed(context, RoutePaths.successRegistration)), HSpace(20.h)

              ],),
          ),
        ),
      ),
    );
  }

  Widget _buildPinInput(BuildContext context, CreateAccountViewModel viewModel){
    return Column( children: [
      Container(
        // color: Colors.white,
        margin: EdgeInsets.only(right: 100.w),
        // padding: const EdgeInsets.all(15.0),
        child: PinPut(
          keyboardType: TextInputType.number,
          fieldsCount: 4, eachFieldHeight: 48.h, eachFieldWidth: 48.w,
          controller: viewModel.confirmPinPutController,
          validator: FieldValidator.validateOtp,
          onEditingComplete: viewModel.onEditingComplete,
          onSubmit: viewModel.onSubmit,
          focusNode: _pinPutFocusNode,
          // controller: _pinPutController,
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
