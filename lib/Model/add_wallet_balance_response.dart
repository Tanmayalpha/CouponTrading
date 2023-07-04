class AddWalletBalance {
  bool? error;
  String? message;
  int? amount;
  String? oldBalance;
  String? newBalance;
  List<dynamic>? data;

  AddWalletBalance(
      {this.error,
        this.message,
        this.amount,
        this.oldBalance,
        this.newBalance,
        this.data});

  AddWalletBalance.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    amount = json['amount'];
    oldBalance = json['old_balance'];
    newBalance = json['new_balance'];
    if (json['data'] != null) {
      data = <dynamic>[];
      json['data'].forEach((v) {
        data!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    data['amount'] = this.amount;
    data['old_balance'] = this.oldBalance;
    data['new_balance'] = this.newBalance;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
