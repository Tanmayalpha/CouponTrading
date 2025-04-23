import 'dart:convert';

import 'package:coupon_trading/Api/api_services.dart';
import 'package:coupon_trading/Model/add_wallet_balance_response.dart';
import 'package:coupon_trading/Model/get_profile.dart';
import 'package:coupon_trading/Model/walletHistory.dart';
import 'package:coupon_trading/Model/withdrawal_request_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Color/Color.dart';
import 'package:http/http.dart' as http;

class WalletScr extends StatefulWidget {
  const WalletScr({Key? key}) : super(key: key);

  @override
  State<WalletScr> createState() => _WalletScrState();
}

class _WalletScrState extends State<WalletScr> {
  late Razorpay _razorpay;
  final amountController = TextEditingController();
  final bankDetailsController = TextEditingController();
  bool isSelected = true;
  bool isSelected2 = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserPref();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
              children: [

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
                          const Text(
                            'Wallet',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: colors.whiteTemp),
                          ),
                        ],
                      )),
                ),
                const SizedBox(height: 30,),

                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Center(child: Text("Available Balance",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)),
                            Text("₹ ${balance ?? '0.0'}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          ],),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colors.whiteTemp,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isSelected = true;
                                      });
                                    },
                                    child: Container(
                                        height: 50,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? colors.secondary
                                              : colors.whiteTemp,
                                          // border: Border.all(color: AppColors.AppbtnColor),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child:  Center(
                                          child: Text(
                                            'Add Amount',
                                            style: TextStyle(
                                              color: isSelected
                                                  ? Color(0xffffffff)
                                                  : colors.secondary,
                                              fontSize: 16,
                                            ),
                                          ),
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        // Navigator.of(context).push(MaterialPageRoute(
                                        //   builder: (context) => NextPage(),
                                        // ));
                                        isSelected = false;
                                      });
                                    },
                                    child: Container(
                                        height: 50,
                                        width: 130,
                                        decoration: BoxDecoration(
                                            color: !isSelected
                                                ? colors.secondary
                                                : colors.whiteTemp,
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Center(
                                          child: Text(
                                            'Withdraw Amount',
                                            style: TextStyle(
                                              color: !isSelected
                                                  ? colors.whiteTemp
                                                  : colors.secondary,
                                              fontSize: 16,
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),),
                          )

                        ],
                      ),
                      const SizedBox(height: 20,),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          //height: 50,
                          child: TextField(
                            controller: amountController,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]+'))],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border:  OutlineInputBorder(
                                  borderSide: BorderSide.none
                              ),
                              hintText: "Enter Amount",
                            ),
                          ),
                        ),
                      ),
                      !isSelected ?
                      const SizedBox(height: 10,)
                          :const SizedBox.shrink(),
                      !isSelected ?
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 90,
                          child: TextField(
                            controller: bankDetailsController,
                            // inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]+'))],
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border:  OutlineInputBorder(
                                  borderSide: BorderSide.none
                              ),
                              hintText: "Enter Bank Details \n Account No : \n Bank Name : \n Account Holder Name : \n IFSC Code :",
                            ),
                          ),
                        ),
                      )
                          : const SizedBox.shrink(),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isSelected ?
                            InkWell(
                              onTap: (){

                                if(amountController.text.isEmpty){
                                  Fluttertoast.showToast(msg: 'Please Enter amount');
                                }else {
                                  openCheckout();
                                }




                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: colors.secondary,
                                ),
                                height: 40,
                                child: Center(child: Text("Add Amount",style: TextStyle(color: colors.whiteTemp,fontSize: 15),)),
                              ),
                            ) :
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: (){
                                  if (amountController.text.isNotEmpty || bankDetailsController.text.isNotEmpty) {
                                    sendWithdrawRequest();
                                    // walletHistroy();
                                    // Get.to(AddAmount(walletBalance: walletHistorymodel?.wallet??'--',))?.then((value) => walletHistroy() );
                                  }else{
                                    Fluttertoast.showToast(msg: "Please enter amount or bank details!");
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colors.secondary,
                                  ),
                                  height: 40,
                                  width: MediaQuery.of(context).size.width/2.5,
                                  child: const Center(
                                    child: Text(
                                      "Withdrawal Request",
                                      style: TextStyle(color: colors.whiteTemp,fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ),


                          ],),
                      ),
                      const SizedBox(height: 20,),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: colors.whiteTemp,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isSelected2 = true;
                                  });
                                },
                                child: Container(
                                    height: 50,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: isSelected2
                                          ? colors.secondary
                                          : colors.whiteTemp,
                                      // border: Border.all(color: AppColors.AppbtnColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:  Center(
                                      child:  Text("Wallet History",
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: isSelected2 ? colors.whiteTemp : colors.blackTemp),),
                                    )),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {

                                    isSelected2 = false;
                                  });
                                },
                                child: Container(
                                    height: 50,
                                    width: 150,

                                    decoration: BoxDecoration(
                                        color: !isSelected2
                                            ? colors.secondary
                                            : colors.whiteTemp,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(child:  Text("Withdrawal History",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: !isSelected2 ? colors.whiteTemp : colors.blackTemp),))),
                              ),
                            ],
                          ),),
                      ),
                      /*Align(
                    alignment: Alignment.topLeft,
                    child: Row(children: [
                      Icon(Icons.account_balance_wallet, color: colors.secondary,),
                      const SizedBox(width: 10,),
                      const Text("WalletHistory",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    ],),),*/
                      isSelected2 ? walletHistorymodel?.data == null
                          ? const Center(child: CircularProgressIndicator(color: colors.primary,),)
                          : walletHistorymodel?.data?.isEmpty ?? true ?
                      const Text("Not Available",): ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: walletHistorymodel?.data?.length,
                        itemBuilder: (context, index) {
                          var item = walletHistorymodel?.data?[index];
                          return Card(
                            elevation: 2.0,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Amount: ${item?.amount}',
                                    style: const TextStyle(
                                        fontSize: 14.0, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    'Payment Type: ${item?.type}',
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    'Status: ${item?.status}',
                                    style: const TextStyle(
                                        fontSize: 14.0, fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Date : ${item?.dateCreated}',
                                        style: const TextStyle(
                                            fontSize: 14.0, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Message : ',
                                        style: TextStyle(
                                            fontSize: 14.0, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          '${item?.message}',
                                          style: const TextStyle(
                                              fontSize: 14.0, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          );
                        },)
                          : withdrawalRequestData?.data == null
                          ? const Center(child: CircularProgressIndicator(color: colors.primary,),)
                          : withdrawalRequestData?.data?.isEmpty ?? true ?
                      const Text("Not Available",): ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: withdrawalRequestData?.data?.length,
                        itemBuilder: (context, index) {
                          var item = withdrawalRequestData?.data?[index];
                          String status = '' ;
                          if(item?.status == '0'){
                            status = 'Pending' ;
                          }else if(item?.status == '1'){
                            status = 'Approved' ;
                          }else {
                            status = 'Rejected' ;

                          }
                          return Card(
                            elevation: 2.0,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Payment Address: ${item?.paymentAddress}',
                                    style: const TextStyle(
                                        fontSize: 14.0, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    'Amount: ${item?.amountRequested}',
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    'Status: ${status}',
                                    style: const TextStyle(
                                        fontSize: 14.0, fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Date : ${item?.dateCreated}',
                                        style: const TextStyle(
                                            fontSize: 14.0, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(

                                    children: [
                                      const Text(
                                        'Message: ',
                                        style: TextStyle(
                                            fontSize: 14.0, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          '${item?.remarks}',
                                          style: const TextStyle(
                                              fontSize: 14.0, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },)
                    ],
                  ),
                ),

              ]),
        ),
      ),
    );
  }
  String? uid ;
  String? oldBalance;
  String? newBalance;
  AddWalletBalance ? addWalletBalance ;

  getUserPref() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('userId');
    getUserData();
    walletHistory();
    withdrawalHistory();
  }

  GetProfile? getProfile ;
  String? balance ;

  getUserData() async{
    var headers = {
      'Cookie': 'ci_session=03ddbd7128c202f8453a9d857d8722f0f2477337'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getProfile}'));
    request.fields.addAll({
      'user_id': uid ??'34'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      getProfile  = GetProfile.fromJson(jsonDecode(result));
      balance = getProfile?.data?.first.balance ;



      setState(() {

      });
    }
    else {
      print(response.reasonPhrase);
    }

  }

  sendWithdrawRequest() async{
    var headers = {
      'Cookie': 'ci_session=03ddbd7128c202f8453a9d857d8722f0f2477337'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiService.withdrawRequestApi));
    request.fields.addAll({
      'user_id': uid ??'1',
      'amount' : amountController.text.toString(),
      'bank_detail': bankDetailsController.text.toString()
    });

    request.headers.addAll(headers);

    print('___________${request.fields}__________');

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      Fluttertoast.showToast(msg: 'Withdraw request sent successfully!');
      Navigator.pop(context);


      // getProfile  = GetProfile.fromJson(jsonDecode(result));
      // balance = getProfile?.data?.first.balance ;
      //
      //
      //
      // setState(() {
      //
      // });
    }
    else {
      print(response.reasonPhrase);
    }

  }

  void openCheckout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String phone = '9070305952';
    int amt = int.parse(amountController.text);


    print('${email}_______________');
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
    addBalance(response.paymentId ?? 'sds');
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


  Future<void> addBalance( String paymentId) async{
    var headers = {
      'Cookie': 'ci_session=0640b26e41e1bc10f92430c96274190de06e9f23'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.add_balance}'));
    request.fields.addAll({
      'transaction_type': 'wallet',
      'user_id': uid ?? '30',
      'type': 'credit',
      'payment_method': 'razorpay',
      'txn_id': paymentId,
      'amount': amountController.text.isEmpty ? '0' : amountController.text ,
      'status': 'success',
      'message': 'Add Amount to wallet'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print('___________${request.fields}__________');

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print("--------- print() ----  ${result}" );
      var finalResult = jsonDecode(result);

      if(finalResult['error']){

        //Fluttertoast.showToast(msg: finalResult['message']);
        //oldBalance = finalResult['old_balance'];
        // newBalance = finalResult['new_balance'];
        getUserData();

      }else{
        //addWalletBalance = AddWalletBalance.fromJson(finalResult);
        // oldBalance = finalResult['old_balance'];
        //  newBalance = finalResult['new_balance'];
        getUserData();
        Fluttertoast.showToast(msg: finalResult['message']);
        setState(() {

        });
        print(addWalletBalance?.message) ;
      }



    }
    else {
      print(response.reasonPhrase);
    }

  }

  WalletHistorymodel ? walletHistorymodel ;

  Future<void> walletHistory() async{

    var headers = {
      'Cookie': 'ci_session=b044cb762446971df8295a116790be9ade21ae34'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.walletTransaction}'));
    request.fields.addAll({
      'user_id': uid ?? '30',
      'transaction_type': 'wallet'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();

      var finalResult  = jsonDecode(result);

      if(finalResult['error']){

      }else {
        walletHistorymodel = WalletHistorymodel.fromJson(finalResult) ;
        setState(() {

        });
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  WithdrawalRequestResponse ? withdrawalRequestData ;

  Future<void> withdrawalHistory() async{
    var headers = {
      'Cookie': 'ci_session=2694555c90449546e1b3528e780ad0e1cd63b74d'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiService.getWithdrawHistory));
    request.fields.addAll({
      'user_id': uid ?? '27'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result =   await response.stream.bytesToString();
      var finalResult = jsonDecode(result) ;

      if(finalResult['error']){

      }else {
        withdrawalRequestData = WithdrawalRequestResponse.fromJson(finalResult);
      }
    }
    else {
      print(response.reasonPhrase);
    }

  }
}
