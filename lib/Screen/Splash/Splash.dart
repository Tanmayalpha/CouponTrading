import 'dart:async';


import 'package:coupon_trading/Screen/Home%20Screeen/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Color/Color.dart';
import '../Authentification/LoginScreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  String? uid;
  String? type;
  bool? isSeen;

  void checkLogin()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    uid = pref.getString('userId');
  }
  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(Duration(milliseconds:300),() {

      checkLogin();

    });

    Timer(Duration(seconds: 2), () {
      if(uid == null || uid == "") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Bottom_Bar()));
      }

      });
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.whiteTemp,
        body: Center(

          child: Container(
              height: MediaQuery.of(context).size.height/3,
              width: MediaQuery.of(context).size.width/2,


              child: Column(
                children: [


                  //Text('Welcome',style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold,color: colors.primary),),
                  Image.asset("assets/images/klinTradeLogo.png",height: 200,),
                ],
              ))
          // Container(
          //     decoration: BoxDecoration(
          //         image:DecorationImage(
          //             image:AssetImage('assets/splash/splashimages.png',),
          //         )
          //     )
          // ),
        ),
      ),
    );
  }
}
