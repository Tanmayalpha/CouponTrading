class WithdrawalRequestResponse {
  bool? error;
  List<WithdrawalRequestData>? data;
  String? message;

  WithdrawalRequestResponse({this.error, this.data, this.message});

  WithdrawalRequestResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = <WithdrawalRequestData>[];
      json['data'].forEach((v) {
        data!.add(new WithdrawalRequestData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class WithdrawalRequestData {
  String? id;
  String? userId;
  String? paymentType;
  String? paymentAddress;
  String? amountRequested;
  String? remarks;
  String? status;
  String? dateCreated;

  WithdrawalRequestData(
      {this.id,
        this.userId,
        this.paymentType,
        this.paymentAddress,
        this.amountRequested,
        this.remarks,
        this.status,
        this.dateCreated});

  WithdrawalRequestData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    paymentType = json['payment_type'];
    paymentAddress = json['payment_address'];
    amountRequested = json['amount_requested'];
    remarks = json['remarks'];
    status = json['status'];
    dateCreated = json['date_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['payment_type'] = this.paymentType;
    data['payment_address'] = this.paymentAddress;
    data['amount_requested'] = this.amountRequested;
    data['remarks'] = this.remarks;
    data['status'] = this.status;
    data['date_created'] = this.dateCreated;
    return data;
  }
}
