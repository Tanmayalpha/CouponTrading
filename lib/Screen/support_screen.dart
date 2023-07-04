import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../Api/api_services.dart';
import '../Color/Color.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  String? adminEmail;
  String? mobile;

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
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      colors.primary,
                      colors.secondary,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.02, 1]),

                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(1),
                  //
                  bottomRight: Radius.circular(1),
                ),
                //   color: (Theme.of(context).colorScheme.apcolor)
              ),
              child: Center(
                  child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: colors.whiteTemp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4.5,
                  ),
                  const Text(
                    'Support',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: colors.whiteTemp),
                  ),
                ],
              )),
            ),
            const SizedBox(
              height: 30,
            ),
            adminEmail != null
                ? SingleChildScrollView(
                    child: Column(
                    children: [
                      ListTile(
                        minLeadingWidth: 10,
                          title: const Text(
                            'Email',
                            style: TextStyle(color: colors.whiteTemp),
                          ),
                          leading: const Icon(Icons.email,color: colors.whiteTemp),
                          trailing: Text(adminEmail ?? '',
                              style: const TextStyle(color: colors.whiteTemp)),
                          tileColor: colors.secondary),
                      const SizedBox(
                         height: 10,
                      ),
                      ListTile(
                        minLeadingWidth: 10,
                          leading: const Icon(Icons.call, color: colors.whiteTemp,),
                          title: const Text('Mobile',
                              style: TextStyle(color: colors.whiteTemp)),
                          trailing: Text(mobile ?? '',
                              style: TextStyle(color: colors.whiteTemp)),
                          tileColor: colors.secondary)
                    ],
                  ))
                : const Center(
                    child: CircularProgressIndicator(
                  color: colors.black54,
                )),
          ],
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
      print(
          '___________${finalResult['data']['terms_conditions'][0]}__________');
      mobile = finalResult['data']['system_settings'][0]['support_number'];
      adminEmail = finalResult['data']['system_settings'][0]['support_email'];

      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }
}
