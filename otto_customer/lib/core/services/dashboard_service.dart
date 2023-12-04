// ignore_for_file: null_argument_to_non_null_type
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otto_customer/core/services/api_service.dart';
import 'package:otto_customer/shared/models/dashboard/dashboard-stats.dart';
import 'package:otto_customer/shared/models/dashboard/giftcards.dart';
import 'package:otto_customer/shared/models/dashboard/merchants_dto.dart';

import '../../shared/models/api_model.dart';
import 'storage_service.dart';
import 'store_service.dart';

class DashboardService {
  DashboardService({
    required this.storageService,
    required this.storeService,
    required this.apiService,
  });

  StorageService storageService;
  StoreService storeService;
  ApiService apiService;

  Future<ApiResponse<DashboardStatsDto>> dataOwnerDashboardStatisticsService(
    Map<String, String> params,
    // { required BuildContext context}
  ) {
    return apiService.getApi(
      'customer/dashboard',
      // params: params,
      // context: context,
      useToken: true,
      transform: (dynamic res) {
        return DashboardStatsDto.fromJson(res);
      },
    );
  }

  Future<ApiResponse<GiftcardDto>> getGiftCards(
    Map<String, String> params,
  ) {
    return apiService.postApi<GiftcardDto>(
      'merchant/giftcards/all', params,
      useToken: true,
      // context,
      transform: (dynamic res) {
        debugPrint("getGiftCards transform message ${res["message"]}");
        return GiftcardDto.fromJson(res);
        // return res;
      },
    );
  }

  Future<ApiResponse<MerchantsDto>> getMerchants(
    Map<String, String> params,
  ) {
    return apiService.postApi<MerchantsDto>(
      'customer/dashboard/all_merchants',
      params,
      useToken: true,
      // context,
      transform: (dynamic res) {
        debugPrint("getMerchants transform message ${res["message"]}");
        return MerchantsDto.fromJson(res);
        // return res;
      },
    );
  }
}
