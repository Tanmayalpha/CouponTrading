import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../Api/api_services.dart';
import '../Color/Color.dart';


class HelpScr extends StatefulWidget {
  const HelpScr({Key? key}) : super(key: key);

  @override
  State<HelpScr> createState() => _HelpScrState();
}

class _HelpScrState extends State<HelpScr> {
  var hrlpp;
  @override
  void initState() {
    helpApi();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);},icon:Icon(Icons.arrow_back), color: colors.whiteTemp,),
        backgroundColor: colors.primary,
        centerTitle: true,
        title: Text("Help",style: TextStyle(color: colors.whiteTemp)),),
      body:hrlpp!=null ? SingleChildScrollView(
        child: Html(data: "${hrlpp}"),
      )
          : Container(child: Center(child: CircularProgressIndicator(color: colors.black54,)),),
    );
  }

  Future<void> helpApi() async {




    var headers = {
      'Cookie': 'CFID=12052; CFTOKEN=86ff74390ccf66f3-D15C5595-F060-B09C-BDA48E95B3243BA4'
    };
    var request = http.Request('GET', Uri.parse(ApiService.gethelp));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();

      // var finalresult = Helpmodel.fromJson(json.decode(result));
      setState(() {
        // hrlpp=finalresult.data;
      });
    }
    else {
      print(response.reasonPhrase);
    }


  }
}


