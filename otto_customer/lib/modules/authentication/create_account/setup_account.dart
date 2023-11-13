import 'package:get/get.dart';
import 'package:otto_customer/shared/widgets/all_package.dart';
import 'package:otto_customer/shared/widgets/new_loading.dart';
import 'package:provider/provider.dart';

class SetupAccount extends StatelessWidget {
  SetupAccount({Key? key}) : super(key: key);
  final GlobalKey<FormState> _setupFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // return BaseView<SetupAccountViewModel>(
    //     vmBuilder: (context) => SetupAccountViewModel(context: context, authenticationService: si.authenticationService),
    //     builder: _buildScreen);

    return ChangeNotifierProvider<SetupAccountViewModel>(
      create: (_) => SetupAccountViewModel(
        context: context,
        authenticationService: si.authenticationService,
      ),
      child: Consumer<SetupAccountViewModel>(
        builder: (context, viewModel, _) => Stack(
          children: [
            _buildScreen(context, viewModel),
           newLoader(viewModel.newLoad)
          ],
        ),
      ),
    );
  }

  Widget _buildScreen(BuildContext context, SetupAccountViewModel viewModel) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBGColor,
      appBar: buildAppbar(context: context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _setupFormKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HSpace(39.h),
                  pagePointer(),
                  HSpace(39.h),
                  Styles.bold("Set up your accounts with just few steps", color: AppColors.blue2, fontSize: 24.sp),
                  HSpace(32.h),
                  CustomDropDown(hintText: "Network provider", isExpanded: true, isValueEmpty: viewModel.isNetworkValueEmpty??false,
                    dropDownValue: viewModel.networkProvider, onChanged: (value) => viewModel.selectNetworkProvider(value),
                    items: viewModel.networkList.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Styles.regular(value,
                            color: AppColors.blackText),
                      );
                    }).toList(),
                  ),
                  HSpace(16.h),
                  CustomIntlPhoneNumber(
                    phoneNoController: viewModel.phoneNumberController,
                    onChanged: viewModel.onChanged,
                  ),
                  HSpace(8.h),
                  Styles.regular("This would be your user ID", color: AppColors.blackText, fontSize: 12.sp),
                  HSpace(56.h),
                  CustomButton(isActive: true, margin: 0.w, title: "Continue", onPress: () => viewModel.validateSetupAccount(_setupFormKey)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
