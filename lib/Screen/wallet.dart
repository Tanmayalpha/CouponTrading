import 'package:flutter/material.dart';
import '../Color/Color.dart';

class WalletScr extends StatefulWidget {
  const WalletScr({Key? key}) : super(key: key);

  @override
  State<WalletScr> createState() => _WalletScrState();
}

class _WalletScrState extends State<WalletScr> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [

          Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
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
                    SizedBox(width: MediaQuery.of(context).size.width/3.3,),
                    Text(
                      'Wallet',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: colors.whiteTemp),
                    ),
                  ],
                )),
          ),
          SizedBox(height: 30,),

        ]),
      ),
    );
  }
}
