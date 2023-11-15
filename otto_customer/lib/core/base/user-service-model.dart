import 'package:otto_customer/shared/models/authentication/authentication_dto.dart';

class UserService {
  LoginData? loginData;

  setUserInfo(LoginData info) {
    loginData = info;
  }

  reset() {
    loginData = LoginData();
  }
}
