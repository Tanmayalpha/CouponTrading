import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coupon_trading/Api/api_services.dart';
import 'package:coupon_trading/Screen/Authentification/LoginScreen.dart';
import 'package:coupon_trading/Screen/support_screen.dart';
import 'package:coupon_trading/Screen/trading_Scr.dart';
import 'package:coupon_trading/constant/constant.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Color/Color.dart';
import '../../Custom Widget/AppBtn.dart';

import '../../Model/getCoupanModel.dart';
import '../profile/EditeProfile.dart';

import '../wallet.dart';
import '../aboutUs.dart';
import '../privacy_policy_screen.dart';
import '../terms_condition_screen.dart';
import 'bottombar.dart';

class HomeScreen extends StatefulWidget {
  final String? userId;

  const HomeScreen({
    Key? key,
    this.userId,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  var firstname;
  var middlename;
  var lastname;
  var gmaill;
  int currentindex = 0;
  late Timer timer;
  List<String> sliderImages = [
    'https://shotkit.com/wp-content/uploads/2021/06/cool-profile-pic-matheus-ferrero.jpeg',
    'https://img.freepik.com/free-photo/brunette-blogger-posing-photo_23-2148192223.jpg',
    'https://img.freepik.com/premium-photo/fashion-red-haired-girl-wear-black-dress-red-hat-posed-trade-shopping-center_151355-1430.jpg',
    'https://static.vecteezy.com/system/resources/thumbnails/006/631/541/small_2x/portrait-of-fashion-red-haired-girl-on-red-hat-and-black-dress-with-bright-make-up-posed-against-large-window-toned-style-instagram-filters-photo.jpg'
  ];

  _CarouselSlider1() {
    return CarouselSlider(
        options: CarouselOptions(
            onPageChanged: (index, result) {
              setState(() {
                _currentPost = index;
              });
            },
            viewportFraction: 1.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 500),
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
            height: 180.0),
        items: sliderImages.map((e) {
          return Image.network(e);
        }).toList());
  }

  void initState() {
    super.initState();
    getCoupanApi();
    getPref();
    /*timer = Timer(Duration(seconds: 1), () {
      getCoupanApi();
    });*/
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) =>  getCoupanApi());

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  Future<Null> _refresh() {
    return callApi();
  }

  Future<Null> callApi() async {
  }

