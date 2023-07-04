class PurchaseCouponsResponse {
  bool? error;
  String? message;
  List<PurchaseCouponData>? data;

  PurchaseCouponsResponse({this.error, this.message, this.data});

  PurchaseCouponsResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PurchaseCouponData>[];
      json['data'].forEach((v) {
        data!.add(new PurchaseCouponData.fromJson(v));
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

class PurchaseCouponData {
  String? id;
  String? coupanId;
  String? userId;
  String? quantity;
  String? amount;
  String? totalAmount;
  String? createdAt;
  String? updatedAt;
  bool? isProfit;
  String? profitLossAmount;
  String? currentValue;
  String? purchaseAmount;
  String? currentAmount;

  PurchaseCouponData(
      {this.id,
        this.coupanId,
        this.userId,
        this.quantity,
        this.amount,
        this.totalAmount,
        this.createdAt,
        this.updatedAt,
        this.isProfit,
        this.profitLossAmount,
        this.currentValue,
        this.purchaseAmount,
        this.currentAmount});

  PurchaseCouponData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    coupanId = json['coupan_id'];
    userId = json['user_id'];
    quantity = json['quantity'];
    amount = json['amount'];
    totalAmount = json['total_amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isProfit = json['is_profit'];
    profitLossAmount = json['profit_loss_amount'];
    currentValue = json['current_value'];
    purchaseAmount = json['purchase_amount'];
    currentAmount = json['current_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['coupan_id'] = this.coupanId;
    data['user_id'] = this.userId;
    data['quantity'] = this.quantity;
    data['amount'] = this.amount;
    data['total_amount'] = this.totalAmount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_profit'] = this.isProfit;
    data['profit_loss_amount'] = this.profitLossAmount;
    data['current_value'] = this.currentValue;
    data['purchase_amount'] = this.purchaseAmount;
    data['current_amount'] = this.currentAmount;
    return data;
  }
}
