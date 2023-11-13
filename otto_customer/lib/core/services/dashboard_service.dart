// ignore_for_file: null_argument_to_non_null_type
import 'dart:async';

import 'package:flutter/material.dart';

import '../../shared/models/api_model.dart';
import '../service-injector/service_injector.dart';
import 'storage_service.dart';
import 'store_service.dart';

class DashboardService {
  DashboardService({
    required this.storageService,
    required this.storeService,
  });

  StorageService storageService;
  StoreService storeService;

  Future<ApiResponse> dataOwnerDashboardStatisticsService(
      Map<String, String> params,
      {required BuildContext context}) {
    return si.apiService!.getApi(
      'Request/GetDataOwnerDashBoardStatistics',
      params: params,
      context: context,
      transform: (dynamic res) {
        return res;
      },
    );
  }
}
