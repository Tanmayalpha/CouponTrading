

import 'package:coupon_trading/Screen/Home%20Screeen/HomeScreen.dart';
import 'package:coupon_trading/Screen/purches_Scr.dart';
import 'package:coupon_trading/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Color/Color.dart';
import '../profile/EditeProfile.dart';





class Bottom_Bar extends StatefulWidget {

  final String ?userId;

  const Bottom_Bar({super.key, this.userId});

  @override
  State<Bottom_Bar> createState() => _Bottom_BarState();
}

class _Bottom_BarState extends State<Bottom_Bar> {
  int currentindex = 0;





  void _onItemTapped(int index) {
    setState(() {
      currentindex = index;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('=======================${widget.userId.toString()}');
  }
  @override

  Widget build(BuildContext context) {
    List pages1 = [
      HomeScreen(userId: widget.userId.toString()),
      const PortfolioScreen(),
      const EditeProfile(),

    ];
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Confirm Exit"),
                content: const Text("Are you sure you want to exit?"),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: colors.secondary),
                    child: const Text("YES", style: TextStyle(color: colors.whiteTemp),),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: colors.secondary),
                    child: const Text("NO",style: TextStyle(color: colors.whiteTemp)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body:
          Center(
            child: pages1.elementAt(currentindex),
          ),


          bottomNavigationBar: Container(
            decoration: context.customGradientBox(),
            child:
            BottomNavigationBar(
            backgroundColor: Colors.transparent,
            //  elevation: 1,
            items:  const <BottomNavigationBarItem>[

              BottomNavigationBarItem(

                label: 'Home',
                icon: Icon(Icons.home),),
              BottomNavigationBarItem(


                  label:'Portfolio',



                  icon: Icon(Icons.monetization_on_sharp)),
              BottomNavigationBarItem(
                  label:' Profile',


                  icon: Icon(Icons.person)),


            ],

            currentIndex:  currentindex,
            selectedItemColor:colors.whiteTemp ,
            unselectedItemColor: colors.whiteTemp.withOpacity(0.5),
            onTap: _onItemTapped,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            unselectedFontSize: 13,
            selectedFontSize: 13,         type: BottomNavigationBarType.fixed,



          ),),







        ),
      ),
    );
  }



}