import 'package:flutter/material.dart';

import '../Color/Color.dart';
import '../Custom Widget/AppBtn.dart';
class TradingScreen extends StatefulWidget {

  final String ?companey;
  final String ?currentPrise;


  TradingScreen({Key? key, this.companey, this.currentPrise}) : super(key: key);

  @override
  State<TradingScreen> createState() => _TradingScreenState();
}

class _TradingScreenState extends State<TradingScreen> {

  var typee;
  TextEditingController quantitycontroller=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.companey.toString());
    print(widget.currentPrise.toString());
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      body: Column(children: [


        Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          decoration:  BoxDecoration(
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
                    widget.companey.toString(),
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: colors.whiteTemp),
                  ),
                ],
              )),
        ),
        SizedBox(height: 30,),

        Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Card(child: Container(height: 70,width: MediaQuery.of(context).size.width/2.5,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(children: [
                Text('Current Prize',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: colors.secondary),),
                SizedBox(height: 5,),
                Text(widget.currentPrise.toString(),style: TextStyle(fontSize: 13,color: colors.blackTemp),),

              ]),
            ),
            ),),


            SizedBox(width: 20,),
            Card(child: Container(height: 70,width: MediaQuery.of(context).size.width/2.5,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(children: [
                  Text('Purches Prize',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: colors.secondary),),
                  SizedBox(height: 5,),
                  Text("₹ 23/-",style: TextStyle(fontSize: 13,color: colors.blackTemp),),

                ]),
              ),
            ),),

          ],),
        ),

        SizedBox(height: 20,),


        Center(
          child: Btn(
            title: "Buy",
            height: 50,
            width: 320,

            onPress: () {
              setState(() {
                typee="Buy";
              });

              popshow2(typee);
            },
          ),
        ),
SizedBox(height: 20,),
        Center(
          child: Btn(
            title: "Sell",
            height: 50,
            width: 320,

            onPress: () {

setState(() {
  typee="Sell";
});
popshow2(typee);
            },
          ),
        ),

      ]),


    ));
  }


  popshow2(String typ,) {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Material(
            color: Colors.transparent,
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 1.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 1),
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(9),
                                    topRight: Radius.circular(9),
                                  ),
                                  color: colors.secondary, //BorderRadius.Only
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  )),
                              child:  Center(
                                  child: Text(
                                    '${typ}',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: colors.whiteTemp),
                                  ))),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: Column(children: [

                              const SizedBox(height: 10,),

                              const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text("Select Quantity", style: TextStyle(
                                    color: colors.black54, fontWeight: FontWeight.bold),),
                              ),
                              const SizedBox(height: 2,),
                              Card(
                                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                elevation: 4,
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color:colors.whiteTemp ),
                                  child: Center(
                                    child: TextFormField(

                                      maxLength: 4,
                                      controller: quantitycontroller,
                                      // obscureText: _isHidden ? true : false,
                                      keyboardType: TextInputType.number,
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return "Please Enter Mobile Number!";
                                        }


                                      },
                                      // maxLength: 10,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        counterText: "",
                                        contentPadding: const EdgeInsets.only(
                                            left: 15, top: 15),
                                        hintText: "Quantity",hintStyle: TextStyle(color: colors.secondary),
                                        prefixIcon: const Icon(
                                          Icons.countertops,
                                          color: colors.secondary,
                                          size: 24,

                                        ),

                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10,),


                              Btn(

                                width: 200,
                                height: 30,
                                title: "Submit",
                              )
                            ]),
                          )
                        ]),
                      ),
                    ),

                    // Text(nam.toString())
                  ],
                ),
              ),
            ),
          );
        });
  }

}


