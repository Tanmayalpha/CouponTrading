import 'dart:async';
import 'dart:convert';

import 'package:coupon_trading/Api/api_services.dart';
import 'package:coupon_trading/Custom%20Widget/gradient_button.dart';
import 'package:coupon_trading/Model/average_profit_loss_model.dart';
import 'package:coupon_trading/Model/purchase_coupon_response.dart';
import 'package:coupon_trading/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../Color/Color.dart';
import 'package:http/http.dart' as http;

import '../Custom Widget/AppBtn.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  TextEditingController quantitycontroller = TextEditingController();
  TextEditingController totalamountcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int totalvalue = 0;

  int selectedIndex = 0;
   DateTime fromDate = DateTime(2019, 10, 14);
   DateTime toDate = DateTime.now() ;
 // bool isPrimary = true ;
  String? uid;
  List<PurchaseCouponData> purchasedList = [];
  String? averageProfitLossMsg;
  bool? isProfit ;

  List<ProfitLossData> averagePList = [];
  bool isLoading = false;
  late Timer timer;

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
    final dateFormat = DateFormat('dd MMM yyyy');
    return  SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9FB),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: const Text(
            'My Portfolio',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              // Total P/L Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isProfit ?? false
                        ? [Colors.green.shade300, Colors.green.shade600]
                        : [Colors.red.shade300, Colors.red.shade600],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: isProfit ?? false
                          ? Colors.green.shade200.withOpacity(0.3)
                          : Colors.red.shade200.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Total Profit / Loss",
                        style: TextStyle(color: Colors.white70, fontSize: 14)),
                    const SizedBox(height: 6),
                    Text(
                      '${isProfit ?? false ? '+' : ''}\$${averageProfitLossMsg ?? '--'}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),

           Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              _selectDate(context,true);
            },
            child: _buildDateBlock(
              icon: Icons.calendar_today,
              label: 'From date',
              date: dateFormat.format(fromDate),
              isBold: true,
              isPrimary: true,
            ),
          ),
          const SizedBox(
            height: 40,
            child: VerticalDivider(
              width: 32,
              thickness: 1,
              color: Colors.grey,
            ),
          ),
          InkWell(
            onTap: (){
              _selectDate(context,false);

            },
            child: _buildDateBlock(
              icon: Icons.calendar_today,
              label: 'To date',
              date: dateFormat.format(toDate),
              isBold: true,
              isPrimary: true,
            ),
          ),
        ],
      ),),

              // History
              Expanded(
                child: ListView.separated(
                  itemCount: purchasedList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {


                    var item = purchasedList[index];
                    final bool isPLPositive = item.isProfit ?? false;
                    int quantity = int.parse(purchasedList[index].quantity ?? '0');

                    return Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 10,
                                offset: const Offset(0, 6),
                              )
                            ],
                          ),
                          child: Column(children: [
                            Row(
                              children: [
                                // Avatar/Icon placeholder
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.currency_exchange, size: 28),
                                ),
                                const SizedBox(width: 12),

                                // Trade info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                        Text(item.purchaseAmount ?? '',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600)),
                                        Text(dateFormat.format(DateTime.parse(item.createdAt ?? '')),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600))
                                      ],),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(children: [
                                            _tag("Qty", item.quantity.toString()),
                                            _tag("Buy", "\₹${item.amount}"),
                                          ],),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: isPLPositive
                                                  ? Colors.green.shade100
                                                  : Colors.red.shade100,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              "${isPLPositive ? '+' : ''}₹${item.profitLossAmount}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                isPLPositive ? Colors.green : Colors.red[600],
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          _tag("Now", "₹${item.currentValue}"),
                                          _tag("Value", "₹${item.currentAmount}"),
                                          quantity > 0? Ink(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),color: Colors.black
                                            ),
                                            child: InkWell(
                                              onTap: (){
                                                selectedIndex = index ;
                                                popshow2(
                                                    item.currentValue.toString(),
                                                    item.coupanId.toString(),
                                                    'Sell',
                                                    item.amount ?? '', index);
                                              },
                                              child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                            margin: const EdgeInsets.only(right: 5),

                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  colors.primary.withOpacity(0.9),
                                                  colors.primary,
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              borderRadius: BorderRadius.circular(15),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.white.withOpacity(0.8),
                                                  offset: const Offset(-3, -3),
                                                  blurRadius: 6,
                                                  spreadRadius: 1,
                                                ),
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.2),
                                                  offset: const Offset(3, 3),
                                                  blurRadius: 6,
                                                  spreadRadius: 1,
                                                ),
                                              ],
                                            ),
                                            child: const Text('Sell', style: TextStyle(color: Colors.white),),),),) : const SizedBox(),

                                        ],
                                      )
                                    ],
                                  ),
                                ),

                                // P/L Badge

                              ],
                            ),
                            //SizedBox(height: 10,),
                            //quantity > 0? AppButton(title: 'Sell',width: 120,height: 40,) : SizedBox(),
                           /* quantity < 1
                                ? const SizedBox()
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
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: colors.primary,
                                    fixedSize: Size(
                                        MediaQuery.of(context).size.width / 2, 35),
                                    shape: const StadiumBorder()),
                                child: const Text("Sell",style: TextStyle(color: Colors.white),),
                              ),
                            )*/
                          ],),
                        ),
                        quantity < 1
                            ? Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.black54.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [

                            ],
                          ),
                          width: double.maxFinite,

                        )
                            : const SizedBox(),
                        quantity < 1 ?   const SizedBox(
                            height: 100,
                            width: double.maxFinite,
                            child: Center(child: Text('SOLD',style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),))):const SizedBox()
                      ],
                    );


                  },
                ),
              ),
            ],
          ),),
      )




      /*Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: context.customGradientBox(),
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
      ),*/
    );
  }

  Widget _tag(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(right: 8, top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$label: $value',
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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



  getUserPref() async {
    isLoading = true;
    setState(() {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('userId');
    getProfitLossData();
    getCoupons();
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
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
    request.fields.addAll({'user_id': uid ?? '34', 'start_date': fromDate.toString(),"end_date":toDate.toString()});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      purchasedList =
          PurchaseCouponsResponse.fromJson(jsonDecode(result)).data ?? [];

      if (!mounted) return;
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


  Widget _buildDateBlock({
    required IconData icon,
    required String label,
    required String date,
    bool isBold = false,
    bool isPrimary = false,
  }) {
    return Row(
      children: [
        Icon(icon, color: isPrimary ? Colors.blue : Colors.grey, size: 24),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isPrimary ? Colors.blueGrey : Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              date,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isPrimary ? Colors.blue.shade900 : Colors.grey.shade700,
              ),
            ),
          ],
        )
      ],
    );
}

  Future<void> _selectDate(BuildContext context, bool isFrom) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFrom ? fromDate : toDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
      getCoupons();
    }
  }


}
