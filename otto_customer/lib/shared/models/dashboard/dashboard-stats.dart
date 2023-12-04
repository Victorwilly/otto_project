class DashboardStatsDto {
  bool? error;
  String? message;
  DashboardStats? data;

  DashboardStatsDto({this.error, this.message, this.data});

  DashboardStatsDto.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? DashboardStats.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DashboardStats {
  int? totalPointsEarned;
  int? totalCashValue;
  int? totalPointsUsed;
  int? platformPointsEarned;
  int? merchantPointsEarned;
  List<RecentTransactions>? recentTransactions;
  List<TopMerchant>? topMerchant;

  DashboardStats(
      {this.totalPointsEarned,
      this.totalCashValue,
      this.totalPointsUsed,
      this.platformPointsEarned,
      this.merchantPointsEarned,
      this.recentTransactions,
      this.topMerchant});

  DashboardStats.fromJson(Map<String, dynamic> json) {
    totalPointsEarned = json['totalPointsEarned'];
    totalCashValue = json['totalCashValue'];
    totalPointsUsed = json['totalPointsUsed'];
    platformPointsEarned = json['platformPointsEarned'];
    merchantPointsEarned = json['merchantPointsEarned'];
    if (json['recentTransactions'] != null) {
      recentTransactions = <RecentTransactions>[];
      json['recentTransactions'].forEach((v) {
        recentTransactions!.add(RecentTransactions.fromJson(v));
      });
    }
    if (json['topMerchant'] != null) {
      topMerchant = <TopMerchant>[];
      json['topMerchant'].forEach((v) {
        topMerchant!.add(TopMerchant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalPointsEarned'] = totalPointsEarned;
    data['totalCashValue'] = totalCashValue;
    data['totalPointsUsed'] = totalPointsUsed;
    data['platformPointsEarned'] = platformPointsEarned;
    data['merchantPointsEarned'] = merchantPointsEarned;
    if (recentTransactions != null) {
      data['recentTransactions'] =
          recentTransactions!.map((v) => v.toJson()).toList();
    }
    if (topMerchant != null) {
      data['topMerchant'] = topMerchant!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecentTransactions {
  int? id;
  int? userId;
  int? cardId;
  String? reference;
  String? channel;
  String? currency;
  String? gatewayResponse;
  String? amount;
  String? fee;
  String? status;
  String? plan;
  String? paidAt;
  String? initializedAt;
  String? createdAt;
  String? updatedAt;

  RecentTransactions(
      {this.id,
      this.userId,
      this.cardId,
      this.reference,
      this.channel,
      this.currency,
      this.gatewayResponse,
      this.amount,
      this.fee,
      this.status,
      this.plan,
      this.paidAt,
      this.initializedAt,
      this.createdAt,
      this.updatedAt});

  RecentTransactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cardId = json['card_id'];
    reference = json['reference'];
    channel = json['channel'];
    currency = json['currency'];
    gatewayResponse = json['gateway_response'];
    amount = json['amount'];
    fee = json['fee'];
    status = json['status'];
    plan = json['plan'];
    paidAt = json['paid_at'];
    initializedAt = json['initialized_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['card_id'] = cardId;
    data['reference'] = reference;
    data['channel'] = channel;
    data['currency'] = currency;
    data['gateway_response'] = gatewayResponse;
    data['amount'] = amount;
    data['fee'] = fee;
    data['status'] = status;
    data['plan'] = plan;
    data['paid_at'] = paidAt;
    data['initialized_at'] = initializedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class TopMerchant {
  int? id;
  int? userId;
  String? companyName;
  String? companyRegNo;
  String? createdAt;
  String? updatedAt;
  Merchant? merchant;

  TopMerchant(
      {this.id,
      this.userId,
      this.companyName,
      this.companyRegNo,
      this.createdAt,
      this.updatedAt,
      this.merchant});

  TopMerchant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    companyName = json['company_name'];
    companyRegNo = json['company_reg_no'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    merchant =
        json['merchant'] != null ? Merchant.fromJson(json['merchant']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['company_name'] = companyName;
    data['company_reg_no'] = companyRegNo;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (merchant != null) {
      data['merchant'] = merchant!.toJson();
    }
    return data;
  }
}

class Merchant {
  int? id;
  String? firstname;
  String? lastname;
  String? networkProvider;
  String? countryCode;
  String? phoneno;
  dynamic email;
  dynamic hearAboutUs;
  dynamic referralCode;
  dynamic referral;
  dynamic emailVerifiedAt;
  dynamic otp;
  dynamic departmentId;
  dynamic image;
  int? isVerified;
  int? isActive;
  int? canLogin;
  int? isCompleted;
  int? i2fa;
  String? createdAt;
  String? updatedAt;
  List<String>? roles;
  dynamic userbilling;
  dynamic usershipping;

  Merchant(
      {this.id,
      this.firstname,
      this.lastname,
      this.networkProvider,
      this.countryCode,
      this.phoneno,
      this.email,
      this.hearAboutUs,
      this.referralCode,
      this.referral,
      this.emailVerifiedAt,
      this.otp,
      this.departmentId,
      this.image,
      this.isVerified,
      this.isActive,
      this.canLogin,
      this.isCompleted,
      this.i2fa,
      this.createdAt,
      this.updatedAt,
      this.roles,
      this.userbilling,
      this.usershipping});

  Merchant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    networkProvider = json['network_provider'];
    countryCode = json['country_code'];
    phoneno = json['phoneno'];
    email = json['email'];
    hearAboutUs = json['hear_about_us'];
    referralCode = json['referral_code'];
    referral = json['referral'];
    emailVerifiedAt = json['email_verified_at'];
    otp = json['otp'];
    departmentId = json['department_id'];
    image = json['image'];
    isVerified = json['is_verified'];
    isActive = json['is_active'];
    canLogin = json['can_login'];
    isCompleted = json['is_completed'];
    i2fa = json['2fa'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['roles'] != null) {
      roles = <String>[];
      json['roles'].forEach((v) {
        roles!.add(v);
      });
    }
    userbilling = json['userbilling'];
    usershipping = json['usershipping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['network_provider'] = networkProvider;
    data['country_code'] = countryCode;
    data['phoneno'] = phoneno;
    data['email'] = email;
    data['hear_about_us'] = hearAboutUs;
    data['referral_code'] = referralCode;
    data['referral'] = referral;
    data['email_verified_at'] = emailVerifiedAt;
    data['otp'] = otp;
    data['department_id'] = departmentId;
    data['image'] = image;
    data['is_verified'] = isVerified;
    data['is_active'] = isActive;
    data['can_login'] = canLogin;
    data['is_completed'] = isCompleted;
    data['2fa'] = i2fa;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (roles != null) {
      data['roles'] = roles!.map((v) => v).toList();
    }
    data['userbilling'] = userbilling;
    data['usershipping'] = usershipping;
    return data;
  }
}
