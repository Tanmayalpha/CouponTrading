import 'dart:convert';

import 'package:coupon_trading/Api/api_services.dart';
import 'package:coupon_trading/Custom%20Widget/gradient_button.dart';
import 'package:flutter/material.dart';

import '../../Color/Color.dart';
import 'package:http/http.dart'as http;

import 'LoginScreen.dart';
import 'VeryfyOTPScreen.dart';

class SendOTPScreen extends StatefulWidget {
  const SendOTPScreen({super.key});

  @override
  State<SendOTPScreen> createState() => _SendOTPScreenState();
}

class _SendOTPScreenState extends State<SendOTPScreen> {

  final numbercontroller = TextEditingController();
  bool isLoading = false ;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration:  BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      colors.primary.withOpacity(0.5),
                      colors.secondary,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.02, 1]),

                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(1),
                  //
                  bottomRight: Radius.circular(1),
                ),
                //   color: (Theme.of(context).colorScheme.apcolor)
              ),
              child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        const Text(
                          'Verify',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: colors.whiteTemp),
                        ),
                        InkWell(
                          onTap: () {

                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 5),
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
                    ),
                  )),
            ),
            const SizedBox(height: 50,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,



                children: [
                  const SizedBox(height: 60,),
                  const Text('Verify Your Mobile Number',

                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: colors.blackTemp)),
                  const Text('Before signup please verify your mobile number',

                      style: TextStyle(
                          fontSize: 14,
                          color: colors.blackTemp)),
                  const SizedBox(height: 40,),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 4,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: colors.whiteTemp),
                      child: Center(
                        child: TextFormField(
                          maxLength: 10,
                          controller: numbercontroller,
                          // obscureText: _isHidden ? true : false,
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Please Enter Mobile Number!";
                            } else {
                              if (v.length < 10) {
                                return "Please Enter vailed Mobile Number!";
                              }
                            }
                          },
                          // maxLength: 10,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterText: "",
                            contentPadding: EdgeInsets.only(
                                left: 15, top: 15),
                            hintText: "Enter Mobile Number",
                            hintStyle:
                            TextStyle(color: colors.secondary),
                            prefixIcon: Icon(
                              Icons.call,
                              color: colors.secondary,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40,),
                  AppButton(width: double.maxFinite,title: isLoading? 'Please wait...': 'Send OTP',onTab: isLoading ? null : (){
                    if(numbercontroller.text.trim().length == 10){
                      sendOtpApi() ;

                    }else {
                      showToast('enter valid number');
                    }

                  },height: 50,)
                ],),
            ),






          ],),
      ),
    );
  }

  Future<void> sendOtpApi() async {
    //  SharedPreferences prefe = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true ;
    });
    var headers = {
      'Cookie': 'ci_session=eb53ae9aeac2ce4fd80c41100b10abd26e4f8422'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiService.sendOtpForSignup));
    request.fields.addAll({
      'mobile': numbercontroller.text,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {


      var result = await response.stream.bytesToString();
      print('___________${result}__________');
      var finalrsult = jsonDecode(result);


      if (finalrsult['error']==true) {

        showToast(finalrsult['message']);

      } else {

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => VerifyOTPScreen(mobileNumber: numbercontroller.text,myOtp: finalrsult['data'].toString(),forSignup: true,)));

      }
    }

    setState(() {
      isLoading = false ;
    });
  }

}