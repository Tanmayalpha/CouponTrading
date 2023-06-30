import 'dart:convert';

import 'package:coupon_trading/Screen/wallet.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../Api/api_services.dart';
import '../Color/Color.dart';
import '../Custom Widget/AppBtn.dart';
import '../Model/getCoupanModel.dart';
class TradingScreen extends StatefulWidget {
  final String ?useridd;
  final String ?coupanid;
  final String ?name;
  final String?amount;





  TradingScreen({Key? key, this.name, this.amount, this.coupanid, this.useridd}) : super(key: key);

  @override
  State<TradingScreen> createState() => _TradingScreenState();
}

class _TradingScreenState extends State<TradingScreen> {

  var typee;
  TextEditingController quantitycontroller=TextEditingController();
  TextEditingController totalamountcontroller=TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


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

                  Text(
                    widget.name.toString(),
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: colors.whiteTemp),
                  ),



                  Padding(
                    padding: EdgeInsets.only(left: 15,top: 20,right: 15),
                    child: InkWell(
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context) => WalletScr(),));

                      },
                      child: Container(

                        child: Column(
                          children: [
                            Icon(Icons.account_balance_wallet_outlined,color: colors.whiteTemp,),
                            Text(
                              'Wallet',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: colors.whiteTemp),
                            ),         ],
                        ),
                      ),
                    ),
                  )



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
                Text(widget.amount.toString(),style: TextStyle(fontSize: 13,color: colors.blackTemp),),

              ]),
            ),
            ),),


            // SizedBox(width: 20,),
            // Card(child: Container(height: 70,width: MediaQuery.of(context).size.width/2.5,
            //   child: Padding(
            //     padding: const EdgeInsets.all(5),
            //     child: Column(children: [
            //       Text('Purches Prize',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: colors.secondary),),
            //       SizedBox(height: 5,),
            //       Text("₹ 23/-",style: TextStyle(fontSize: 13,color: colors.blackTemp),),
            //
            //     ]),
            //   ),
            // ),),

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

Future<void> buyCoupan(typeeee) async {
  var headers = {
    'Cookie': 'ci_session=ef2aff848979b6494f9365917121186a328cb6fa'
  };
  var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/coupan-trading/app/v1/api/coupan_transaction'));
  request.fields.addAll({
    'user_id': widget.coupanid.toString(),
    'quantity': quantitycontroller.text,
    'coupan_id': widget.coupanid.toString(),
    'amount': widget.amount.toString(),
    'purchase_amount': totalamountcontroller.text.toString(),
    'type': typeeee.toString(),
    'transaction_id': 'tranjndnkd'
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var result = await response.stream.bytesToString();
    var finalrsult = jsonDecode(result);

    if(finalrsult['error']==false){


      showToast(finalrsult['message']);

Navigator.pop(context);
totalamountcontroller.clear();
quantitycontroller.clear();

    }else{


      showToast(finalrsult['message']);

    }
  }
  else {
  print(response.reasonPhrase);
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


  final _formKey = GlobalKey<FormState>();
int totalvalue = 0;



  void showPPopup() {
    showModalBottomSheet(

      backgroundColor: Colors.transparent,
      context: context, builder: (context) {
      return Card(
        elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        child: Container(
          height: MediaQuery.of(context).size.height/3,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          
          child: Column(children: [
            SizedBox(height: 8,),
            Container(height: 5,width: 100,decoration: BoxDecoration(color: colors.secondary,borderRadius: BorderRadius.circular(50)),),

            SizedBox(height: 20,),
            
            Text('Select Any One Payment Method',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,),),
            SizedBox(height: 20,),

            Card(
              elevation: 4,
              child: Container(height: 40,width: 150,child: Center(child: Text('Wallet',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:colors.secondary),)),),),

          SizedBox(height: 10,),
            Card(
              elevation: 4,
              child: Container(height: 40,width: 150,child: Center(child: Text('Other',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:colors.secondary),)),),)


          ]),
        ),
      );

    },);

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
                height: MediaQuery.of(context).size.height / 2,
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
                        child: Form(
                          key: _formKey,
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

                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text("Select Quantity", style: TextStyle(
                                          color: colors.black54, fontWeight: FontWeight.bold),),
                                    ),
                                  ],
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
                                            return "Please Enter Quntity";
                                          }


                                        },
                                        onChanged: (value) {

                                            totalvalue = 0;
                                            if(value.isEmpty){
                                              setState(() {
                                                totalvalue=0;

                                              });
                                            }
                                            else{
                                              setState(() {

                                                double raj=double.parse(widget.amount.toString());
                                                int amoun=int.parse(raj.toStringAsFixed(0));

                                                totalvalue = int.parse(value.toString()) * amoun;

                                                totalamountcontroller.text=totalvalue.toString();
                                              });


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

                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text("Total Amount", style: TextStyle(
                                          color: colors.black54, fontWeight: FontWeight.bold),),
                                    ),
                                  ],
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
readOnly: true,
                                        maxLength: 4,
                                        controller: totalamountcontroller,
                                        keyboardType: TextInputType.number,


                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          counterText: "",
                                          contentPadding: const EdgeInsets.only(
                                              left: 15, top: 15),
                                          hintText: "Total Amount",hintStyle: TextStyle(color: colors.secondary),
                                          prefixIcon: const Icon(
                                            Icons.currency_rupee,
                                            color: colors.secondary,
                                            size: 24,

                                          ),

                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30,),

                             Btn(
onPress: () {
  if(_formKey.currentState!.validate())
    {
      Navigator.pop(context);
      showPPopup();

    }
  

},
                                  width: 200,
                                  height: 50,
                                  title: 'Make Payment',
                             ),

                              ]),
                            )
                          ]),
                        ),
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


