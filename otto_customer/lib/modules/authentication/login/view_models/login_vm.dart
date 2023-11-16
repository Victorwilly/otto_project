import 'package:otto_customer/modules/authentication/login/enter_login_verification.dart';
import 'package:otto_customer/shared/models/authentication/request_login_dto.dart';
import 'package:otto_customer/shared/widgets/all_package.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel({this.context, this.authenticationService});

  final BuildContext? context;
  final AuthenticationService? authenticationService;
  String? message;
  final phoneNumberController = TextEditingController();
  final countryController = TextEditingController();
  bool newLoad = false;
  GlobalKey<FormState> newLoginFormKey = GlobalKey<FormState>();

  @override
  FutureOr<void> init() {}

  loading(bool isLoad) {
    newLoad = isLoad;
    notifyListeners();
  }

  dynamic onChanged(PhoneNumber phone) {
    countryController.text = phone.countryCode!;
    notifyListeners();
  }

  void validateLoginRequest() async {
    Map<String, dynamic>? body = {
      "country_code": countryController.text,
      "phone_number": phoneNumberController.text
    };

    if (newLoginFormKey.currentState!.validate()) {
      newLoginFormKey.currentState!.save;
      if (await requestLogin(data: body)) {
        snackBar(context: context!, message: message!, isError: false);
        Navigator.push(
          context!,
          MaterialPageRoute(
            builder: (context) => EnterLoginVerification(
                dialCode: countryController.text,
                phoneNumber: phoneNumberController.text),
          ),
        );
      } else {
        snackBar(context: context!, message: message!, isError: true);
      }
    }
  }

  Future<bool> requestLogin({Map<String, dynamic>? data}) async {
    loading(true);
    try {
      final ApiResponse<RequestLoginDto> res =
          await authenticationService!.requestLoginService(data!);
      debugPrint("requestLogin message from res ${res.message}");
      if (res.error!) {
        debugPrint("requestLogin error message ${res.message}");
        message = res.message ?? "Error occurred vm";
        loading(false);
        return false;
      } else {
        // message = "Success!";
        message = res.message;
        debugPrint("requestLogin success message ${res.message}");
        debugPrint("requestLogin success data ${res.data}");
        loading(false);
        return true;
      }
    } catch (e) {
      loading(false);
      message = e.toString();
      debugPrint("requestLogin catch message $e");
      return false;
    }
  }

  void set() {}
}
