import 'package:flutter/material.dart';
import '../Color/Color.dart';

class Purches_Screen extends StatefulWidget {
  const Purches_Screen({Key? key}) : super(key: key);

  @override
  State<Purches_Screen> createState() => _Purches_ScreenState();
}

class _Purches_ScreenState extends State<Purches_Screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [

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
            child: const Center(
                child: Text(
                  'Portfolio',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: colors.whiteTemp),
                ),),
          ),
          const SizedBox(height: 30,),

        ]),
      ),
    );
  }
}
