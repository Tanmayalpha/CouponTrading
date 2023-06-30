import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Color/Color.dart';


import '../Api/api_services.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
class UseFullLink extends StatefulWidget {
  const UseFullLink({Key? key}) : super(key: key);

  @override
  State<UseFullLink> createState() => _UseFullLinkState();
}

class _UseFullLinkState extends State<UseFullLink> {

  var finalresult;

  var facebookk;
  var whatsapp;
  var instagramm;
  var youtubee;
  var twitterr;
  var websitee;
@override
  void initState() {
    // TODO: implement initState
    super.initState();

    socialMediaUsApi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      body:

      facebookk!=null?

      Column(children: [

        Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          color: colors.primary,
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
                  SizedBox(width: MediaQuery.of(context).size.width/4,),
                  Text(
                    'UseFull Links',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: colors.whiteTemp),
                  ),
                ],
              )),



        ),
SizedBox(height: 30,),
        Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Column(children: [

            Row(
              children: [


                SizedBox(width: 5,),

                Container(height: 25,width: 25,

                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5)
                  ,image: DecorationImage(image: AssetImage('assets/images/fb.png'))),
                 ),
                SizedBox(width: 5,),


                Text("Facebook", style: TextStyle(
                    color: colors.black54, fontWeight: FontWeight.bold),),
              ],
            ),

            Card(child: Container(width: MediaQuery.of(context).size.width,child: Row(
              children: [
                InkWell(

                  onTap: () {
                    launch(facebookk);
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width/1.15,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(facebookk, style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ],
            ),
                ),),


            SizedBox(height: 15,),
            Row(
              children: [

                SizedBox(width: 5,),

                Container(height: 25,width: 25,

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5)
                      ,image: DecorationImage(image: AssetImage('assets/images/insta.png'))),
                ),
                SizedBox(width: 5,),
                Text( "Instagram", style: TextStyle(
                    color: colors.black54, fontWeight: FontWeight.bold),),
              ],
            ),

            Card(child: Container(width: MediaQuery.of(context).size.width,child: Row(
              children: [
                InkWell(

                  onTap: () {
                    launch(instagramm);
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width/1.15,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(instagramm, style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ],
            ),
            ),),


            SizedBox(height: 15,),

            Row(
              children: [

                SizedBox(width: 5,),

                Container(height: 25,width: 25,

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5)
                      ,image: DecorationImage(image: AssetImage('assets/images/whatsapp.png'))),
                ),

                SizedBox(width: 5,),
                Text(   "Whatsapp", style: TextStyle(
                    color: colors.black54, fontWeight: FontWeight.bold),),
              ],
            ),

            Card(child: Container(width: MediaQuery.of(context).size.width,child: Row(
              children: [
                InkWell(

                  onTap: () {
                    launch(whatsapp);
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width/1.15,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(whatsapp, style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ],
            ),
            ),),


            SizedBox(height: 15,),


            Row(
              children: [

                SizedBox(width: 5,),

                Container(height: 25,width: 25,

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5)
                      ,image: DecorationImage(image: AssetImage('assets/images/youtube.png'))),
                ),

                SizedBox(width: 5,),
                Text(  "Youtube", style: TextStyle(
                    color: colors.black54, fontWeight: FontWeight.bold),),
              ],
            ),

            Card(child: Container(width: MediaQuery.of(context).size.width,child: Row(
              children: [
                InkWell(

                  onTap: () {
                    launch(youtubee);
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width/1.15,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(youtubee, style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ],
            ),
            ),),


            SizedBox(height: 15,),


            Row(
              children: [

                SizedBox(width: 5,),

                Container(height: 25,width: 25,

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5)
                      ,image: DecorationImage(image: AssetImage('assets/images/twitter.png'))),
                ),

                SizedBox(width: 5,),
                Text( "Twitter", style: TextStyle(
                    color: colors.black54, fontWeight: FontWeight.bold),),
              ],
            ),

            Card(child: Container(width: MediaQuery.of(context).size.width,child: Row(
              children: [
                InkWell(

                  onTap: () {
                    launch(twitterr);
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width/1.15,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(twitterr, style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ],
            ),
            ),),


            SizedBox(height: 15,),

            Row(
              children: [

                SizedBox(width: 5,),

                Container(height: 25,width: 25,

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5)
                      ,image: DecorationImage(image: AssetImage('assets/images/web.png'))),
                ),

                SizedBox(width: 5,),
                Text( "Website", style: TextStyle(
                    color: colors.black54, fontWeight: FontWeight.bold),),
              ],
            ),

            Card(child: Container(width: MediaQuery.of(context).size.width,child: Row(
              children: [
                InkWell(

                  onTap: () {
                    launch(websitee);
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width/1.15,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(websitee, style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ],
            ),
            ),),


            SizedBox(height: 15,),




          ],),
        )
      ],)





     :Container(child: Center(
    child: CircularProgressIndicator(color: colors.black54,)),),
    )




    );
  }




  socialMediaUsApi() async {
    var headers = {
      'Cookie': 'CFID=12052; CFTOKEN=86ff74390ccf66f3-D15C5595-F060-B09C-BDA48E95B3243BA4'
    };
    var request = http.Request('GET', Uri.parse(ApiService.socialmedia));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print(result);
      //finalresult = Contactusmodel.fromJson(json.decode(result));
      finalresult= jsonDecode(result);


      facebookk = finalresult['data']["facebook"];
      instagramm=finalresult['data']["instagram"];
      whatsapp=finalresult['data']["whatsapp"];
      youtubee=finalresult['data']["youtube"];
      twitterr=finalresult['data']["twitter"];
      websitee=finalresult['data']["website"];

      setState(() {

      });




    }
    else {
      print(response.reasonPhrase);
    }
  }
}



