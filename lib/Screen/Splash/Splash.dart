import 'dart:async';


import 'package:flutter/material.dart';

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


  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(Duration(seconds:2),() async{




         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));

    });
    // Timer(Duration(seconds: 3), () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> IntroSlider()));});
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.primary,
        body: Center(

          child: Container(
              height: MediaQuery.of(context).size.height/3,
              width: MediaQuery.of(context).size.width/2,


              child: Column(
                children: [


                  Text('Welcome',style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold,color: colors.secondary),),
                  Image.asset("assets/images/splashlogo.png",height: 200,),
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
