import 'dart:async';
import 'dart:convert';

import 'package:coupon_trading/Api/api_services.dart';
import 'package:coupon_trading/Screen/demo_chart.dart';
import 'package:coupon_trading/Screen/wallet.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:k_chart/flutter_k_chart.dart';
import 'package:k_chart/k_chart_widget.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../Color/Color.dart';
import '../Custom Widget/AppBtn.dart';

class TradingScreen extends StatefulWidget {
  final String? useridd;
  final String? coupanid;
  final String? name;
  final String? amount;

  TradingScreen({Key? key, this.name, this.amount, this.coupanid, this.useridd})
      : super(key: key);

  @override
  State<TradingScreen> createState() => _TradingScreenState();
}

class _TradingScreenState extends State<TradingScreen> {
  var typee;
  TextEditingController quantitycontroller = TextEditingController();
  TextEditingController totalamountcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int totalvalue = 0;

  List<KLineEntity>? datas;
  bool showLoading = true;
  MainState _mainState = MainState.MA;
  bool _volHidden = true;
  SecondaryState _secondaryState = SecondaryState.MACD;
  bool isLine = true;
  bool isChinese = false;
  List<DepthEntity>? _bids, _asks;

  ChartStyle chartStyle = ChartStyle();
  ChartColors chartColors = ChartColors();

  String? uid;
  late Razorpay _razorpay;
  late Timer timer;

