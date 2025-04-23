import 'dart:async';
import 'dart:convert';

import 'package:coupon_trading/Api/api_services.dart';
import 'package:coupon_trading/Custom%20Widget/gradient_button.dart';
import 'package:coupon_trading/Screen/demo_chart.dart';
import 'package:coupon_trading/Screen/services/Payment/razor_pay.dart';
import 'package:coupon_trading/Screen/services/socket/web_socket.dart';
import 'package:coupon_trading/Screen/wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:interactive_chart/interactive_chart.dart';
// import 'package:k_chart/flutter_k_chart.dart';
import 'package:k_chart/k_chart_widget.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../Color/Color.dart';
import '../Custom Widget/AppBtn.dart';
import '../constant/constant.dart';
import 'charts/candlestick_chart.dart';

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

  // List<KLineEntity>? datas;
  bool showLoading = true;
  MainState _mainState = MainState.MA;
  bool _volHidden = true;
  SecondaryState _secondaryState = SecondaryState.MACD;
  bool isLine = true;
  bool isChinese = false;
  // List<DepthEntity>? _bids, _asks;

 // ChartStyle chartStyle = ChartStyle();
 //  ChartColors chartColors = ChartColors();

  String? uid,name,email,mobile;
  late Razorpay _razorpay;

  // KLineEntity? lastData ;

  final List<CandleData> _data = [];
  bool _darkMode = true;
  bool _showAverage = false;
  String amount ='0.0' ;
  String open ='0.0' ;
  String high ='0.0' ;
  String low ='0.0' ;
  String current ='0.0' ;

  List<CandleData> candles = [];

  bool isLoading = true ;

  final socket = WebSocketManager();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //timer = Timer.periodic(const Duration(seconds: 1), (Timer t) =>  getData());

    myData();
    socketSetup();
    getUserPref();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: _darkMode ? Brightness.dark : Brightness.light,
      ),
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration:  BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        colors.primary.withOpacity(0.5),
                        colors.secondary,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.02, 1]),

                  borderRadius: const BorderRadius.only(
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
                            child: Row(children: [
                              InkWell(
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

                            ],)
                        )
                      ],
                    )),
              ),

              Row(children: [
                IconButton(
                  icon: Icon(_darkMode ? Icons.dark_mode : Icons.light_mode),
                  onPressed: () => setState(() => _darkMode = !_darkMode),
                ),
                IconButton(
                  icon: Icon(
                    _showAverage ? Icons.show_chart : Icons.bar_chart_outlined,
                  ),
                  onPressed: () {
                    setState(() => _showAverage = !_showAverage);
                    if (_showAverage) {
                       _computeTrendLines();
                    } else {
                       _removeTrendLines();
                    }
                  },
                ),
              ],),

              SizedBox(
                height: MediaQuery.of(context).size.height*0.6,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator(),)
                    :  InteractiveChart(
                  /** Only [candles] is required */
                  candles: candles,

                  /** Uncomment the following for examples on optional parameters */

                  /** Example styling */
                  // style: ChartStyle(
                  //   priceGainColor: Colors.teal[200]!,
                  //   priceLossColor: Colors.blueGrey,
                  //   volumeColor: Colors.teal.withOpacity(0.8),
                  //   trendLineStyles: [
                  //     Paint()
                  //       ..strokeWidth = 2.0
                  //       ..strokeCap = StrokeCap.round
                  //       ..color = Colors.deepOrange,
                  //     Paint()
                  //       ..strokeWidth = 4.0
                  //       ..strokeCap = StrokeCap.round
                  //       ..color = Colors.orange,
                  //   ],
                  //   priceGridLineColor: Colors.blue[200]!,
                  //   priceLabelStyle: TextStyle(color: Colors.blue[200]),
                  //   timeLabelStyle: TextStyle(color: Colors.blue[200]),
                  //   selectionHighlightColor: Colors.red.withOpacity(0.2),
                  //   overlayBackgroundColor: Colors.red[900]!.withOpacity(0.6),
                  //   overlayTextStyle: TextStyle(color: Colors.red[100]),
                  //   timeLabelHeight: 32,
                  //   volumeHeightFactor: 0.2, // volume area is 20% of total height
                  // ),
                  /** Customize axis labels */
                  // timeLabel: (timestamp, visibleDataCount) => "📅",
                  // priceLabel: (price) => "${price.round()} 💎",
                  /** Customize overlay (tap and hold to see it)
                   ** Or return an empty object to disable overlay info. */
                  // overlayInfo: (candle) => {
                  //   "💎": "🤚    ",
                  //   "Hi": "${candle.high?.toStringAsFixed(2)}",
                  //   "Lo": "${candle.low?.toStringAsFixed(2)}",
                  // },
                  /** Callbacks */
                  // onTap: (candle) => print("user tapped on $candle"),
                  // onCandleResize: (width) => print("each candle is $width wide"),
                ),
              ),

              /*Column(
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

                  ]),
                  buildButtons(),
                  *//*Container(
              height: 230,
              width: double.infinity,
              child: DepthChart(_bids!, _asks!,chartColors),
            )*//*

                ],
              ),*/
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
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
                            high == '' ?  widget.amount.toString() : high , //amount
                            style:  TextStyle(fontSize: 12, color: _darkMode ? colors.whiteTemp : colors.blackTemp),
                          ),
                        ]),
                      ),
                    ),
                    Card(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
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
                                candles.isEmpty ? '--':  low,  //candles.last.low.toString() ,
                              style:  TextStyle(fontSize: 12, color: _darkMode ? colors.whiteTemp : colors.blackTemp),
                            ),
                          ])
                      ),
                    ),
                    candles.isEmpty
                        ? const SizedBox()
                        : Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
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
                              (candles.last?.open ?? 0.0) <= (double.parse(current ?? '0.0') )
                                  ? Text(
                                current == '' ?  widget.amount.toString() :  current,//amount
                                style: const TextStyle(fontSize: 13, color: Colors.green,fontWeight: FontWeight.bold),
                              ) : Text(
                                current == '' ?  widget.amount.toString() : current ,
                                style: const TextStyle(fontSize: 12, color: colors.red,fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
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
                                candles.isEmpty ? '--': open,//candles.last.open.toString(),
                                style: TextStyle(fontSize: 12, color: _darkMode ? colors.whiteTemp : colors.blackTemp),
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
                      height: 40,
                      width: 200,
                      onPress: () {
                        setState(() {
                          typee = "Buy";
                        });

                        buySellDialog(typee);
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
        )),);
  }


  _computeTrendLines() {
    final ma7 = CandleData.computeMA(candles, 7);
    final ma30 = CandleData.computeMA(candles, 30);
    final ma90 = CandleData.computeMA(candles, 90);

    for (int i = 0; i < candles.length; i++) {
      candles[i].trends = [ma7[i], ma30[i], ma90[i]];
    }
  }

  _removeTrendLines() {
    for (final data in candles) {
      data.trends = [];
    }
  }

  getUserPref() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid =  prefs.getString('userId');
    email = prefs.getString(Constant.EMAIL);
    name = prefs.getString(Constant.NAME);
    mobile =prefs.getString(Constant.PHONE);
  }

  Future<void> buySellCoupan(typeeee, {String ? paymentid, String? paymentType }) async {
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

  void paymentMethodPopup(String type) {
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
            width: MediaQuery.of(context).size.width,
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
                height: 25,
              ),
              const Text(
                'Select Any One Payment Method',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              AppButton(
                width: 150,
                height: 40,
                title: 'Wallet',
                onTab: (){
                  Navigator.pop(context);
                  final paymentId = uuid.v4();
                  buySellCoupan(typee, paymentid: paymentId,paymentType: 'wallet');
                },
              ),
              const SizedBox(
                height: 10,
              ),
              AppButton(
                width: 150,
                height: 40,
                title: 'Other',
                onTab: (){
                  Navigator.pop(context);


                  RazorPayHelper razorPay = RazorPayHelper(
                      '120', context, (result) async {
                    if (result != "error") {

                      buySellCoupan(typee,paymentid: result);
                      Fluttertoast.showToast(
                          msg: "Successful",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);

                    } else {}
                  },email: email, mobile: mobile,name: name);

                  razorPay.init();
                },
              ),

            ]),
          ),
        );
      },
    );
  }

  buySellDialog(
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
                    SizedBox(
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
                                      typ,
                                      style: const TextStyle(
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
                                const Row(
                                  children: [
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
                                          print('${amount.toString()}___________fds');
                                          print('${value}___________value');
                                          if (value.isEmpty) {
                                            setState(() {
                                              totalvalue = 0;
                                            });
                                          } else {
                                            setState(() {


                                              double raj = double.parse(amount.toString());
                                              int amoun = int.parse(raj.toStringAsFixed(0));

                                              totalvalue = int.parse(value.toString()) * amoun;

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
                                    ? const SizedBox()
                                    :  const Row(
                                  children: [
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
                                typ == 'Sell' ? const SizedBox() :  const SizedBox(
                                  height: 2,
                                ),
                                typ == 'Sell' ? const SizedBox() :  Card(
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
                                        buySellCoupan(typ);
                                      }else {
                                        paymentMethodPopup(typ);
                                      }
                                    }
                                  },
                                  width: 200,
                                  height: 50,
                                  title: typ == 'Sell' ?'Sell' : 'Make Payment',
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


  void getData() {


   /* Future<String> future = myData();//getIPAddress('$period');
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
    });*/
  }

  Future<void> myData() async{

   List <dynamic> _rawData = [];
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
     var result = jsonDecode(await response.stream.bytesToString());

     amount = result['price'];

      (result['data'] as List).forEach((element) {

        int timeStamp = element['time'];
        double open = double.parse(element['open']);
        double high = double.parse(element['high']);
        double low = double.parse(element['low']);
        double close = double.parse(element['close']);
        int volume = double.parse(element['vol']).toInt();

        _rawData.add([timeStamp,open,high,low,close,volume]);
      });

     candles = _rawData.map((row) => CandleData(
       timestamp: row[0] * 1000,
       open: row[1]?.toDouble(),
       high: row[2]?.toDouble(),
       low: row[3]?.toDouble(),
       close: row[4]?.toDouble(),
       volume: row[5]?.toDouble(),
     )).toList();

     open    =     candles.last.open.toString() ;
     high    =     candles.last.high.toString() ;
     low     =     candles.last.low.toString() ;
     current = amount = result['price'];


    setState(() {
      isLoading = false ;
    });    }
    else {

      log('${await response.stream.bytesToString()}');
      print(response.reasonPhrase);
    }
  }

  Future <void> socketSetup() async{

    socket.connect();

    socket.send(jsonEncode({"type":"coupon-graph", 'coupon_id' : widget.coupanid}));


    socket.stream.listen((event) {


      if(event['type'] =='coupon-graph-updated' && event['coupon_id'].toString() == widget.coupanid ){

        if (event['data'] != null && event['data'].isNotEmpty) {
          final kline = event['data'][0];
          log('Event trading: ${event}');

           //amount = event['current'] ;
          open = event['open'].toString() ;
          high =event['high'].toString() ;
          low =event['low'].toString() ;
          current = event['current'].toString() ;




          int timeStamp = kline['time'];
          double open1 = double.parse(kline['open']);
          double high1 = double.parse(kline['high']);
          double low1 = double.parse(kline['low']);
          double close1 = double.parse(kline['close']);
          int volume1 = double.parse(kline['vol']).toInt();

          var newEntity = CandleData(
            timestamp: timeStamp * 1000,
            open: open1,
            high: high1,
            low: low1,
            close: close1,
            volume: volume1.toDouble(),
          );


            // Update or add new candle
            final index = candles.indexWhere((item) => item.timestamp == newEntity.timestamp);
            if (index >= 0) {
              candles[index] = newEntity;
            } else {
              candles.add(newEntity);
              if (candles.length > 200) candles.removeAt(0);
            }

            if(mounted) {
            setState(() {});
          }
        }

      }

    });


  }


}
