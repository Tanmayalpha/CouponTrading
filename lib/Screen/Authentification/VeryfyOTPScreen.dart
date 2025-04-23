import 'dart:convert';

import 'package:coupon_trading/Api/api_services.dart';
import 'package:coupon_trading/Custom%20Widget/gradient_button.dart';
import 'package:coupon_trading/Screen/Authentification/ResetPasswordScreen.dart';
import 'package:coupon_trading/Screen/Authentification/Signupscreen.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../Color/Color.dart';
import 'package:http/http.dart'as http;

import 'LoginScreen.dart';

class VerifyOTPScreen extends StatefulWidget {
   VerifyOTPScreen({super.key,this.mobileNumber,this.myOtp,this.forSignup});
 final String? mobileNumber ;
  String? myOtp ;
  bool? forSignup ;

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {

  final numbercontroller = TextEditingController();
  bool isLoading = false ;
  String? otp;

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
                          'Verify OTP',
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
            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  monoVarifyText(),
                  otpText(),
                  mobText(),

                  OTPText(),
                  const SizedBox(height: 10,),
                  otpLayout(),
                  const SizedBox(height: 10,),
                  resendText(),
                  const SizedBox(height: 40,),
                  AppButton(width: double.maxFinite,title: 'Verify OTP',onTab: isLoading ? null : (){

                    if(widget.forSignup == true) {
                      if(widget.myOtp == otp){
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => SignupScreen(mobile: widget.mobileNumber,)));
                      } else {
                        showToast('enter valid otp');
                      }

                    }else {
                      if(widget.myOtp == otp){
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => ResetPasswordScreen(mobile: widget.mobileNumber,)));
                      } else {
                        showToast('enter valid otp');
                      }
                    }



                  },height: 50,)
                ],),
            ),






          ],),
      ),
    );
  }

  Widget otpLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Center(
        child: SizedBox(
          height: 70.0,
          child: PinFieldAutoFill(
            decoration: BoxLooseDecoration(
              gapSpace: 10.0,
              strokeWidth: 2.0,
              strokeColorBuilder: const FixedColorBuilder(colors.primary),
              radius: const Radius.circular(10),
              bgColorBuilder: const FixedColorBuilder(Colors.white),
              textStyle: const TextStyle(
                fontSize: 24,
                color: colors.blackTemp,
              ),
            ),
            currentCode: otp,
            codeLength: 4,
            onCodeChanged: (String? code) {
              otp = code;
            },
            onCodeSubmitted: (String code) {
              otp = code;
            },
          ),
        ),
      ),
    );
  }

  Widget monoVarifyText() {
    return Padding(
        padding: EdgeInsetsDirectional.only(
          top: 20.0,
        ),
        child: Center(
          child: Text('Enter verification code',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
        ));
  }

  Widget otpText() {
    return Padding(
        padding: EdgeInsetsDirectional.only(top: 30.0, start: 20.0, end: 20.0),
        child: Center(
          child: Text('We have sent a verification code to',
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: Theme.of(context).colorScheme.fontColor,
                  fontWeight: FontWeight.normal)),
        ));
  }
  Widget mobText() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          bottom: 10.0, start: 20.0, end: 20.0, top: 10.0),
      child: Center(
        child: Text("+91-${widget.mobileNumber}",
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: Theme.of(context).colorScheme.fontColor,
                fontWeight: FontWeight.normal)),
      ),
    );
  }
Widget OTPText()  {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          bottom: 10.0, start: 20.0, end: 20.0, top: 10.0),
      child: Center(
        child: Text("OTP: ${widget.myOtp}",
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: Theme.of(context).colorScheme.fontColor,
                fontWeight: FontWeight.normal)),
      ),
    );
  }
  Widget resendText() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          bottom: 30.0, start: 25.0, end: 25.0, top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Didn't get the code?",
            style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).colorScheme.fontColor,
                fontWeight: FontWeight.normal),
          ),
          InkWell(
            onTap: () async {
              if(widget.forSignup == true){
                reSendOtpSignupApi();
              }else{
                reSendOtpApi();
              }


            },
            child: Text(
              'Resend OTP',
              style: Theme.of(context).textTheme.caption!.copyWith(
                  color: Theme.of(context).colorScheme.fontColor,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }




  Future<void> reSendOtpApi() async {
    var headers = {
      'Cookie': 'ci_session=eb53ae9aeac2ce4fd80c41100b10abd26e4f8422'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiService.sendOtp));
    request.fields.addAll({
      'mobile': widget.mobileNumber ?? '',
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {


      var result = await response.stream.bytesToString();
      print('___________${result}__________');
      var finalrsult = jsonDecode(result);


      if (finalrsult['error']==true) {

        showToast(finalrsult['message']);

      }

      else {
        widget.myOtp = finalrsult['data'].toString() ;
      }
    }

    setState(() {
      isLoading = false ;
    });
  }

  Future<void> reSendOtpSignupApi() async {
    //  SharedPreferences prefe = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true ;
    });
    var headers = {
      'Cookie': 'ci_session=eb53ae9aeac2ce4fd80c41100b10abd26e4f8422'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiService.sendOtpForSignup));
    request.fields.addAll({
      'mobile': widget.mobileNumber ?? '',
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

        widget.myOtp = finalrsult['data'].toString() ;

      }
    }

    setState(() {
      isLoading = false ;
    });
  }


}