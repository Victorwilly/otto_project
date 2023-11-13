import 'all_package.dart';

class CustomIntlPhoneNumber extends StatelessWidget {
   CustomIntlPhoneNumber({Key? key, this.phoneNoController, this.hintText='Enter phone number', this.onChanged, this.onSubmitted, this.focusNode}) : super(key: key);

  TextEditingController? phoneNoController;
  final String? hintText;
  final Function(PhoneNumber)? onChanged;
  final Function(String)? onSubmitted;
  final FocusNode?  focusNode ;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      // initialValue: ,
      keyboardType: TextInputType.number,
      iconPosition: IconPosition.trailing,
      // dropdownIconPosition: IconPosition.trailing,
      //   autofocus: false,
        focusNode: focusNode,
      validator: FieldValidator.validate,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: phoneNoController,
      dropdownDecoration: BoxDecoration(
        // color: AppColors.grey,
        borderRadius: BorderRadius.circular(6),
        // border: Border.all(color: borderTextFieldGreyColor, width: 1),
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
            vertical: 18, horizontal: 14),
        // fillColor: dropDownColor,
        filled: true,
        fillColor: AppColors.grey,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14.0,
          fontWeight: FWt.regular,
          // color: Colors.black45,
          color: AppColors.offBlack,
          fontFamily: 'Inter',
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.borderGrey,
            width: 0.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.borderGrey,
            width: 0.5,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: AppColors.primaryColor)),
        errorBorder: const OutlineInputBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.red)),
        labelStyle: const TextStyle(
            color: AppColors.blackText, fontSize: 12, height: 1.4),
      ),
      initialCountryCode: 'NG',
      onChanged: onChanged, onSubmitted: onSubmitted,
      // onChanged: (phone) {
      //   // if (formKey.currentState!.validate()) {
      //   //   PhoneNumberValidator.validatePhoneNumber(
      //   //       phone.completeNumber);
      //   // }
      //   // viewModel.completeNo = phone.completeNumber;
      //   completeNo = "${phone.countryCode}-${phone.number}";
      // },
    );
  }
}
