

import 'dart:convert';
import 'package:coupon_trading/Screen/Authentification/SendOTPScreen.dart';
import 'package:coupon_trading/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;






import '../../Api/api_services.dart';
import '../../Color/Color.dart';
import '../../Custom Widget/AppBtn.dart';
import '../../Model/signInmodel.dart';
import '../Home Screeen/bottombar.dart';
import 'ForgetPasswordScreen.dart';
import 'Signupscreen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key,this.id}) : super(key: key);
  final id;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _value = 1;
  bool isMobile = false;
  bool isSendOtp = false;
  bool isLoading = false;
  bool isloader = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  int selectedIndex = 1;
  bool _isObscure = true;


  emailPasswordLogin() async {
    String? token;


    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=ecadd729e7ab27560c282ba3660d365c7e306ca0'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiService.login));
    request.fields.addAll({
      'email': emailController.text,
      'password': passwordController.text,
      'fcm_id': '$token'
    });
    print("Checking all fields here ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      //  final jsonResponse = LogInResponse.fromJson(json.decode(finalResponse));
      setState(() {
        /// logInResponse = jsonResponse;
      });


    }
  }

  bool isLoading1 = false;

  @override


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.primary,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.75),
                child: Container(
                    height: MediaQuery.of(context).size.height / 5,
                    child: Image.asset(
                      "assets/images/splashlogo.png",
                      scale: 6.2,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Container(
                     width: double.maxFinite,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      color: colors.whiteTemp,
                      // borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
                    ),

                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 1.33,
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        const Text("Login", style: TextStyle(color: colors.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 35),),
                        SizedBox(height: 15,),

                            Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 10, left: 20, right: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
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
                                        controller: mobileController,
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
                                const SizedBox(
                                  height: 15,
                                ),
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
                                        obscureText: _isObscure,
                                        controller: passwordController,
                                        // obscureText: _isHidden ? true : false,
                                        keyboardType: TextInputType.text,
                                        validator: (msg) {
                                          if (msg!.isEmpty) {
                                            return "Please Enter Valid Password!";
                                          }
                                        },
                                        // maxLength: 10,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            counterText: "",
                                            contentPadding: const EdgeInsets.only(
                                                left: 15, top: 15),
                                            hintText: "Password",
                                            hintStyle: TextStyle(
                                                color: colors.secondary),
                                            prefixIcon: const Icon(
                                              Icons.lock,
                                              color: colors.secondary,
                                              size: 24,

                                            ),
                                            suffixIcon: IconButton(
                                                icon: Icon(
                                                  _isObscure
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: colors.secondary,),
                                                onPressed: () {
                                                  setState(() {
                                                    _isObscure = !_isObscure;
                                                  });
                                                })
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ForgetPasswordScreen()));
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Forgot Password?",
                                          style: TextStyle(
                                              color: colors.secondary,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Btn(
                                  height: 50,
                                  width: 320,
                                  title: isLoading1 == true
                                      ? "Please wait......"
                                      : 'Sign In',
                                  onPress: () {
                                    setState(() {
                                      isLoading1 = true;
                                    });
                                    if (_formKey.currentState!.validate()) {
                                      signinapi();


                                    } else {
                                      setState(() {
                                        isLoading1 = false;
                                      });
                                      Fluttertoast.showToast(
                                          msg:
                                          "Please Enter Correct Credentials!!");
                                    }
                                  },
                                ),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Dont have an account?",
                                      style: TextStyle(color: colors.secondary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),),
                                    TextButton(onPressed: () {
                                      /*Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));*/
                                    }, child: InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                builder: (context) => const SendOTPScreen(),));

                                        },
                                        child: const Text("SignUp", style: TextStyle(
                                            color: colors.secondary,
                                            fontSize: 16,
                                            decoration: TextDecoration.underline,
                                            fontWeight: FontWeight.bold),)))
                                  ],
                                )

                              ],
                            ),
                          ),
                        )

                      ],
                    )


                ),
              )

              // Container(
              //   color: colors.primary,
              //   child:
              // )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signinapi() async {
    SharedPreferences prefe = await SharedPreferences.getInstance();

    var headers = {
      'Cookie': 'ci_session=eb53ae9aeac2ce4fd80c41100b10abd26e4f8422'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiService.login));
    request.fields.addAll({
      'mobile': mobileController.text,
      'password': passwordController.text
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
        showToast(finalrsult['message']);
        var jsonResult = SignInmodel.fromJson(jsonDecode(result)) ;
        var userid= jsonResult.data?[0].id.toString();
        var email= jsonResult.data?[0].email.toString();
        var name= jsonResult.data?[0].username.toString();
        var image= jsonResult.data?[0].image.toString();
        var mob= jsonResult.data?[0].mobile.toString();
        prefe.setString(Constant.USERID, userid ?? '');
        prefe.setString(Constant.EMAIL, email ?? '');
        prefe.setString(Constant.NAME, name ?? '');
        prefe.setString(Constant.PROFILE, image ?? '');
        prefe.setString(Constant.PHONE, mob ?? '');

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Bottom_Bar(userId: userid.toString())));

      }
    }
  }






}

void showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      // gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black);
}