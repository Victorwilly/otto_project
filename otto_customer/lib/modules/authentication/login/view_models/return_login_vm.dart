import 'package:otto_customer/shared/models/authentication/authentication_dto.dart';
import 'package:otto_customer/shared/models/authentication/login_verification_dto.dart';
import 'package:otto_customer/shared/models/authentication/request_login_dto.dart';
import 'package:otto_customer/shared/widgets/all_package.dart';

class ReturnLoginViewModel extends BaseViewModel {
  ReturnLoginViewModel({this.userData, this.context, this.authenticationService});

  final BuildContext? context;
  final AuthenticationService? authenticationService;
  final UserData? userData;

  String? message;
  bool newLoad = false;
  GlobalKey<FormState> newLoginFormKey = GlobalKey<FormState>();

  final TextEditingController pinPutController = TextEditingController();
  final FocusNode pinPutFocusNode = FocusNode();
  bool confirm = false;
  var codeInputComplete;

  BoxDecoration get pinPutDecoration {
    return BoxDecoration(
      color: AppColors.white,
      border: Border.all(color: AppColors.borderGrey),
      borderRadius: BorderRadius.circular(4.0),
    );
  }

  @override
  FutureOr<void> init() {}

  loading(bool isLoad) {
    newLoad = isLoad;
    notifyListeners();
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
      "phoneno": userData!.phoneno!.trim(),
      "pin": val.trim()
    };
    bool isPassed = await accountLogin(data: body);

    if (isPassed) {
      // pinPutController.text = "";
      // isLoading = true;
      codeInputComplete = true;
      confirm = true;
      // successSnackBar(message: viewModel.message!, context: context!);
      snackBar(context: context!, message: message!, isError: false);
      Navigator.pushNamed(context!, RoutePaths.bottomNav);
      // Navigator.push(
      //   context!, MaterialPageRoute(builder: (context) => ReturnLogin(
      //   user: userData,),
      // ),
      // );
    } else {
      // isLoading = false;
      codeInputComplete = false;
      confirm = false;
      snackBar(context: context!, message: message!, isError: true);
    }
  }

  void validateLogout() async {
    Map<String, dynamic>? body = {
      "country_code": "countryController.text",
      "phone_number": "phoneNumberController.text"
    };

    // if (await logout(data: body)) {
    await si.storageService.reloadLocalState().then((value) {
      snackBar(context: context!, message: message!, isError: false);
      return Navigator.pushNamed(context!, RoutePaths.newSignIn);
    });
  }

  Future<bool> accountLogin({Map<String, dynamic>? data}) async {
    loading(true);
    try {
      final ApiResponse<AuthenticationDto> res =
      await authenticationService!.accountLoginService(data!);
      debugPrint("accountLogin message from res ${res.message}");
      if (res.error!) {
        debugPrint("accountLogin error message ${res.message}");
        message = res.message ?? "Error occurred vm";
        loading(false);
        return false;
      } else {
        // message = "Success!";
        message = res.message;
        persistData(res.data!.data!.toJson());
        debugPrint("accountLogin success message ${res.message}");
        debugPrint("accountLogin success data ${res.data}");
        loading(false);
        return true;
      }
    } catch (e) {
      loading(false);
      message = e.toString();
      debugPrint("accountLogin catch message $e");
      return false;
    }
  }

  Future<bool> logout({Map<String, dynamic>? data}) async {
    loading(true);
    try {
      final ApiResponse<RequestLoginDto> res =
      await authenticationService!.requestLoginService(data!);
      debugPrint("logout message from res ${res.message}");
      if (res.error!) {
        debugPrint("logout error message ${res.message}");
        message = res.message ?? "Error occurred vm";
        loading(false);
        return false;
      } else {
        // message = "Success!";
        message = res.message;
        debugPrint("logout success message ${res.message}");
        debugPrint("logout success data ${res.data}");
        loading(false);
        return true;
      }
    } catch (e) {
      loading(false);
      message = e.toString();
      debugPrint("logout catch message $e");
      return false;
    }
  }

  Future<void> persistData(res) async {
    debugPrint("PERSIST DATA $res");

    si.storageService.setItem('token', json.encode(res['accessToken']));
    si.storageService.setItem('auth_data', json.encode(res['data']));
    si.storageService.setItem('access_token', json.encode(res['accessToken']));
    Map<String, dynamic> decodedToken = JwtDecoder.decode(res['accessToken']);
  }
}