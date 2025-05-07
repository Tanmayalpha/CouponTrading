import 'dart:convert';

import 'package:coupon_trading/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

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
    supportApi();
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
                        'Support',
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
            const SizedBox(height: 10,),
            adminEmail != null
                ? SingleChildScrollView(
                    child: Column(
                    children: [
                      ListTile(
                        minLeadingWidth: 10,
                          onTap: () {
                            launchEmail(recipient: adminEmail ?? '');
                          },
                          title: const Text(
                            'Email',
                            style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold),
                          ),
                          leading: const Icon(Icons.email,color: colors.whiteTemp,),
                          trailing: Text(adminEmail ?? '',
                              style: const TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold)),
                          tileColor: colors.secondary.withOpacity(0.9)),
                      const SizedBox(
                         height: 10,
                      ),
                      ListTile(
                        minLeadingWidth: 10,
                        onTap: () {
                          makePhoneCall(phone: mobile ?? '');
                        },
                          leading: const Icon(Icons.call, color: colors.whiteTemp,),
                          title: const Text('Mobile',
                              style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold)),
                          trailing: Text(mobile ?? '',
                              style: const TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold)),
                          tileColor: colors.secondary.withOpacity(0.9)),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                          minLeadingWidth: 10,
                          onTap: () {
                            launchWhatsApp(phone: mobile ?? '', message: 'Hello, I need support. Could you please assist me?.');
                          },
                          leading: Image.asset('assets/images/WhatsApp_icon.png',height: 35,width: 35,),
                          title: const Text('WhatsApp',
                              style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold)),
                          trailing: Text(mobile ?? '',
                              style: const TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold)),
                          tileColor: colors.secondary.withOpacity(0.9)),
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

  Future<void> supportApi() async {
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


  void launchWhatsApp({required String phone, required String message}) async {
    //var iosUrl = "https://wa.me/$phone?text=${Uri.parse('Hi, I need some help')}";
    final Uri whatsappUrl = Uri.parse('whatsapp://send?phone=$phone&text=$message');

    if (await canLaunchUrlString(whatsappUrl.toString())) {
      await launchUrlString(whatsappUrl.toString());
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }


  void launchEmail({required String recipient, String? subject, String? body}) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: recipient,
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      },
    );
    if (await canLaunchUrlString(emailUri.toString())) {
      await launchUrlString(emailUri.toString());
    } else {
      throw 'Could not launch $emailUri';
    }
  }


  void makePhoneCall({required String phone}) async {
    final Uri callUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrlString(callUri.toString())) {
      await launchUrlString(callUri.toString());
    } else {
      throw 'Could not launch $callUri';
    }
  }

}
