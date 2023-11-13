import 'package:otto_customer/core/services/authentication_service.dart';

import '../services/services.dart';

class Injector {
  StoreService storeService = StoreService();
  StorageService storageService = StorageService();
  // LayoutService layoutService = LayoutService();
  ApiService? apiService;
  late AuthenticationService authenticationService;
  // DashboardService? dashboardService;

  Future<bool> init() async {
    await storageService.initStorage();
    apiService = ApiService(storeService);
    authenticationService = AuthenticationService(
        storageService: storageService, storeService: storeService, apiService: apiService!);
    // dashboardService = DashboardService(
    //     storageService: storageService, storeService: storeService);
    return true;
  }
}

Injector si = Injector();
