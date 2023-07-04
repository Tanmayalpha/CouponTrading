class GetProfile {
  bool? error;
  String? message;
  List<UserData>? data;

  GetProfile({this.error, this.message, this.data});

  GetProfile.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserData>[];
      json['data'].forEach((v) {
        data!.add(new UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  String? id;
  String? ipAddress;
  String? username;
  String? password;
  String? email;
  String? mobile;
  String? image;
  String? imageSm;
  String? balance;
  String? activationSelector;
  String? activationCode;
  String? forgottenPasswordSelector;
  String? forgottenPasswordCode;
  String? forgottenPasswordTime;
  String? rememberSelector;
  String? rememberCode;
  String? createdOn;
  String? lastLogin;
  String? active;
  String? company;
  String? address;
  String? bonus;
  String? cashReceived;
  String? dob;
  String? countryCode;
  String? city;
  String? area;
  String? street;
  String? pincode;
  String? serviceableZipcodes;
  String? apikey;
  String? referralCode;
  String? friendsCode;
  String? fcmId;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? adharno;
  String? panno;
  String? accountNo;
  String? accountName;
  String? ifscCode;
  String? bankName;

  UserData(
      {this.id,
        this.ipAddress,
        this.username,
        this.password,
        this.email,
        this.mobile,
        this.image,
        this.imageSm,
        this.balance,
        this.activationSelector,
        this.activationCode,
        this.forgottenPasswordSelector,
        this.forgottenPasswordCode,
        this.forgottenPasswordTime,
        this.rememberSelector,
        this.rememberCode,
        this.createdOn,
        this.lastLogin,
        this.active,
        this.company,
        this.address,
        this.bonus,
        this.cashReceived,
        this.dob,
        this.countryCode,
        this.city,
        this.area,
        this.street,
        this.pincode,
        this.serviceableZipcodes,
        this.apikey,
        this.referralCode,
        this.friendsCode,
        this.fcmId,
        this.latitude,
        this.longitude,
        this.createdAt,
        this.adharno,
        this.panno,
        this.accountNo,
        this.accountName,
        this.ifscCode,
        this.bankName});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ipAddress = json['ip_address'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    mobile = json['mobile'];
    image = json['image'];
    imageSm = json['image_sm'];
    balance = json['balance'];
    activationSelector = json['activation_selector'];
    activationCode = json['activation_code'];
    forgottenPasswordSelector = json['forgotten_password_selector'];
    forgottenPasswordCode = json['forgotten_password_code'];
    forgottenPasswordTime = json['forgotten_password_time'];
    rememberSelector = json['remember_selector'];
    rememberCode = json['remember_code'];
    createdOn = json['created_on'];
    lastLogin = json['last_login'];
    active = json['active'];
    company = json['company'];
    address = json['address'];
    bonus = json['bonus'];
    cashReceived = json['cash_received'];
    dob = json['dob'];
    countryCode = json['country_code'];
    city = json['city'];
    area = json['area'];
    street = json['street'];
    pincode = json['pincode'];
    serviceableZipcodes = json['serviceable_zipcodes'];
    apikey = json['apikey'];
    referralCode = json['referral_code'];
    friendsCode = json['friends_code'];
    fcmId = json['fcm_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    adharno = json['adharno'];
    panno = json['panno'];
    accountNo = json['account_no'];
    accountName = json['account_name'];
    ifscCode = json['ifsc_code'];
    bankName = json['bank_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ip_address'] = this.ipAddress;
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    data['image_sm'] = this.imageSm;
    data['balance'] = this.balance;
    data['activation_selector'] = this.activationSelector;
    data['activation_code'] = this.activationCode;
    data['forgotten_password_selector'] = this.forgottenPasswordSelector;
    data['forgotten_password_code'] = this.forgottenPasswordCode;
    data['forgotten_password_time'] = this.forgottenPasswordTime;
    data['remember_selector'] = this.rememberSelector;
    data['remember_code'] = this.rememberCode;
    data['created_on'] = this.createdOn;
    data['last_login'] = this.lastLogin;
    data['active'] = this.active;
    data['company'] = this.company;
    data['address'] = this.address;
    data['bonus'] = this.bonus;
    data['cash_received'] = this.cashReceived;
    data['dob'] = this.dob;
    data['country_code'] = this.countryCode;
    data['city'] = this.city;
    data['area'] = this.area;
    data['street'] = this.street;
    data['pincode'] = this.pincode;
    data['serviceable_zipcodes'] = this.serviceableZipcodes;
    data['apikey'] = this.apikey;
    data['referral_code'] = this.referralCode;
    data['friends_code'] = this.friendsCode;
    data['fcm_id'] = this.fcmId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['adharno'] = this.adharno;
    data['panno'] = this.panno;
    data['account_no'] = this.accountNo;
    data['account_name'] = this.accountName;
    data['ifsc_code'] = this.ifscCode;
    data['bank_name'] = this.bankName;
    return data;
  }
}
