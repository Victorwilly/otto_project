import 'package:otto_customer/modules/authentication/login/view_models/login_vm.dart';

import '../../../shared/widgets/all_package.dart';

class NewLogin extends StatelessWidget {
  NewLogin({Key? key}) : super(key: key);
  String? completeNo;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (_) => LoginViewModel(
        context: context,
        authenticationService: si.authenticationService,
      ),
      child: Consumer<LoginViewModel>(
        builder: (context, viewModel, _) => Stack(
          children: [
            _buildScreen(context, viewModel),
            newLoader(viewModel.newLoad)
          ],
        ),
      ),
    );
  }

  Widget _buildScreen(BuildContext context, LoginViewModel viewModel) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBGColor,
      appBar: buildAppbar(context: context),
      body: SizedBox(
        width: deviceWidth(context),
        height: deviceHeight(context),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: viewModel.newLoginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HSpace(39.h),
                  Styles.bold("Welcome back", color: AppColors.blue2, fontSize: 24.sp),
                  HSpace(30.h),
                  CustomIntlPhoneNumber(
                    phoneNoController: viewModel.phoneNumberController,
                    onChanged: viewModel.onChanged,
                  ),
                  HSpace(8.h),
                  Styles.regular("Input phone number connected to your account", color: AppColors.blackText, fontSize: 12.sp),
                  // HSpace(56.h),
                  HSpace(deviceHeight(context)/2.h),
                  CustomButton(isActive: true, margin: 0.w, title: "Continue", onPress: viewModel.validateLoginRequest),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
