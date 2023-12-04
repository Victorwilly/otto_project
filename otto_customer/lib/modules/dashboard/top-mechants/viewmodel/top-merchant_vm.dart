import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:otto_customer/core/base/base_viewmodel.dart';
import 'package:otto_customer/core/service-injector/service_injector.dart';
import 'package:otto_customer/shared/models/api_model.dart';
import 'package:otto_customer/shared/models/authentication/authentication_dto.dart';

class TopMerchantViewModel extends BaseViewModel {
  LoginData? data;

  bool _isLoading = false;
  String message = '';
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
    getDashboardStats();
  }

  Future<bool> getAllGiftCards() async {
    isLoading = (true);
    try {
      final ApiResponse<dynamic> res =
          await si.dashboardService.getGiftCards({"search_param": ""});
      debugPrint("requestLogin message from res ${res.message}");
      if (res.error!) {
        debugPrint("requestLogin error message ${res.message}");
        message = res.message ?? "Error occurred vm";
        isLoading = (false);
        return false;
      } else {
        // message = "Success!";
        // message = res.message;
        debugPrint("requestLogin success message ${res.message}");
        debugPrint("requestLogin success data ${res.data}");
        isLoading = (false);
        return true;
      }
    } catch (e) {
      isLoading = (false);
      message = e.toString();
      debugPrint("requestLogin catch message $e");
      return false;
    }
  }

  Future<bool> getDashboardStats() async {
    isLoading = (true);
    try {
      final ApiResponse<dynamic> res =
          await si.dashboardService.dataOwnerDashboardStatisticsService({});
      debugPrint("getDashboardStats message from res ${res.message}");
      if (res.error!) {
        debugPrint("getDashboardStats error message ${res.message}");
        message = res.message ?? "Error occurred vm";
        isLoading = (false);
        return false;
      } else {
        // message = "Success!";
        // message = res.message;
        debugPrint("getDashboardStats success message ${res.message}");
        debugPrint("getDashboardStats success data ${res.data}");
        isLoading = (false);
        return true;
      }
    } catch (e) {
      isLoading = (false);
      message = e.toString();
      debugPrint("getDashboardStats catch message $e");
      return false;
    }
  }
}
