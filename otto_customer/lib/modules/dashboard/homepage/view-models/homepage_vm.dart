import 'dart:async';

import 'package:otto_customer/core/base/base_viewmodel.dart';
import 'package:otto_customer/core/service-injector/service_injector.dart';
import 'package:otto_customer/shared/models/authentication/authentication_dto.dart';

class HomePageViewModel extends BaseViewModel {
  LoginData? data;

  bool _isLoading = false;

  @override
  bool get isLoading => _isLoading;

  set isLoading(bool l) {
    _isLoading = l;
    notifyListeners();
  }

  getUserInfo() {
    data = si.userService.loginData;
  }

  @override
  FutureOr<void> init() {
    getUserInfo();
  }
}
