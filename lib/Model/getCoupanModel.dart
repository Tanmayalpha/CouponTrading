/// error : false
/// message : "Coupans retrived Successfully !"
/// data : [{"id":"1","name":"Trading Coupan","stock":"750","price":"50.00","description":"This is a trading coupan","status":"1","created_at":"2023-06-27 11:16:41","updated_at":"2023-06-28 12:42:02"},{"id":"3","name":"New Trading Coupan","stock":"5000","price":"145.00","description":"New Trading Coupan","status":"1","created_at":"2023-06-27 13:33:00","updated_at":"2023-06-27 15:15:51"},{"id":"4","name":"rohit","stock":"10","price":"185.00","description":"test","status":"1","created_at":"2023-06-27 16:54:06","updated_at":"2023-06-27 17:44:26"}]

class GetCoupanModel {
  GetCoupanModel({
    bool? error,
    String? message,
    List<GetCooupann>? data,}){
    _error = error;
    _message = message;
    _data = data;
  }

  GetCoupanModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetCooupann.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<GetCooupann>? _data;
  GetCoupanModel copyWith({  bool? error,
    String? message,
    List<GetCooupann>? data,
  }) => GetCoupanModel(  error: error ?? _error,
    message: message ?? _message,
    data: data ?? _data,
  );
  bool? get error => _error;
  String? get message => _message;
  List<GetCooupann>? get data => _data;

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

/// id : "1"
/// name : "Trading Coupan"
/// stock : "750"
/// price : "50.00"
/// description : "This is a trading coupan"
/// status : "1"
/// created_at : "2023-06-27 11:16:41"
/// updated_at : "2023-06-28 12:42:02"

class GetCooupann {
  GetCooupann({
    String? id,
    String? name,
    String? stock,
    String? price,
    String? description,
    String? status,
    String? logo,
    String? createdAt,
    String? updatedAt,}){
    _id = id;
    _name = name;
    _stock = stock;
    _price = price;
    _description = description;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  GetCooupann.fromJson(dynamic json) {
    _id = json['id'];
    _logo = json['logo'];

    _name = json['name'];
    _stock = json['stock'];
    _price = json['price'];
    _description = json['description'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _name;
  String? _stock;
  String? _price;
  String? _description;
  String? _status;
  String? _logo;
  String? _createdAt;
  String? _updatedAt;

  GetCooupann copyWith({  String? id,
    String? name,
    String? stock,
    String? price,
    String? description,
    String? status,
    String? logo,
    String? createdAt,
    String? updatedAt,
  }) => GetCooupann(  id: id ?? _id,
      name: name ?? _name,
      stock: stock ?? _stock,
      price: price ?? _price,
      description: description ?? _description,
      status: status ?? _status,
      createdAt: createdAt ?? _createdAt,
      updatedAt: updatedAt ?? _updatedAt,
      logo: logo ?? _logo
  );
  String? get id => _id;
  String? get name => _name;
  String? get stock => _stock;
  String? get price => _price;
  String? get description => _description;
  String? get status => _status;
  String? get logo => _logo;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['stock'] = _stock;
    map['price'] = _price;
    map['description'] = _description;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}