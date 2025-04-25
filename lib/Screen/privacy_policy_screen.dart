import 'dart:convert';

import 'package:coupon_trading/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../Api/api_services.dart';
import '../Color/Color.dart';


class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {

  String? privacyyy;
  @override
  void initState() {
    privacyapi();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body:
        SingleChildScrollView(
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
                          'Privacy Policy',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: colors.whiteTemp),
                        ),
                        InkWell(
                          onTap: () {
                          },
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


              privacyyy!=null ?

              SingleChildScrollView(
                  child:
                  Html(data: "${privacyyy}"))

                  : Container(child: Center(child: CircularProgressIndicator(color: colors.black54,)),),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> privacyapi() async {

    var headers = {
      'Cookie': 'ci_session=b3011b2dcfdddf06099d16ef986a0245c21c9ed9'
    };
    var request = http.Request('POST', Uri.parse('${ApiService.getSettings}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      //   print('___________${result}__________');
      var finalResult = jsonDecode(result);
      print('___________${finalResult['data']['terms_conditions'][0]}__________');
      privacyyy = finalResult['data']['privacy_policy'][0];

      setState(() {

      });
    }
    else {
      print(response.reasonPhrase);
    }


  }

}
