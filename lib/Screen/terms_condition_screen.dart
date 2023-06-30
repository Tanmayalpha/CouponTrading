import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

import '../Api/api_services.dart';
import '../Color/Color.dart';


class TermsAndConditionView extends StatefulWidget {
  const TermsAndConditionView({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionView> createState() => _TermsAndConditionViewState();
}

class _TermsAndConditionViewState extends State<TermsAndConditionView> {

  var termsconditionn;
  @override
  void initState() {
    termsApi();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body:Column(
          children: [


            Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
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
                      SizedBox(width: MediaQuery.of(context).size.width/5.8,),
                      Text(
                        'Terms & Conditions',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: colors.whiteTemp),
                      ),
                    ],
                  )),
            ),
            SizedBox(height: 30,),



            termsconditionn!=null? SingleChildScrollView(child: Html(data: "${termsconditionn}"))
                : Container(child: Center(child: CircularProgressIndicator(color: colors.black54,)),),
          ],
        ),
      ),
    );
  }




  Future<void> termsApi() async {




    var headers = {
      'Cookie': 'CFID=12052; CFTOKEN=86ff74390ccf66f3-D15C5595-F060-B09C-BDA48E95B3243BA4'
    };
    var request = http.Request('GET', Uri.parse(ApiService.termsAndCondition));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();

      // var finalresult = Termsconditionmodel.fromJson(json.decode(result));
      setState(() {
        // termsconditionn=finalresult.data;
      });
    }
    else {
      print(response.reasonPhrase);
    }


  }
}