  KLineEntity? lastData ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) =>  getData());

    getUserPref();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
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
                          padding: EdgeInsets.only(left: 15, top: 20, right: 15),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WalletScr(),
                                  ));
                            },
                            child: Container(
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.account_balance_wallet_outlined,
                                    color: colors.whiteTemp,
                                  ),
                                  Text(
                                    'Wallet',
                                    style:
                                    TextStyle(fontSize: 10, color: colors.whiteTemp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),

              Column(
                children: <Widget>[
                  Stack(children: <Widget>[
                    SizedBox(
                      height: 450,
                      width: double.maxFinite,
                      child: KChartWidget(
                        datas,
                        isLine: isLine,

                        mainState: _mainState,
                        volHidden: _volHidden,
                        secondaryState: _secondaryState,
                        chartStyle,
                        chartColors,
                        fixedLength: 2,
                        timeFormat: TimeFormat.YEAR_MONTH_DAY,
                        isChinese: isChinese,
                        isTrendLine: true,
                      ),
                    ),
                    if (false)
                      Container(
                          width: double.infinity,
                          height: 450,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator()),
                  ]),
                  buildButtons(),
                  /*Container(
              height: 230,
              width: double.infinity,
              child: DepthChart(_bids!, _asks!,chartColors),
            )*/
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(children: [

                          const Text(
                            'High',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: colors.secondary),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            amount == '' ?  widget.amount.toString() : amount ,
                            style: TextStyle(fontSize: 12, color: colors.blackTemp),
                          ),
                        ]),
                      ),
                    ),
                    Card(
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(children: [

                            const Text(
                              'Low',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: colors.secondary),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              lastData?.low.toString() ??'--' ,
                              style: const TextStyle(fontSize: 12, color: colors.blackTemp),
                            ),
                          ])
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                            children: [

                              const Text(
                                'Current Prize',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: colors.secondary),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              (lastData?.open ?? 0.0) <= (double.parse(amount ?? '0.0') ) ? Text(
                                amount == '' ?  widget.amount.toString() : amount ,
                                style: const TextStyle(fontSize: 13, color: Colors.green,fontWeight: FontWeight.bold),
                              ) : Text(
                                amount == '' ?  widget.amount.toString() : amount ,
                                style: const TextStyle(fontSize: 12, color: colors.red,fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child:  Column(
                            children: [

                              const Text(
                                'Open',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: colors.secondary),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                lastData?.open.toString() ?? '--',
                                style: TextStyle(fontSize: 12, color: colors.blackTemp),
                              ),
                            ]),
                      ),
                    ),



                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Btn(

                      title: "Buy",
                      height: 50,
                      width: 100,
                      onPress: () {
                        setState(() {
                          typee = "Buy";
                        });

                        popshow2(typee);
                      },
                    ),
                  ),
                  /*Center(
              child: Btn(
               color: colors.red,
                title: "Sell",
                height: 50,
                width: 100,
                onPress: () {
                  setState(() {
                    typee = "Sell";
                  });
                  popshow2(typee);
                },
              ),
            ),*/
                  /* button1(() {
                setState(() {
                  typee = "Sell";
                });
                popshow2(typee);
              },),*/

                ],),
              const SizedBox(height: 50,)
            ]),
          ),
        ));
  }

  getUserPref() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('userId');
  }

  Future<void> buyCoupan(typeeee, {String ? paymentid, String? paymentType }) async {
    var headers = {
      'Cookie': 'ci_session=ef2aff848979b6494f9365917121186a328cb6fa'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiService.buySellCoupon}'));
    request.fields.addAll({
      'user_id': uid ?? '30',
      'quantity': quantitycontroller.text,
      'coupan_id': widget.coupanid.toString(),
      'amount': amount.toString(),
      'purchase_amount': amount.toString(),
      'type': typeeee.toString(),
      'transaction_id': paymentid ?? '',
      'transaction_type': paymentType ?? ''
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print("--------- print() ----  ${request.fields}" );

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalrsult = jsonDecode(result);

      if (finalrsult['error'] == false) {
        showToast(finalrsult['message']);

        Navigator.pop(context);
        totalamountcontroller.clear();
        quantitycontroller.clear();
      } else {
        showToast(finalrsult['message']);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Widget button1(VoidCallback onPress) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          gradient: const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.red,
                Colors.red,
              ],
              stops: [
                0,
                1,
              ]),
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color:colors.primary)
        ),
        height: 50,
        width: 100,
        child: const Center(
          child: Text(
            "Sell",
            style:  TextStyle(
              color:colors.whiteTemp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
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
  var uuid = Uuid();
  void showPPopup(String type) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Column(children: [
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 5,
                width: 100,
                decoration: BoxDecoration(
                    color: colors.secondary,
                    borderRadius: BorderRadius.circular(50)),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Select Any One Payment Method',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  final paymentId = uuid.v4();
                  buyCoupan(typee, paymentid: paymentId,paymentType: 'wallet');
                },
                child: Card(
                  elevation: 4,
                  child: Container(
                    height: 40,
                    width: 150,
                    child: const Center(
                        child: Text(
                          'Wallet',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: colors.secondary),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  openCheckout();

                },
                child: Card(
                  elevation: 4,
                  child: Container(
                    height: 40,
                    width: 150,
                    child: Center(
                        child: Text(
                          'Other',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: colors.secondary),
                        )),
                  ),
                ),
              )
            ]),
          ),
        );
      },
    );
  }

  popshow2(
      String typ,
      ) {
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
                                typ == 'Sell' ? SizedBox() :   Row(
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
                                typ == 'Sell' ? SizedBox() :  const SizedBox(
                                  height: 2,
                                ),
                                typ == 'Sell' ? SizedBox() :  Card(
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
                                        readOnly: true,
                                        maxLength: 4,
                                        controller: totalamountcontroller,
                                        keyboardType: TextInputType.number,
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
                                      Navigator.pop(context);
                                      if(typ == 'Sell'){
                                        buyCoupan(typ);
                                      }else {
                                        showPPopup(typ);
                                      }
                                    }
                                  },
                                  width: 200,
                                  height: 50,
                                  title: typ == 'Sell' ?'Sell' :  'Make Payment',
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


  Widget buildButtons() {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: <Widget>[
        button("Line Chart", onPressed: () => isLine = true),
        button("Candlestick Chart", onPressed: () => isLine = false),
        button("MA", onPressed: () => _mainState = MainState.MA),
        button("BOLL", onPressed: () => _mainState = MainState.BOLL),
        button("MA Hide", onPressed: () => _mainState = MainState.NONE),
        button("MACD", onPressed: () => _secondaryState = SecondaryState.MACD),
        //button("KDJ", onPressed: () => _secondaryState = SecondaryState.KDJ),
        //button("RSI", onPressed: () => _secondaryState = SecondaryState.RSI),
        //button("WR", onPressed: () => _secondaryState = SecondaryState.WR),
        button("MCDCA None", onPressed: () => _secondaryState = SecondaryState.NONE),
        button(_volHidden ? "volHidden" : "Visible",
            onPressed: () => _volHidden = !_volHidden),
        //button("切换中英文", onPressed: () => isChinese = !isChinese),
      ],
    );
  }
  Widget button(String text, {VoidCallback? onPressed}) {
    return ElevatedButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
          setState(() {});
        }
      },
      child: Text("$text"),
      style: ElevatedButton.styleFrom(backgroundColor: colors.secondary),
    );
  }
  String amount ='0.0' ;

  void getData() {
    /*Future<String> future = getIPAddress('$period');

    future.then((result) {
      Map parseJson = json.decode(result);
      List list = parseJson['data'];
      datas = list
          .map((item) => KLineEntity.fromJson(item))
          .toList()
          .reversed
          .toList()
          .cast<KLineEntity>();
      DataUtil.calculate(datas!);
      showLoading = false;
      setState(() {});
    }).catchError((_) {
      showLoading = false;
      setState(() {});
      print('获取数据失败');
    });*/

    Future<String> future = myData();//getIPAddress('$period');
    future.then((result) {
      Map parseJson = json.decode(result);
      List list = parseJson['data'];
      datas = list
          .map((item) => KLineEntity.fromJson(item))
          .toList()
          .reversed
          .toList()
          .cast<KLineEntity>();
      DataUtil.calculate(datas!);
      showLoading = false;
      amount = parseJson['price'];
      lastData =  list.map((e) => KLineEntity.fromJson(e)).toList().last ;

      setState(() {});
    }).catchError((_) {
      // showLoading = false;
      setState(() {});
      print('获取数据失败');
    });
  }

  Future<String> myData() async{
    String result = '';
    var headers = {
      'Cookie': 'ci_session=aee89621fdc53ceafa0e31d5f48378699c94d35b'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.get_coupans_detail}'));
    request.fields.addAll({
      'coupan_id': widget.coupanid ?? '1'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      result = await response.stream.bytesToString();
      print('___________${result}__________');
    }
    else {
      print(response.reasonPhrase);
    }
    return result ;
  }

  Future<String> getIPAddress(String period) async {
    String result = '';
    var url =
        'https://api.huobi.br.com/market/history/kline?period=${period ?? '1day'}&size=300&symbol=btcusdt';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      result = response.body;
      log(response.body);
    } else {
      print('Failed getting IP address');
    }
    return result;
  }

  void openCheckout() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //String? email = prefs.getString('email');
    String phone = '9070305953';
    int amt = totalvalue;


    print('${phone}_______________');
    print('${amt}_______________');

    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': amt*100,
      'name': 'Coupon Trad',
      'description': 'Coupon Trad-user',
      "currency": "INR",
      // 'prefill': {'contact': '$phone', 'email': '$email'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {

    // onSuccessAddMoney();
    buyCoupan(typee,paymentid: response.paymentId);
    Fluttertoast.showToast(
        msg: "Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoardScreen()));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Fluttertoast.showToast(
    //     msg: "ERROR: " + response.code.toString() + " - " + response.message!,
    //     toastLength: Toast.LENGTH_SHORT);

    print('${response.error}________error_________');
    print('${response.code}________code_________');
    Fluttertoast.showToast(
        msg: "Payment cancelled by user",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }
}