  setFilterDataId(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('LocalId', id);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: Scaffold(
        backgroundColor: colors.whiteScaffold,
        key: _key,
        drawer: getDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
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
                      bottomLeft: Radius.circular(5),
                      //
                      bottomRight: Radius.circular(5),
                    ),
                    //   color: (Theme.of(context).colorScheme.apcolor)
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          _key.currentState!.openDrawer();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 1),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.dehaze_rounded,
                              color: colors.whiteTemp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                      ),
                      const Text(
                        'Home',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: colors.whiteTemp),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only( top: 10,bottom: 10, right: 15),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WalletScr(),
                                ));
                          },
                          child: Column(
                            children: const [
                              Icon(
                                Icons.account_balance_wallet_outlined,
                                color: colors.whiteTemp,
                              ),
                              Text(
                                'Wallet',
                                style: TextStyle(
                                    fontSize: 10, color: colors.whiteTemp),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.32,
                  child: ListView.builder(
                    primary: false,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: coupanList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TradingScreen(
                                  useridd: widget.userId.toString(),
                                  coupanid: coupanList[index].id,
                                  amount: coupanList[index].price,
                                  name: coupanList[index].name,
                                ),
                              ));
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 2,
                            color: Colors.white,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(children: [
                                      SizedBox(
                                        width:
                                        MediaQuery.of(context).size.width /
                                            1.4,
                                        child: ListTile(
                                          leading: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width /
                                                5,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        coupanList[index].logo ?? ''),
                                                    fit: BoxFit.fill)),
                                          ),
                                          title: Text(
                                            "${coupanList[index].name}",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: colors.secondary),
                                          ),
                                          subtitle: Text(
                                            'Available Stock -${coupanList[index].stock}',
                                            style: const TextStyle(
                                                fontSize: 9,
                                                color: colors.secondary),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width /
                                              5,
                                          child: Center(
                                            child: Center(
                                              child: Btn(
                                                height: 30,
                                                width: 60,
                                                title:
                                                "${coupanList[index].price}",
                                                onPress: () {},
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                                  ),
                                ),
                              ],
                            )),
                      );
                    },
                  ),
                ),

                // SizedBox(height: 100,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<GetCooupann> coupanList = [];
  String? name, profile, email;

  getPref()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    name = pref.getString(Constant.NAME);
    profile = pref.getString(Constant.PROFILE);
    email = pref.getString(Constant.EMAIL);
  }

  Future<void> getCoupanApi() async {

    var headers = {
      'Cookie': 'ci_session=eb53ae9aeac2ce4fd80c41100b10abd26e4f8422'
    };
    var request = http.Request('GET', Uri.parse(ApiService.get_coupans));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();

      var finalrsult = GetCoupanModel.fromJson(jsonDecode(result));

      setState(() {
        coupanList = finalrsult.data ?? [];
        print('${coupanList.first.description}_______');
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  void showToast() {
    Fluttertoast.showToast(
        msg: "Already Sign In",
        toastLength: Toast.LENGTH_LONG,
        // gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: colors.primary,
        textColor: Colors.black);
  }

  int _currentPost = 0;

  List<Widget> _buildDots() {
    List<Widget> dots = [];
    if (false) {
    } else {
      for (int i = 0; i < 5; i++) {
        dots.add(
          Container(
            margin: EdgeInsets.all(1.5),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPost == i ? colors.secondary : colors.primary,
            ),
          ),
        );
      }
    }
    return dots;
  }

  getDrawer() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width / 1.3,
      child: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            height: 120,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [colors.primary, colors.secondary],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // main
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(profile ?? ''),

                  // NetworkImage(
                  //   "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?cs=srgb&dl=pexels-mohamed-abdelghaffar-771742.jpg&fm=jpg",
                  // ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children:  [
                    Text(
                      // "${firstname.toString()} ${middlename.toString()} ${lastname.toString()}",
                      name ?? '',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 150,
                      child: Text(
                        email ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 13),
                      ),
                    ),
                  ],
                ),
                /*InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Bottom_Bar(),
                          ));
                    },
                    child: Icon(
                      Icons.edit,
                      color: colors.whiteTemp,
                    ))*/
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  colors.white10,
                  colors.primary,
                ],
              ),
            ),
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: Image.asset(
                  "assets/images/home.png",
                  color: colors.black54,
                  scale: 1.3,
                  height: 40,
                  width: 40,
                ),
              ),
              title: Text(
                'Home',
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          ListTile(
            leading: const Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Icon(
                Icons.account_balance_wallet_outlined,
                size: 30,
                color: colors.black54,
              ),
            ),
            title: Text(
              'Wallet',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WalletScr()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/Term & Conditions.png",
              color: colors.black54,
              height: 40,
              width: 40,
            ),
            title: const Text(
              'Terms & Conditions',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TermsAndConditionView()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/drawer1.png",
              color: colors.black54,
              height: 40,
              width: 40,
            ),
            title: const Text(
              'About Us',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsView()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/Term & Conditions.png",
              height: 40,
              width: 40,
              color: colors.black54,
            ),
            title: Text(
              'Privecy Policy',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyView()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/Term & Conditions.png",
              height: 40,
              width: 40,
              color: colors.black54,
            ),
            title: const Text(
              'Support',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SupportScreen()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/Sign Out.png",
              color: colors.black54,
              height: 40,
              width: 40,
              //color: Colors.grey.withOpacity(0.8),
            ),
            title: const Text(
              'Sign Out',
            ),
            onTap: () async {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm Exit"),
                      content: const Text("Are you sure you want to exit?"),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: colors.secondary),
                          child: const Text("YES"),
                          onPressed: () async{
                            SharedPreferences pref = await SharedPreferences.getInstance();
                            pref.clear();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));

                          },
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: colors.secondary),
                          child: Text("NO"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}

class NewsCard {
  String? title;
  String? image;

  NewsCard({this.title, this.image});
}
