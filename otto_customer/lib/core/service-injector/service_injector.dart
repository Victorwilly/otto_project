import 'package:otto_customer/core/base/user-service-model.dart';
import 'package:otto_customer/core/services/authentication_service.dart';
import 'package:otto_customer/core/services/dashboard_service.dart';

import '../services/services.dart';

class Injector {
  StoreService storeService = StoreService();
  StorageService storageService = StorageService();
  // LayoutService layoutService = LayoutService();
  ApiService? apiService;
  late AuthenticationService authenticationService;
  late DashboardService dashboardService;
  late UserService userService;

  Future<bool> init() async {
    await storageService.initStorage();
    apiService = ApiService(storeService);
    authenticationService = AuthenticationService(
        storageService: storageService,
        storeService: storeService,
        apiService: apiService!);
    dashboardService = DashboardService(
        storageService: storageService, storeService: storeService);
    userService = UserService();
    return true;
  }
}

Injector si = Injector();
