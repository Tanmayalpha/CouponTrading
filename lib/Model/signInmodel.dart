/// error : false
/// message : "Logged In Successfully"
/// data : [{"id":"27","ip_address":"122.168.2.89","username":"raj","email":"gt@gmail.com","mobile":"8899999999","image":"https://developmentalphawizz.com/coupan-trading/assets/no-image.png","balance":"0","activation_selector":"621edb1bc65fe25bf460","activation_code":"$2y$10$k/kRCZ1uyKWcBVTxiBzmt.JZ6UvVacbJRJqZEfLRzZver4vMtWi6u","forgotten_password_selector":"","forgotten_password_code":"","forgotten_password_time":"","remember_selector":"","remember_code":"","created_on":"1687936630","last_login":"1687944911","active":"1","company":"","address":"","bonus":"","cash_received":"0.00","dob":"","country_code":"91","city":"","area":"","street":"","pincode":"","apikey":"","referral_code":"","friends_code":"","fcm_id":"","latitude":"","longitude":"","created_at":"2023-06-28 12:47:10"}]

class SignInmodel {
  SignInmodel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  SignInmodel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
SignInmodel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => SignInmodel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "27"
/// ip_address : "122.168.2.89"
/// username : "raj"
/// email : "gt@gmail.com"
/// mobile : "8899999999"
/// image : "https://developmentalphawizz.com/coupan-trading/assets/no-image.png"
/// balance : "0"
/// activation_selector : "621edb1bc65fe25bf460"
/// activation_code : "$2y$10$k/kRCZ1uyKWcBVTxiBzmt.JZ6UvVacbJRJqZEfLRzZver4vMtWi6u"
/// forgotten_password_selector : ""
/// forgotten_password_code : ""
/// forgotten_password_time : ""
/// remember_selector : ""
/// remember_code : ""
/// created_on : "1687936630"
/// last_login : "1687944911"
/// active : "1"
/// company : ""
/// address : ""
/// bonus : ""
/// cash_received : "0.00"
/// dob : ""
/// country_code : "91"
/// city : ""
/// area : ""
/// street : ""
/// pincode : ""
/// apikey : ""
/// referral_code : ""
/// friends_code : ""
/// fcm_id : ""
/// latitude : ""
/// longitude : ""
/// created_at : "2023-06-28 12:47:10"

class Data {
  Data({
      String? id, 
      String? ipAddress, 
      String? username, 
      String? email, 
      String? mobile, 
      String? image, 
      String? balance, 
      String? activationSelector, 
      String? activationCode, 
      String? forgottenPasswordSelector, 
      String? forgottenPasswordCode, 
      String? forgottenPasswordTime, 
      String? rememberSelector, 
      String? rememberCode, 
      String? createdOn, 
      String? lastLogin, 
      String? active, 
      String? company, 
      String? address, 
      String? bonus, 
      String? cashReceived, 
      String? dob, 
      String? countryCode, 
      String? city, 
      String? area, 
      String? street, 
      String? pincode, 
      String? apikey, 
      String? referralCode, 
      String? friendsCode, 
      String? fcmId, 
      String? latitude, 
      String? longitude, 
      String? createdAt,}){
    _id = id;
    _ipAddress = ipAddress;
    _username = username;
    _email = email;
    _mobile = mobile;
    _image = image;
    _balance = balance;
    _activationSelector = activationSelector;
    _activationCode = activationCode;
    _forgottenPasswordSelector = forgottenPasswordSelector;
    _forgottenPasswordCode = forgottenPasswordCode;
    _forgottenPasswordTime = forgottenPasswordTime;
    _rememberSelector = rememberSelector;
    _rememberCode = rememberCode;
    _createdOn = createdOn;
    _lastLogin = lastLogin;
    _active = active;
    _company = company;
    _address = address;
    _bonus = bonus;
    _cashReceived = cashReceived;
    _dob = dob;
    _countryCode = countryCode;
    _city = city;
    _area = area;
    _street = street;
    _pincode = pincode;
    _apikey = apikey;
    _referralCode = referralCode;
    _friendsCode = friendsCode;
    _fcmId = fcmId;
    _latitude = latitude;
    _longitude = longitude;
    _createdAt = createdAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _ipAddress = json['ip_address'];
    _username = json['username'];
    _email = json['email'];
    _mobile = json['mobile'];
    _image = json['image'];
    _balance = json['balance'];
    _activationSelector = json['activation_selector'];
    _activationCode = json['activation_code'];
    _forgottenPasswordSelector = json['forgotten_password_selector'];
    _forgottenPasswordCode = json['forgotten_password_code'];
    _forgottenPasswordTime = json['forgotten_password_time'];
    _rememberSelector = json['remember_selector'];
    _rememberCode = json['remember_code'];
    _createdOn = json['created_on'];
    _lastLogin = json['last_login'];
    _active = json['active'];
    _company = json['company'];
    _address = json['address'];
    _bonus = json['bonus'];
    _cashReceived = json['cash_received'];
    _dob = json['dob'];
    _countryCode = json['country_code'];
    _city = json['city'];
    _area = json['area'];
    _street = json['street'];
    _pincode = json['pincode'];
    _apikey = json['apikey'];
    _referralCode = json['referral_code'];
    _friendsCode = json['friends_code'];
    _fcmId = json['fcm_id'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _createdAt = json['created_at'];
  }
  String? _id;
  String? _ipAddress;
  String? _username;
  String? _email;
  String? _mobile;
  String? _image;
  String? _balance;
  String? _activationSelector;
  String? _activationCode;
  String? _forgottenPasswordSelector;
  String? _forgottenPasswordCode;
  String? _forgottenPasswordTime;
  String? _rememberSelector;
  String? _rememberCode;
  String? _createdOn;
  String? _lastLogin;
  String? _active;
  String? _company;
  String? _address;
  String? _bonus;
  String? _cashReceived;
  String? _dob;
  String? _countryCode;
  String? _city;
  String? _area;
  String? _street;
  String? _pincode;
  String? _apikey;
  String? _referralCode;
  String? _friendsCode;
  String? _fcmId;
  String? _latitude;
  String? _longitude;
  String? _createdAt;
Data copyWith({  String? id,
  String? ipAddress,
  String? username,
  String? email,
  String? mobile,
  String? image,
  String? balance,
  String? activationSelector,
  String? activationCode,
  String? forgottenPasswordSelector,
  String? forgottenPasswordCode,
  String? forgottenPasswordTime,
  String? rememberSelector,
  String? rememberCode,
  String? createdOn,
  String? lastLogin,
  String? active,
  String? company,
  String? address,
  String? bonus,
  String? cashReceived,
  String? dob,
  String? countryCode,
  String? city,
  String? area,
  String? street,
  String? pincode,
  String? apikey,
  String? referralCode,
  String? friendsCode,
  String? fcmId,
  String? latitude,
  String? longitude,
  String? createdAt,
}) => Data(  id: id ?? _id,
  ipAddress: ipAddress ?? _ipAddress,
  username: username ?? _username,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  image: image ?? _image,
  balance: balance ?? _balance,
  activationSelector: activationSelector ?? _activationSelector,
  activationCode: activationCode ?? _activationCode,
  forgottenPasswordSelector: forgottenPasswordSelector ?? _forgottenPasswordSelector,
  forgottenPasswordCode: forgottenPasswordCode ?? _forgottenPasswordCode,
  forgottenPasswordTime: forgottenPasswordTime ?? _forgottenPasswordTime,
  rememberSelector: rememberSelector ?? _rememberSelector,
  rememberCode: rememberCode ?? _rememberCode,
  createdOn: createdOn ?? _createdOn,
  lastLogin: lastLogin ?? _lastLogin,
  active: active ?? _active,
  company: company ?? _company,
  address: address ?? _address,
  bonus: bonus ?? _bonus,
  cashReceived: cashReceived ?? _cashReceived,
  dob: dob ?? _dob,
  countryCode: countryCode ?? _countryCode,
  city: city ?? _city,
  area: area ?? _area,
  street: street ?? _street,
  pincode: pincode ?? _pincode,
  apikey: apikey ?? _apikey,
  referralCode: referralCode ?? _referralCode,
  friendsCode: friendsCode ?? _friendsCode,
  fcmId: fcmId ?? _fcmId,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  createdAt: createdAt ?? _createdAt,
);
  String? get id => _id;
  String? get ipAddress => _ipAddress;
  String? get username => _username;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get image => _image;
  String? get balance => _balance;
  String? get activationSelector => _activationSelector;
  String? get activationCode => _activationCode;
  String? get forgottenPasswordSelector => _forgottenPasswordSelector;
  String? get forgottenPasswordCode => _forgottenPasswordCode;
  String? get forgottenPasswordTime => _forgottenPasswordTime;
  String? get rememberSelector => _rememberSelector;
  String? get rememberCode => _rememberCode;
  String? get createdOn => _createdOn;
  String? get lastLogin => _lastLogin;
  String? get active => _active;
  String? get company => _company;
  String? get address => _address;
  String? get bonus => _bonus;
  String? get cashReceived => _cashReceived;
  String? get dob => _dob;
  String? get countryCode => _countryCode;
  String? get city => _city;
  String? get area => _area;
  String? get street => _street;
  String? get pincode => _pincode;
  String? get apikey => _apikey;
  String? get referralCode => _referralCode;
  String? get friendsCode => _friendsCode;
  String? get fcmId => _fcmId;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ip_address'] = _ipAddress;
    map['username'] = _username;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['image'] = _image;
    map['balance'] = _balance;
    map['activation_selector'] = _activationSelector;
    map['activation_code'] = _activationCode;
    map['forgotten_password_selector'] = _forgottenPasswordSelector;
    map['forgotten_password_code'] = _forgottenPasswordCode;
    map['forgotten_password_time'] = _forgottenPasswordTime;
    map['remember_selector'] = _rememberSelector;
    map['remember_code'] = _rememberCode;
    map['created_on'] = _createdOn;
    map['last_login'] = _lastLogin;
    map['active'] = _active;
    map['company'] = _company;
    map['address'] = _address;
    map['bonus'] = _bonus;
    map['cash_received'] = _cashReceived;
    map['dob'] = _dob;
    map['country_code'] = _countryCode;
    map['city'] = _city;
    map['area'] = _area;
    map['street'] = _street;
    map['pincode'] = _pincode;
    map['apikey'] = _apikey;
    map['referral_code'] = _referralCode;
    map['friends_code'] = _friendsCode;
    map['fcm_id'] = _fcmId;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['created_at'] = _createdAt;
    return map;
  }

}