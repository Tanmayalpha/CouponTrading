// To parse this JSON data, do
//
//     final getDeliveryChargeResponse = getDeliveryChargeResponseFromJson(jsonString);

import 'dart:convert';

GetDeliveryChargeResponse getDeliveryChargeResponseFromJson(String str) => GetDeliveryChargeResponse.fromJson(json.decode(str));

String getDeliveryChargeResponseToJson(GetDeliveryChargeResponse data) => json.encode(data.toJson());

class GetDeliveryChargeResponse {
  List<CandelData>? data;
  String? coupan;

  GetDeliveryChargeResponse({
    this.data,
    this.coupan,
  });

  factory GetDeliveryChargeResponse.fromJson(Map<String, dynamic> json) => GetDeliveryChargeResponse(
    data: List<CandelData>.from(json["data"].map((x) => CandelData.fromJson(x))),
    coupan: json["coupan"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "coupan": coupan,
  };
}

class CandelData {
  String? low;
  String? high;
  String? open;
  String? close;
  DateTime? createdAt;

  CandelData({
    this.low,
    this.high,
    this.open,
    this.close,
    this.createdAt,
  });

  factory CandelData.fromJson(Map<String, dynamic> json) => CandelData(
    low: json["low"],
    high: json["high"],
    open: json["open"],
    close: json["close"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "low": low,
    "high": high,
    "open": open,
    "close": close,
    "created_at": createdAt!.toIso8601String(),
  };
}
