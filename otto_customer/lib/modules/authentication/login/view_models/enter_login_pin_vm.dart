import 'package:otto_customer/modules/authentication/login/returning_login.dart';
import 'package:otto_customer/shared/models/authentication/account_verification_dto.dart';
import 'package:otto_customer/shared/models/authentication/login_verification_dto.dart';
import 'package:otto_customer/shared/widgets/all_package.dart';

class EnterLoginVerificationViewModel extends BaseViewModel {
  EnterLoginVerificationViewModel({required this.phoneNumber, this.context, this.authenticationService});

  final BuildContext? context;
  final AuthenticationService? authenticationService;
  String? message;
  String phoneNumber;
  bool newLoad = false;
  UserData? userData;

  @override
  FutureOr<void> init() {

  }

  loading(bool isLoad) {
    newLoad = isLoad;
    notifyListeners();
  }


  final TextEditingController pinPutController = TextEditingController();
  final FocusNode pinPutFocusNode = FocusNode();
  bool confirm = false;
  var codeInputComplete;
  // bool isLoading = false;

  BoxDecoration get pinPutDecoration {
    return BoxDecoration(
      color: AppColors.white,
      border: Border.all(color: AppColors.borderGrey),
      borderRadius: BorderRadius.circular(4.0),
    );
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
    // onSubmit() async {
    // isLoading = true;
    codeInputComplete = true;
    confirm = true;

    // viewModel.notify();
    notifyListeners();
    // isLoading = false;
    // debugPrint('outcome -> $val === ${pinPutController.text}');
    Map<String, dynamic>? body = {
      "phone_number": phoneNumber.trim(),
      "otp": val.trim()
    };
    bool isPassed = await loginVerification(data: body);

    if (isPassed) {
      // pinPutController.text = "";
      // isLoading = true;
      codeInputComplete = true;
      confirm = true;
      // successSnackBar(message: viewModel.message!, context: context!);
      snackBar(context: context!, message: message!, isError: false);
      Navigator.push(
        context!, MaterialPageRoute(builder: (context) => ReturnLogin(
          user: userData,),
      ),
      );
    } else {
      // isLoading = false;
      codeInputComplete = false;
      confirm = false;
      snackBar(context: context!, message: message!, isError: true);
    }
  }

  resend() async {
    bool isPassed = await resendOtp();

    if (isPassed) {
      snackBar(context: context!, message: message!, isError: false);
    } else {
      snackBar(context: context!, message: message!, isError: true);
    }
  }


  Future<bool> loginVerification({Map<String, dynamic>? data}) async {
    loading(true);
    try {
      final ApiResponse<LoginVerificationDto> res =
      await authenticationService!.loginVerificationService(data!);
      debugPrint("loginVerification message from res ${res.message}");

      if (res.error!) {
        debugPrint("loginVerification error message ${res.message}");
        message = res.message ?? "Error occurred vm";
        loading(false);
        return false;
      } else {
        // message = "Success!";
        message = res.message;
        userData = res.data!.data!;
        debugPrint("loginVerification success message $userData == ${res.message}");
        debugPrint("loginVerification success data ${res.data}");
        loading(false);
        return true;
      }
    } catch (e) {
      loading(false);
      message = e.toString();
      debugPrint("accountVerification catch message $e");
      return false;
    }
  }

  Future<bool> resendOtp({Map<String, dynamic>? data}) async {
    loading(true);

    try {
      final ApiResponse<SetupAccountDto> res =
      await authenticationService!.setupAccountService(data!);
      debugPrint("accountVerification message from res ${res.message}");

      if (res.error!) {
        debugPrint("accountVerification error message ${res.message}");
        message = res.message ?? "Error occurred vm";
        loading(false);
        return false;
      } else {
        // message = "Success!";
        message = res.message;
        debugPrint("accountVerification success message ${res.message}");
        debugPrint("accountVerification success data ${res.data}");
        loading(false);
        return true;
      }
    } catch (e) {
      loading(false);
      message = e.toString();
      debugPrint("accountVerification catch message $e");
      return false;
    }
  }

}