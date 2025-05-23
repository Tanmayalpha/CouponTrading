import 'dart:io';

import 'package:coupon_trading/Screen/charts/candlestick_chart.dart';
import 'package:coupon_trading/Screen/charts/k_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Screen/Splash/Splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KLIN TRADE',
      theme: ThemeData(

      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        //Splash(),
        // '/home': (context) => Dashboard(),
      },
    );
  }
}



class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
