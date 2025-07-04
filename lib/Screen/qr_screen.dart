import 'dart:convert';

import 'package:coupon_trading/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../Api/api_services.dart';
import '../Color/Color.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  String? qrCode;
  List<String> qrCodeList = [];

  @override
  void initState() {
    Qrapi();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: context.customGradientBox(),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: colors.whiteTemp,
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'QR Code',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: colors.whiteTemp),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ),
              qrCodeList.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        children: qrCodeList.map((url) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              url,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Column(
                                children: [
                                  Icon(Icons.error, color: Colors.red),
                                  Text("Failed to load image",
                                      style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(color: Colors.black54))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Qrapi() async {
    var headers = {
      'Cookie': 'ci_session=b3011b2dcfdddf06099d16ef986a0245c21c9ed9'
    };
    var request = http.Request('POST', Uri.parse('${ApiService.getSettings}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);

      setState(() {
        qrCodeList = List<String>.from(finalResult['data']['qr_code'] ?? []);
      });
    } else {
      print(response.reasonPhrase);
    }
  }
}
