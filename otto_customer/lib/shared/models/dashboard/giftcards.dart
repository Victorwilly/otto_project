class GiftcardDto {
  bool? error;
  String? message;
  GiftCardRes? data;

  GiftcardDto({this.error, this.message, this.data});

  GiftcardDto.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? GiftCardRes.fromJson(json['data']) : null;
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

class GiftCardRes {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  GiftCardRes(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  GiftCardRes.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Data {
  int? id;
  int? merchantGiftCardId;
  int? orderId;
  int? orderDetailsId;
  int? userId;
  int? receiverId;
  int? value;
  int? balance;
  String? giftCardID;
  String? personal;
  String? phoneno;
  String? email;
  String? status;
  dynamic createdAt;
  dynamic updatedAt;
  MerchantGiftCard? merchantGiftCard;

  Data(
      {this.id,
      this.merchantGiftCardId,
      this.orderId,
      this.orderDetailsId,
      this.userId,
      this.receiverId,
      this.value,
      this.balance,
      this.giftCardID,
      this.personal,
      this.phoneno,
      this.email,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.merchantGiftCard});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantGiftCardId = json['merchant_gift_card_id'];
    orderId = json['order_id'];
    orderDetailsId = json['order_details_id'];
    userId = json['user_id'];
    receiverId = json['receiver_id'];
    value = json['value'];
    balance = json['balance'];
    giftCardID = json['giftCardID'];
    personal = json['personal'];
    phoneno = json['phoneno'];
    email = json['email'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    merchantGiftCard = json['merchant_gift_card'] != null
        ? MerchantGiftCard.fromJson(json['merchant_gift_card'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['merchant_gift_card_id'] = merchantGiftCardId;
    data['order_id'] = orderId;
    data['order_details_id'] = orderDetailsId;
    data['user_id'] = userId;
    data['receiver_id'] = receiverId;
    data['value'] = value;
    data['balance'] = balance;
    data['giftCardID'] = giftCardID;
    data['personal'] = personal;
    data['phoneno'] = phoneno;
    data['email'] = email;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (merchantGiftCard != null) {
      data['merchant_gift_card'] = merchantGiftCard!.toJson();
    }
    return data;
  }
}

class MerchantGiftCard {
  int? id;
  int? merchantId;
  int? confettiStyleId;
  String? title;
  String? description;
  String? uploadType;
  dynamic fileUrl;
  String? colorCode;
  dynamic barcodeId;
  String? price;
  int? isAvailable;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  Merchant? merchant;

  MerchantGiftCard(
      {this.id,
      this.merchantId,
      this.confettiStyleId,
      this.title,
      this.description,
      this.uploadType,
      this.fileUrl,
      this.colorCode,
      this.barcodeId,
      this.price,
      this.isAvailable,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.merchant});

  MerchantGiftCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantId = json['merchant_id'];
    confettiStyleId = json['confetti_style_id'];
    title = json['title'];
    description = json['description'];
    uploadType = json['upload_type'];
    fileUrl = json['file_url'];
    colorCode = json['color_code'];
    barcodeId = json['barcode_id'];
    price = json['price'];
    isAvailable = json['is_available'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    merchant =
        json['merchant'] != null ? Merchant.fromJson(json['merchant']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['merchant_id'] = merchantId;
    data['confetti_style_id'] = confettiStyleId;
    data['title'] = title;
    data['description'] = description;
    data['upload_type'] = uploadType;
    data['file_url'] = fileUrl;
    data['color_code'] = colorCode;
    data['barcode_id'] = barcodeId;
    data['price'] = price;
    data['is_available'] = isAvailable;
    data['is_active'] = isActive;
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
  String? email;
  dynamic hearAboutUs;
  dynamic referralCode;
  dynamic referral;
  String? emailVerifiedAt;
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
  List<Roles>? roles;
  dynamic userbilling;
  dynamic usershipping;
  Merchantinformation? merchantinformation;

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
      this.usershipping,
      this.merchantinformation});

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
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    }
    userbilling = json['userbilling'];
    usershipping = json['usershipping'];
    merchantinformation = json['merchantinformation'] != null
        ? Merchantinformation.fromJson(json['merchantinformation'])
        : null;
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
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    data['userbilling'] = userbilling;
    data['usershipping'] = usershipping;
    if (merchantinformation != null) {
      data['merchantinformation'] = merchantinformation!.toJson();
    }
    return data;
  }
}

class Roles {
  int? id;
  String? name;
  String? slug;
  String? description;
  int? level;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  Pivot? pivot;

  Roles(
      {this.id,
      this.name,
      this.slug,
      this.description,
      this.level,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.pivot});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    level = json['level'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['description'] = description;
    data['level'] = level;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? userId;
  int? roleId;
  String? createdAt;
  String? updatedAt;

  Pivot({this.userId, this.roleId, this.createdAt, this.updatedAt});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    roleId = json['role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['role_id'] = roleId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Merchantinformation {
  int? id;
  int? userId;
  String? companyName;
  String? companyRegNo;
  String? createdAt;
  String? updatedAt;

  Merchantinformation(
      {this.id,
      this.userId,
      this.companyName,
      this.companyRegNo,
      this.createdAt,
      this.updatedAt});

  Merchantinformation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    companyName = json['company_name'];
    companyRegNo = json['company_reg_no'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['company_name'] = companyName;
    data['company_reg_no'] = companyRegNo;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
