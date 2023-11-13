import 'package:otto_customer/modules/authentication/create_account/view_models/create_account_vm.dart';
import 'package:otto_customer/shared/widgets/all_package.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({Key? key}) : super(key: key);
  final GlobalKey<FormState> _infoFormKey = GlobalKey();
  String? completeNo;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateAccountViewModel>(
      create: (_) => CreateAccountViewModel(
          context: context, authenticationService: si.authenticationService),
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
      backgroundColor: AppColors.scaffoldBGColor,
      appBar: buildAppbar(context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _infoFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HSpace(39.h),
                pagePointer(firstNum: "3", color: AppColors.amber),
                HSpace(39.h),
                Styles.bold("Complete your information",
                    color: AppColors.blue2, fontSize: 24.sp),
                HSpace(32.h),
                CustomTextFormField(
                  label: "First name",
                  hintText: "Enter first name",
                  controller: viewModel.firstNameController,
                  textInputType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FieldValidator.validate,
                ),
                HSpace(16.h),
                CustomTextFormField(
                  label: "Last name",
                  hintText: "Enter last name",
                  controller: viewModel.lastNameController,
                  textInputType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FieldValidator.validate,
                ),
                HSpace(16.h),
                Styles.regular("Network provider", fontSize: 14.sp, color: AppColors.black2,
                    fontWeight: FontWeight.w400),
                HSpace(8.h),
                CustomDropDown(
                  hintText: "Select network provider",
                  isExpanded: true,
                  dropDownValue: viewModel.networkProvider,
                  onChanged: viewModel.selectNetworkProvider,
                  isValueEmpty: viewModel.isNetworkValueEmpty??false,
                  items: viewModel.networkList.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child:
                          Styles.regular(value, color: AppColors.blackText),
                    );
                  }).toList(),
                ),
                HSpace(16.h),
                CustomIntlPhoneNumber(
                  phoneNoController: viewModel.phoneNumberController,
                  onChanged: viewModel.onChanged,
                ),
                HSpace(8.h),
                Styles.regular("This would be your user ID",
                    color: AppColors.blackText, fontSize: 12.sp),
                HSpace(56.h),
                CustomButton(
                    isActive: true,
                    margin: 0.w,
                    title: "Continue",
                    onPress: () => viewModel.validateCreateAccount(
                        _infoFormKey, viewModel)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
