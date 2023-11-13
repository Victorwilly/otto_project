import 'package:otto_customer/modules/authentication/create_account/account_verification.dart';
import 'package:otto_customer/shared/widgets/all_package.dart';
import 'package:otto_customer/shared/widgets/new_loading.dart';


class SetupAccountViewModel extends BaseViewModel {
  SetupAccountViewModel({this.context, this.authenticationService});

  final BuildContext? context;
  final AuthenticationService? authenticationService;
  String? message;
  final phoneNumberController = TextEditingController();
  final countryController = TextEditingController();
  String? networkProvider;
  bool? isNetworkValueEmpty;
  bool newLoad = false;
  List<String> networkList = ["MTN", "Airtel", "Glo"];

  @override
  FutureOr<void> init() {}

  loading(bool isLoad) {
    newLoad = isLoad;
    notifyListeners();
  }

 selectNetworkProvider(String? netProvider) {
    networkProvider = netProvider;
    isNetworkValueEmpty = dropBorder(value: networkProvider, isEmpty: isNetworkValueEmpty);
    super.notifyListeners();
 }

 bool dropBorder({String? value, bool? isEmpty}) {
   if(value == null) {
     isEmpty = true;
     notifyListeners();
     return isEmpty;
   } else {
     isEmpty = false;
     notifyListeners();
     return isEmpty;
   }
 }

 dynamic onChanged(PhoneNumber phone) {
    countryController.text = phone.countryCode!;
    notifyListeners();
 }

  void validateSetupAccount(GlobalKey<FormState> formKey) async {
    Map<String, dynamic>? body = {
      "network_provider": networkProvider,
      "country_code": countryController.text,
      "phone_number": phoneNumberController.text
    };
    isNetworkValueEmpty = dropBorder(value: networkProvider, isEmpty: isNetworkValueEmpty);

    if(formKey.currentState!.validate() && !isNetworkValueEmpty!) {
      formKey.currentState!.save;
      if (await setupAccount(data: body)) {
        snackBar(context: context!, message: message!, isError: false);
        // Navigator.pushNamed(context!, RoutePaths.accountVerification);
        Navigator.push(
          context!, MaterialPageRoute(builder: (context) => AccountVerification(
            dialCode: countryController.text,  phoneNumber: phoneNumberController.text),
          ),
        );
      } else {
        snackBar(context: context!, message: message!, isError: true);
      }
    }
  }

  Future<bool> setupAccount({Map<String, dynamic>? data}) async {
    loading(true);
    try {
      final ApiResponse<SetupAccountDto> res =
      await authenticationService!.setupAccountService(data!);
      // debugPrint("setupAccount message from res ${res.message}");
      if (res.error!) {
        // debugPrint("setupAccount error message ${res.message}");
        message = res.message ?? "Error occurred vm";
        loading(false);
        return false;
      } else {
        // message = "Success!";
        message = res.message;
        // debugPrint("setupAccount success message ${res.message}");
        // debugPrint("setupAccount success data ${res.data}");
        loading(false);
        return true;
      }
    } catch (e) {
      loading(false);
      message = e.toString();
      // debugPrint("setupAccount catch message $e");
      return false;
    }
  }

}