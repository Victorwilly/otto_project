import 'package:get/get.dart';
import 'package:otto_customer/modules/authentication/create_account/setup_pin.dart';
import 'package:otto_customer/modules/authentication/create_account/success_registration.dart';
import 'package:otto_customer/shared/models/authentication/create_account_dto.dart';
import 'package:otto_customer/shared/widgets/all_package.dart';

class CreateAccountViewModel extends BaseViewModel {
  final BuildContext? context;
  final AuthenticationService? authenticationService;
  String? message;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final countryController = TextEditingController();
  final pinPutController = TextEditingController();
  final confirmPinPutController = TextEditingController();
  String? networkProvider;
  bool? isNetworkValueEmpty;
  String? referralCode;


  CreateAccountViewModel({this.context, this.authenticationService});

  @override
  FutureOr<void> init() {}

  bool newLoad = false;

  loading(bool isLoad) {
    newLoad = isLoad;
    notifyListeners();
  }
  final FocusNode pinPutFocusNode = FocusNode();
  bool confirm = false;
  var codeInputComplete;

  List<String> networkList = ["MTN", "Airtel", "Glo"];

  selectNetworkProvider(String? netProvider) {
    networkProvider = netProvider;
    isNetworkValueEmpty =
        dropBorder(value: networkProvider, isEmpty: isNetworkValueEmpty);
    notifyListeners();
  }

  bool dropBorder({String? value, bool? isEmpty}) {
    if(value == null) {
      isEmpty = true;
      debugPrint("netwwork proveee empty");
      notifyListeners();
      return isEmpty;
    } else {
      isEmpty = false;
      debugPrint("netwwork proveee false");
      notifyListeners();
      return isEmpty;
    }
  }

  dynamic onChanged(PhoneNumber phone) {
    countryController.text = phone.countryCode!;
    notifyListeners();
  }

  void validateCreateAccount(formKey, vm) async {
    isNetworkValueEmpty =
        dropBorder(value: networkProvider, isEmpty: isNetworkValueEmpty);

    if (formKey.currentState.validate() && !isNetworkValueEmpty!) {
      // if (await createAccount(data: body)) {
      // snackBar(context: context!, message: message!, isError: false);
      // Navigator.pushNamed(context!, RoutePaths.accountVerification);
      // Navigator.pushNamed(context!, RoutePaths.setupPin);
      Navigator.push(
        context!,
        MaterialPageRoute(
          builder: (context) => SetupPin(viewModel: vm),
        ),
      );
    } else {
      // snackBar(context: context!, message: "Kindly fill all information", isError: true);
    }
    // }
  }

  onEditingComplete() {
    // setState(() {
    codeInputComplete = true;
    if (codeInputComplete) {
      confirm = true;
    } else {
      confirm = false;
    }
    // });
    // notifyListeners();
  }

  onSubmit(val) async {
    codeInputComplete = true;
    // confirm = true;

    // viewModel.notify();
    notifyListeners();
    // isLoading = false;
    // debugPrint('outcome -> $val === ${pinPutController.text}');
        if(pinPutController.text.trim() == val){
          confirm = true;
          Map<String, dynamic>? body = {
        "phone_number": phoneNumberController.text.trim(),
        "network_provider": networkProvider!.trim(),
        "country_code": countryController.text.trim(),
        "firstname": firstNameController.text.trim(),
        "lastname": lastNameController.text.trim(),
        "pin": pinPutController.text.trim(),
        "confirm_pin": confirmPinPutController.text.trim(),
      };
      bool isPassed = await createAccount(data: body);

      if (isPassed) {
        // pinPutController.text = "";
        // isLoading = true;
        codeInputComplete = true;
        confirm = true;
        // successSnackBar(message: viewModel.message!, context: context!);
        snackBar(context: context!, message: message!, isError: false);
        // Navigator.pushNamed(context!, RoutePaths.successRegistration);

        Navigator.push(
          context!,
          MaterialPageRoute(
            builder: (context) => SuccessRegistration(referralCode: referralCode??""),
          ),
        );
      } else {
        // isLoading = false;
        codeInputComplete = false;
        confirm = false;
        snackBar(context: context!, message: message!, isError: true);
      }
    } else {
          confirm = false;
          snackBar(context: context!, message: "Setup PIN mismatch!", isError: true);
        }
  }

  Future<bool> createAccount({Map<String, dynamic>? data}) async {
    loading(true);

    try {
      final ApiResponse<CreateAccountDto> res =
          await authenticationService!.createAccountService(data!);
      debugPrint("createAccount message from res ${res.message}");

      if (res.error!) {
        debugPrint("createAccount error message ${res.message}");
        message = res.message ?? "Error occurred vm";
        loading(false);
        return false;
      } else {
        // message = "Success!";
        message = res.message;
        debugPrint("createAccount success message ${res.message}");
        debugPrint("createAccount success data ${res.data}");
        referralCode = res.data!.data!.referralCode;
        loading(false);
        return true;
      }
    } catch (e) {
      loading(false);
      message = e.toString();
      debugPrint("createAccount catch message $e");
      return false;
    }
  }
}
