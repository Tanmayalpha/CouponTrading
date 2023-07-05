import 'dart:async';
import 'dart:convert';

import 'package:coupon_trading/Api/api_services.dart';
import 'package:coupon_trading/Model/average_profit_loss_model.dart';
import 'package:coupon_trading/Model/purchase_coupon_response.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../Color/Color.dart';
import 'package:http/http.dart' as http;

import '../Custom Widget/AppBtn.dart';

class Purches_Screen extends StatefulWidget {
  const Purches_Screen({Key? key}) : super(key: key);

  @override
  State<Purches_Screen> createState() => _Purches_ScreenState();
}

class _Purches_ScreenState extends State<Purches_Screen> {
  TextEditingController quantitycontroller = TextEditingController();
  TextEditingController totalamountcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int totalvalue = 0;

  int selectedIndex = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserPref();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  var str = 'profit';

  Future<void> sellCoupon(typeeee, amount, couponId, String purchaseAmount,
      String paymentId) async {
    print("--------- print() ----  ${uid}");
    var headers = {
      'Cookie': 'ci_session=ef2aff848979b6494f9365917121186a328cb6fa'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse('${ApiService.buySellCoupon}'));
    request.fields.addAll({
      'user_id': uid ?? '30',
      'quantity': quantitycontroller.text,
      'coupan_id': couponId.toString(),
      'amount': purchasedList[selectedIndex].currentValue ?? amount.toString(),
      'purchase_amount': purchaseAmount,
      'type': typeeee.toString(),
      'transaction_id': paymentId ?? ''
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print("--------- print() ----  ${request.fields}");

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalrsult = jsonDecode(result);

      if (finalrsult['error'] == false) {
        Fluttertoast.showToast(msg: finalrsult['message']);

        // Navigator.pop(context);
        totalamountcontroller.clear();
        quantitycontroller.clear();
      } else {
        // showToast(finalrsult['message']);
        Fluttertoast.showToast(msg: finalrsult['message']);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  var uuid = Uuid();

  popshow2(String amount, couponId, typ, String purchaseAmount, int index) {
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
                                child: Center(
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
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        "Select Quantity",
                                        style: TextStyle(
                                            color: colors.black54,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
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
                                          if (value.isEmpty) {
                                            setState(() {
                                              totalvalue = 0;
                                            });
                                          } else {
                                            setState(() {
                                              double raj = double.parse(
                                                  amount.toString());
                                              int amoun = int.parse(
                                                  raj.toStringAsFixed(0));

                                              totalvalue =
                                                  int.parse(value.toString()) *
                                                      amoun;

                                              totalamountcontroller.text =
                                                  totalvalue.toString();
                                            });
                                          }
                                        },
                                        // maxLength: 10,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          counterText: "",
                                          contentPadding: EdgeInsets.only(
                                              left: 15, top: 15),
                                          hintText: "Quantity",
                                          hintStyle: TextStyle(
                                              color: colors.secondary),
                                          prefixIcon: Icon(
                                            Icons.countertops,
                                            color: colors.secondary,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                typ == 'Sell'
                                    ? SizedBox()
                                    : Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        "Total Amount",
                                        style: TextStyle(
                                            color: colors.black54,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                typ == 'Sell'
                                    ? SizedBox()
                                    : const SizedBox(
                                  height: 2,
                                ),
                                typ == 'Sell'
                                    ? SizedBox()
                                    : Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  elevation: 4,
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        color: colors.whiteTemp),
                                    child: Center(
                                      child: TextFormField(
                                        readOnly: true,
                                        maxLength: 4,
                                        controller: totalamountcontroller,
                                        keyboardType:
                                        TextInputType.number,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          counterText: "",
                                          contentPadding: EdgeInsets.only(
                                              left: 15, top: 15),
                                          hintText: "Total Amount",
                                          hintStyle: TextStyle(
                                              color: colors.secondary),
                                          prefixIcon: Icon(
                                            Icons.currency_rupee,
                                            color: colors.secondary,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Btn(
                                  onPress: () {
                                    if (_formKey.currentState!.validate()) {
                                      int quantity = int.parse(purchasedList[index].quantity ?? '0');
                                      int enteredQuntity = int.parse(quantitycontroller.text);
                                      if (quantity >= enteredQuntity) {
                                        Navigator.pop(context);
                                        if (typ == 'Sell') {
                                          final paymentId = uuid.v4();
                                          sellCoupon(
                                              typ,
                                              amount.toString(),
                                              couponId.toString(),
                                              purchaseAmount,
                                              paymentId);
                                        }
                                      }else {
                                        Fluttertoast.showToast(msg: 'not valid quantity');
                                      }
                                      // else {
                                      //   // showPPopup(typ);
                                      // }
                                    }
                                  },
                                  width: 200,
                                  height: 50,
                                  title:
                                  typ == 'Sell' ? 'Sell' : 'Make Payment',
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
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
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(color: colors.secondary)),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: isProfit ?? false ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Total P&L: ',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color:  colors.blackTemp),
                      ),Text(
                        '${averageProfitLossMsg ?? '--'}',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color:  Colors.green),
                      )],) : Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [Text(
                      'Total P&L: ',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color:  colors.blackTemp),
                    ),
                      Text(
                        '${averageProfitLossMsg ?? '--'}',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color:  Colors.red),
                      )],),
                ),
              ),
            ),
            isLoading
                ? Center(
              child: CircularProgressIndicator(
                color: colors.secondary,
              ),
            )
                : purchasedList.isEmpty
                ? Text('No purchased coupon availale')
                : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: purchasedList.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {}, child: couponCard(index));
              },
            )
          ]),
        ),
      ),
    );
  }

  Widget couponCard(int index) {
    var item = purchasedList[index];
    int quantity = int.parse(purchasedList[index].quantity ?? '0');
    //int currentAmount =int.parse(purchasedList[index].currentAmount ?? '0');
    return Stack(
      children: [
        Center(
          child: Card(
            margin: const EdgeInsets.all(20.0),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.purchaseAmount ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: colors.secondary),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Quantity:',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: colors.secondary),
                      ),
                      Text(
                        item.quantity ?? 'N/A',
                        style:
                        TextStyle(fontSize: 16.0, color: colors.secondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Amount:',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: colors.secondary),
                      ),
                      Text(
                        item.amount ?? 'N/A',
                        style:
                        TextStyle(fontSize: 16.0, color: colors.secondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,color: colors.secondary
                      ),
                    ),
                    Text(
                      item.totalAmount ?? 'N/A',
                      style: TextStyle(fontSize: 16.0,color: colors.secondary),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),*/
                  /*Text(
                  'Created At: 2023-07-01 19:07:50',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Updated At: 2023-07-01 19:07:50',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 10.0),*/
                  /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Is Profit:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,color: colors.secondary
                      ),
                    ),
                    Text(
                      item.isProfit ?? false ? 'Yes' : 'No',
                      style: TextStyle(fontSize: 16.0,color: colors.secondary),
                    ),
                  ],
                ),
                SizedBox(height: 5.0),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Profit/Loss Amount:',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: colors.secondary),
                      ),
                      Text(
                        item.profitLossAmount ?? 'N/A',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: item.isProfit ?? false
                                ? Colors.green
                                : colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Current Value:',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: colors.secondary),
                      ),
                      Text(
                        item.currentValue ?? 'N/A',
                        style:
                        TextStyle(fontSize: 16.0, color: colors.secondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Purchase Amount:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,color: colors.secondary
                      ),
                    ),
                    Text(
                      item.purchaseAmount ?? 'N/A',
                      style: TextStyle(fontSize: 16.0, color: purchaseAmount > currentAmount ? Colors.red : Colors.green, fontWeight: FontWeight.bold ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Current Amount:',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: colors.secondary),
                      ),
                      Text(
                        item.currentAmount ?? 'N/A',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: colors.secondary),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  quantity < 1
                      ? SizedBox()
                      : Center(
                    child: ElevatedButton(
                      onPressed: () {
                        selectedIndex = index ;
                        popshow2(
                            item.currentValue.toString(),
                            item.coupanId.toString(),
                            'Sell',
                            item.amount ?? '', index);
                        // if (_formKey.currentState!.validate()) {
                        //   Navigator.pop(context);
                        //   if(typ == 'Sell'){
                        //     buyCoupan(typ);
                        //   }else {
                        //     // showPPopup(typ);
                        //   }
                        // }
                      },
                      child: Text("Sell"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          fixedSize: Size(
                              MediaQuery.of(context).size.width / 2, 35),
                          shape: StadiumBorder()),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        quantity < 1
            ? Container(
          height: 200,
          width: double.maxFinite,
          color: Colors.white60,
        )
            : SizedBox()
      ],
    );
  }

  String? uid;
  late Timer timer;
  List<PurchaseCouponData> purchasedList = [];
  String? averageProfitLossMsg;
  bool? isProfit ;

  List<ProfitLossData> averagePList = [];
  bool isLoading = false;

  getUserPref() async {
    isLoading = true;
    setState(() {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('userId');
    getProfitLossData();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      getCoupons();
      getProfitLossData();
    });
  }



  getCoupons() async {
    var headers = {
      'Cookie': 'ci_session=03ddbd7128c202f8453a9d857d8722f0f2477337'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiService.purchasedCoupans}'));
    request.fields.addAll({'user_id': uid ?? '34'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print('___________${request.fields}__________');
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      purchasedList =
          PurchaseCouponsResponse.fromJson(jsonDecode(result)).data ?? [];
      setState(() {
        isLoading = false;
      });
    } else {
      print(response.reasonPhrase);
      setState(() {
        isLoading = false;
      });
    }
  }

  getProfitLossData() async {
    var headers = {
      'Cookie': 'ci_session=03ddbd7128c202f8453a9d857d8722f0f2477337'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiService.averageProfitLossApi}'));
    request.fields.addAll({'user_id': uid ?? '34'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();

      averagePList =
          AverageProfitLossModel.fromJson(jsonDecode(result)).data ?? [];
      averageProfitLossMsg =
          AverageProfitLossModel.fromJson(jsonDecode(result)).currentlyLP ?? '';
      isProfit =  AverageProfitLossModel.fromJson(jsonDecode(result)).isProfit ?? false ;
      setState(() {
        isLoading = false;
      });
    } else {
      print(response.reasonPhrase);
      setState(() {
        isLoading = false;
      });
    }
  }
}
