import 'dart:convert';
import 'dart:developer';

import 'package:coupon_trading/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../Api/api_services.dart';
import '../Color/Color.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  var aboutuss;
  @override
  void initState() {
    aboutUsApi();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body:Column(
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
                        'About Us',
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

            aboutuss!=null ? SingleChildScrollView(
              child: Html(data: "${aboutuss}"),
            )
                : Container(child: Center(child: CircularProgressIndicator(color: colors.black54,)),),
          ],
        ),
      ),
    );
  }

  Future<void> aboutUsApi() async {

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
      aboutuss = finalResult['data']['about_us'][0];

      setState(() {

      });
    }
    else {
      print(response.reasonPhrase);
    }


  }
}


