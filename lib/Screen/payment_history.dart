import 'dart:convert';

import 'package:coupon_trading/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/api_services.dart';
import '../Color/Color.dart';
import '../Model/PaymentListModel.dart';
import 'NoData.dart';

class PayemntHistory extends StatefulWidget {
  const PayemntHistory({Key? key}) : super(key: key);

  @override
  State<PayemntHistory> createState() => _PayemntHistoryState();
}

class _PayemntHistoryState extends State<PayemntHistory> {
  late Future my;

  @override
  void initState() {
    // TODO: implement initState
    my = getPaymentList();
    getUserPref();
    super.initState();
  }

  getUserPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('userId');
    getPaymentList();
  }

  PaymentListModel? paymentListModel;
  String? uid;
  Future<void> getPaymentList() async {
    var headers = {
      'Cookie': 'ci_session=3ce649d7fc8fd1ca0f6d0e68b65f31491df422b0',
    };
    var uri = Uri.parse('https://klintrade.com/app/v1/api/get_deposit_history')
        .replace(queryParameters: {'user_id': uid ?? ''});

    var request = http.Request('GET', uri);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      var json = jsonDecode(jsonString);
      paymentListModel = PaymentListModel.fromJson(json);
      if (paymentListModel != null &&
          paymentListModel!.data != null &&
          paymentListModel!.data!.isNotEmpty) {
        totalAmount = 0;
        for (int i = 0; i < paymentListModel!.data!.length; i++) {
          totalAmount +=
              double.tryParse(paymentListModel!.data![i].amount.toString())
                      ?.toInt() ??
                  0;
        }
      }
      setState(() {});
    } else {
      print('Error: ${response.reasonPhrase}');
    }
  }

  int totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Deposit History",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: colors.primary,
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: my,
          builder: (context, s) {
            return s.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : paymentListModel == null ||
                        paymentListModel!.data?.isEmpty == true
                    ? NoDataFound(slug: 'Payment History')
                    : ListView.builder(
                        itemCount: paymentListModel!.data?.length,
                        itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(1, 1),
                                blurRadius: 5,
                                color: Colors.grey.shade300,
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Transaction ID: ${paymentListModel!.data?[index].transactionId ?? ''}",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.fontColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Amount: ₹${paymentListModel!.data?[index].amount ?? ''}",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.fontColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Remarks: ${paymentListModel!.data?[index].remarks ?? ''}",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .fontColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    height: 40,
                                    width: 120,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            final screenshotUrl =
                                                paymentListModel!
                                                    .data?[index].screenshot
                                                    ?.trim();

                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: (screenshotUrl != null &&
                                                      screenshotUrl.isNotEmpty)
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Image.network(
                                                        screenshotUrl,
                                                        fit: BoxFit.contain,
                                                        errorBuilder: (context,
                                                                error,
                                                                stackTrace) =>
                                                            const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  16.0),
                                                          child: Text(
                                                            "Failed to load image",
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : const Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      child: Text(
                                                        "No screenshot available",
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                            );
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: colors.primary,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        'View Screenshot',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Status: ${paymentListModel!.data?[index].status ?? ''}",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.fontColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Date: ${paymentListModel!.data?[index].createdAt ?? ''}",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.fontColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
          },
        ),
      ),
    );
  }
}
