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
          const SizedBox(height: 30,),
          Column(
            children: [
              const Center(child: Text("Available Balance",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)),
              const Text("₹ 455",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              const SizedBox(height: 20,),
              InkWell(
                onTap: (){
                 // if (_formKey.currentState!.validate()) {
                    //walletHistroy();
                    //Get.to(AddAmount(walletBalance: walletHistorymodel?.wallet??'--',))?.then((value) => walletHistroy() );
                  //}
                  // addMoney();
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
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.topLeft,
                child: Row(children: [
                  Icon(Icons.account_balance_wallet, color: colors.secondary,),
                  const SizedBox(width: 10,),
                  const Text("WalletHistory",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                ],),),
             /* walletHistorymodel?.data == null ? Center(child: CircularProgressIndicator(color: splashcolor,),) : walletHistorymodel?.data?.isEmpty ?? true ?
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
                            'Payment Type: ${item?.paymentType}',
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
                                'Date : ${item?.createDt}',
                                style: const TextStyle(
                                    fontSize: 14.0, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },)*/
            ],
          ),

        ]),
      ),
    );
  }
}
