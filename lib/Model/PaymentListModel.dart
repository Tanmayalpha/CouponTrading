class PaymentListModel {
  bool? error;
  String? message;
  int? total;
  List<Data>? data;

  PaymentListModel({this.error, this.message, this.total, this.data});

  PaymentListModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    total = json['total'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? userId;
  String? amount;
  String? screenshot;
  String? transactionId;
  String? remarks;
  String? status;
  String? createdAt;
  String? username;

  Data(
      {this.id,
      this.userId,
      this.amount,
      this.screenshot,
      this.transactionId,
      this.remarks,
      this.status,
      this.createdAt,
      this.username});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amount = json['amount'];
    screenshot = json['screenshot'];
    transactionId = json['transaction_id'];
    remarks = json['remarks'];
    status = json['status'];
    createdAt = json['created_at'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['screenshot'] = this.screenshot;
    data['transaction_id'] = this.transactionId;
    data['remarks'] = this.remarks;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['username'] = this.username;
    return data;
  }
}
