/// currently_l_p : "You have profit of 174"
/// error : false
/// message : "profit loss"
/// data : [{"id":"8","coupan_id":"10","user_id":"29","quantity":"2","amount":"576.00","total_amount":"1152.00","created_at":"2023-07-02 16:35:48","updated_at":"2023-07-02 16:35:48","profit":"234","is_profit":true,"current_value":"693.00","purchase_amount":"1152","current_amount":"1386"},{"id":"9","coupan_id":"13","user_id":"29","quantity":"10","amount":"296.00","total_amount":"2960.00","created_at":"2023-07-02 16:43:58","updated_at":"2023-07-02 16:43:58","loss":"60","is_profit":false,"current_value":"290.00","purchase_amount":"2960","current_amount":"2900"}]

class AverageProfitLossModel {
  AverageProfitLossModel({
    String? currentlyLP,
    bool? error,
    String? message,
    bool? isProfit,
    List<ProfitLossData>? data,}){
    _currentlyLP = currentlyLP;
    _error = error;
    _message = message;
    _data = data;
    _isProfit= isProfit;
  }

  AverageProfitLossModel.fromJson(dynamic json) {
    _currentlyLP = json['currently_l_p'];
    _error = json['error'];
    _isProfit = json['is_profit'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ProfitLossData.fromJson(v));
      });
    }
  }
  String? _currentlyLP;
  bool? _error;
  bool? _isProfit;
  String? _message;
  List<ProfitLossData>? _data;
  AverageProfitLossModel copyWith({  String? currentlyLP,
    bool? error,
    String? message,
    bool? isProfit,
    List<ProfitLossData>? data,
  }) => AverageProfitLossModel(  currentlyLP: currentlyLP ?? _currentlyLP,
      error: error ?? _error,
      message: message ?? _message,
      data: data ?? _data,
      isProfit: isProfit ?? _isProfit

  );
  String? get currentlyLP => _currentlyLP;
  bool? get error => _error;
  bool? get isProfit => _isProfit;
  String? get message => _message;
  List<ProfitLossData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currently_l_p'] = _currentlyLP;
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "8"
/// coupan_id : "10"
/// user_id : "29"
/// quantity : "2"
/// amount : "576.00"
/// total_amount : "1152.00"
/// created_at : "2023-07-02 16:35:48"
/// updated_at : "2023-07-02 16:35:48"
/// profit : "234"
/// is_profit : true
/// current_value : "693.00"
/// purchase_amount : "1152"
/// current_amount : "1386"

class ProfitLossData {
  ProfitLossData({
    String? id,
    String? coupanId,
    String? userId,
    String? quantity,
    String? amount,
    String? totalAmount,
    String? createdAt,
    String? updatedAt,
    String? profit,
    bool? isProfit,
    String? currentValue,
    String? purchaseAmount,
    String? currentAmount,}){
    _id = id;
    _coupanId = coupanId;
    _userId = userId;
    _quantity = quantity;
    _amount = amount;
    _totalAmount = totalAmount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _profit = profit;
    _isProfit = isProfit;
    _currentValue = currentValue;
    _purchaseAmount = purchaseAmount;
    _currentAmount = currentAmount;
  }

  ProfitLossData.fromJson(dynamic json) {
    _id = json['id'];
    _coupanId = json['coupan_id'];
    _userId = json['user_id'];
    _quantity = json['quantity'];
    _amount = json['amount'];
    _totalAmount = json['total_amount'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _profit = json['profit'];
    _isProfit = json['is_profit'];
    _currentValue = json['current_value'];
    _purchaseAmount = json['purchase_amount'];
    _currentAmount = json['current_amount'];
  }
  String? _id;
  String? _coupanId;
  String? _userId;
  String? _quantity;
  String? _amount;
  String? _totalAmount;
  String? _createdAt;
  String? _updatedAt;
  String? _profit;
  bool? _isProfit;
  String? _currentValue;
  String? _purchaseAmount;
  String? _currentAmount;
  ProfitLossData copyWith({  String? id,
    String? coupanId,
    String? userId,
    String? quantity,
    String? amount,
    String? totalAmount,
    String? createdAt,
    String? updatedAt,
    String? profit,
    bool? isProfit,
    String? currentValue,
    String? purchaseAmount,
    String? currentAmount,
  }) => ProfitLossData(  id: id ?? _id,
    coupanId: coupanId ?? _coupanId,
    userId: userId ?? _userId,
    quantity: quantity ?? _quantity,
    amount: amount ?? _amount,
    totalAmount: totalAmount ?? _totalAmount,
    createdAt: createdAt ?? _createdAt,
    updatedAt: updatedAt ?? _updatedAt,
    profit: profit ?? _profit,
    isProfit: isProfit ?? _isProfit,
    currentValue: currentValue ?? _currentValue,
    purchaseAmount: purchaseAmount ?? _purchaseAmount,
    currentAmount: currentAmount ?? _currentAmount,
  );
  String? get id => _id;
  String? get coupanId => _coupanId;
  String? get userId => _userId;
  String? get quantity => _quantity;
  String? get amount => _amount;
  String? get totalAmount => _totalAmount;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get profit => _profit;
  bool? get isProfit => _isProfit;
  String? get currentValue => _currentValue;
  String? get purchaseAmount => _purchaseAmount;
  String? get currentAmount => _currentAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['coupan_id'] = _coupanId;
    map['user_id'] = _userId;
    map['quantity'] = _quantity;
    map['amount'] = _amount;
    map['total_amount'] = _totalAmount;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['profit'] = _profit;
    map['is_profit'] = _isProfit;
    map['current_value'] = _currentValue;
    map['purchase_amount'] = _purchaseAmount;
    map['current_amount'] = _currentAmount;
    return map;
  }

}