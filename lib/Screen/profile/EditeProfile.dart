import 'dart:io';



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../Color/Color.dart';
import '../../Custom Widget/AppBtn.dart';




class EditeProfile extends StatefulWidget {
  const EditeProfile({Key? key, }) : super(key: key);

  @override
  State<EditeProfile> createState() => _EditeProfileState();
}

class _EditeProfileState extends State<EditeProfile> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController societycontroller =TextEditingController();
  TextEditingController namecontroller =TextEditingController();
  TextEditingController middlenamecontroller =TextEditingController();
  TextEditingController lastnamecontroller =TextEditingController();
  TextEditingController dateofbirthcontroller =TextEditingController();
  TextEditingController numbercontroller =TextEditingController();

  TextEditingController emailcontroller =TextEditingController();
  TextEditingController adharcontroller =TextEditingController();
  TextEditingController pancontroller = TextEditingController();
  TextEditingController wimgcontroller = TextEditingController();
  TextEditingController floorcontroller= TextEditingController();
  TextEditingController unittypecontoller = TextEditingController();
  TextEditingController unitnumberconroller = TextEditingController();

  TextEditingController unitareacontroller =TextEditingController();


  List<String> _titlelists = [


    'Dr.',
    'Esq.',
    'Hon.',
    'Jr.',
    'Mr.',
    'Mrs.',
    'Ms.',
    'Messrs.',

  ];

  var _selectedtitle;


  File? imageFile;
  File? registrationImage;
  final ImagePicker _picker = ImagePicker();
  bool? isFromProfile ;
  String? image;
  bool  isLodding = false;

  String? selectedState;
  String? selectedCity;
  String? selectedPlace;
  String? titleSelected;


  var stateselected;
  var cityselected;
  var placeselected;
  var selectedTitle;

  String? stateId;
  String?cityId;
  String?placeId;
  int? selectedSateIndex;





  Future<bool> showExitPopup() async {
    return await showDialog(

      context: context,
      builder: (context) => AlertDialog(
          title: Text('Select Image'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: colors.secondary),

                onPressed: () {
                  _getFromCamera();
                },
                child: Text('Camera'),
              ),

SizedBox(width: 30,),

              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: colors.secondary),
                child: Text("Gallery"),
                onPressed: () {
                  _getFromGallery();                },


              ),

            ],
          )),
    ) ??
        false; //if showDialouge had returned null, then return false
  }

  _getFromCamera() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    /*  PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );*/
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }


  _getFromGallery() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    /* PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );*/
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      print("imaggggg ${imageFile}");
      Navigator.pop(context);
    }
  }


  @override
  void initState() {

    image = '';






  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:<Widget>[

              Container(
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
                child: Row(
                  children: [


                    SizedBox(width: MediaQuery.of(context).size.width/2.5,),
                    Text(
                      'Profile',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: colors.whiteTemp),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Stack(
                  children:[
                    imageFile == null
                        ?  SizedBox(
                      height: 110,
                      width: 110,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        elevation: 5,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(image!, fit: BoxFit.fill,)
                          // Image.file(imageFile!,fit: BoxFit.fill,),
                        ),
                      ),
                    ) :

                    Container(
                      height: 150,
                      width: 150,
                      child: ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(75),
                          child: Image.file(imageFile ?? File(''),fit: BoxFit.fill)
                        // Image.file(imageFile!,fit: BoxFit.fill,),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        // top: 30,
                        child: InkWell(
                          onTap: (){
                            isFromProfile = true ;
                           // requestPermission(context, 1);
                            showExitPopup();
                          },
                          child: Container(
                              height: 30,width: 30,
                              decoration: BoxDecoration(
                                  color: colors.secondary,
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: Icon(Icons.camera_enhance_outlined,color: Colors.white,)),
                        ))
                  ]
              ),




              SizedBox(height: 10,),

              Container(
                height: MediaQuery.of(context).size.height/1.8,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text("Title", style: TextStyle(
                                color: colors.black54, fontWeight: FontWeight.bold),),
                          ),
                          SizedBox(height: 2,),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 4,
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: colors.whiteTemp),
                              child: Row(children: [

                                SizedBox(width: 15,),
                                Icon(Icons.person,color: colors.secondary,),
                                SizedBox(width: 10,),


                                DropdownButtonHideUnderline(
                                  child: DropdownButton(

                                    hint: Text('Please choose a Title                ',style: TextStyle(color: colors.secondary)), // Not necessary for Option 1
                                    value:

                                    _selectedtitle,
                                    onChanged: (newValue) {

                                      setState(() {
                                        _selectedtitle = newValue;
                                      });
                                    },
                                    items: _titlelists.map((location) {
                                      return DropdownMenuItem(
                                        child: new Text(location),
                                        value: location,
                                      );
                                    }).toList(),
                                  ),
                                ),

                              ]),


                            ),
                          ),


                          SizedBox(height: 10,),
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text("First Name", style: TextStyle(
                                color: colors.black54, fontWeight: FontWeight.bold),),
                          ),
                          SizedBox(height: 2,),
                          Card(
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 4,
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:colors.whiteTemp ),
                              child: Center(
                                child: TextFormField(

                                  controller: namecontroller,
                                  // obscureText: _isHidden ? true : false,
                                  keyboardType: TextInputType.text,
                                  validator: (msg) {
                                    if (msg!.isEmpty) {
                                      return "Please Fill This Field!";
                                    }
                                  },
                                  maxLength: 40,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    counterText: "",
                                    contentPadding: const EdgeInsets.only(
                                        left: 15, top: 15),
                                    hintText: "Enter First Name",hintStyle: TextStyle(color: colors.secondary),
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: colors.secondary,
                                      size: 24,

                                    ),

                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("Middle Name", style: TextStyle(
                                color: colors.black54, fontWeight: FontWeight.bold),),
                          ),
                          SizedBox(height: 2,),
                          Card(
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 4,
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:colors.whiteTemp ),
                              child: Center(
                                child: TextFormField(

                                  controller:middlenamecontroller,
                                  // obscureText: _isHidden ? true : false,
                                  keyboardType: TextInputType.text,
                                  validator: (msg) {
                                    if (msg!.isEmpty) {
                                      return "Please Fill This Field!";
                                    }
                                  },
                                  maxLength: 40,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    counterText: "",
                                    contentPadding: const EdgeInsets.only(
                                        left: 15, top: 15),
                                    hintText: "Enter Middle Name",hintStyle: TextStyle(color: colors.secondary),
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: colors.secondary,
                                      size: 24,

                                    ),

                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("Last Name", style: TextStyle(
                                color: colors.black54, fontWeight: FontWeight.bold),),
                          ),
                          SizedBox(height: 2,),
                          Card(
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 4,
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:colors.whiteTemp ),
                              child: Center(
                                child: TextFormField(

                                  controller:lastnamecontroller,
                                  // obscureText: _isHidden ? true : false,
                                  keyboardType: TextInputType.text,
                                  validator: (msg) {
                                    if (msg!.isEmpty) {
                                      return "Please Fill This Field!";
                                    }
                                  },
                                  maxLength: 40,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    counterText: "",
                                    contentPadding: const EdgeInsets.only(
                                        left: 15, top: 15),
                                    hintText: "Enter Last Name",hintStyle: TextStyle(color: colors.secondary),
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: colors.secondary,
                                      size: 24,

                                    ),

                                  ),
                                ),
                              ),
                            ),
                          ),




                          const SizedBox(height: 10,),
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text("Date Of Birth", style: TextStyle(
                                color: colors.black54, fontWeight: FontWeight.bold),),
                          ),
                          const SizedBox(height: 2,),
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
                                  controller: dateofbirthcontroller,
                                  keyboardType: TextInputType.text,
                                  validator: (msg) {
                                    if (msg!.isEmpty) {
                                      return "Please Fill This Field!";
                                    }
                                  },

                                  onTap:() async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime(2100),
                                        builder: (context, child) {
                                          return Theme(
                                              data: Theme.of(context).copyWith(
                                                  colorScheme: const ColorScheme.light(
                                                    primary: Colors.grey,
                                                  )),
                                              child: child!);
                                        });

                                    if (pickedDate != null) {
                                      String formattedDate =
                                      DateFormat('yyyy-MM-dd').format(pickedDate);
                                      //formatted date output using intl package =>  2021-03-16
                                      setState(() {
                                        dateofbirthcontroller.text = formattedDate; //set output date to TextField value.

                                      });

                                    }
                                  },
                                  readOnly: true,
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    counterText: "",
                                    contentPadding: const EdgeInsets.only(
                                        left: 15, top: 15),
                                    hintText: "Date Of Birth",
                                    hintStyle:
                                    TextStyle(color: colors.secondary),
                                    prefixIcon:
                                    IconButton(
                                        onPressed: () async {

                                          DateTime? pickedDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1950),
                                              lastDate: DateTime(2100),
                                              builder: (context, child) {
                                                return Theme(
                                                    data: Theme.of(context).copyWith(
                                                        colorScheme: const ColorScheme.light(
                                                          primary: Colors.grey,
                                                        )),
                                                    child: child!);
                                              });

                                          if (pickedDate != null) {
                                            String formattedDate =
                                            DateFormat('yyyy-MM-dd').format(pickedDate);
                                            //formatted date output using intl package =>  2021-03-16
                                            setState(() {
                                              dateofbirthcontroller.text = formattedDate; //set output date to TextField value.

                                            });

                                          }
                                        },
                                        icon: const Icon(Icons.calendar_month_sharp,color: colors.secondary,)
                                    ),


                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),

                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text("Mobile Number", style: TextStyle(
                                color: colors.black54, fontWeight: FontWeight.bold),),
                          ),
                          const SizedBox(height: 2,),
                          Card(
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 4,
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:colors.whiteTemp ),
                              child: Center(
                                child: TextFormField(
                                  maxLength: 10,
                                  controller: numbercontroller,
                                  // obscureText: _isHidden ? true : false,
                                  keyboardType: TextInputType.number,
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return "Please Enter Mobile Number!";
                                    }
                                    else{
                                      if(v.length<10)
                                        {
                                          return "Please Enter vailed Mobile Number!";

                                        }
                                    }
                                  },
                                  // maxLength: 10,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    counterText: "",
                                    contentPadding: const EdgeInsets.only(
                                        left: 15, top: 15),
                                    hintText: "Enter Mobile Number",hintStyle: TextStyle(color: colors.secondary),
                                    prefixIcon: const Icon(
                                      Icons.call,
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




                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text("Email ID", style: TextStyle(
                                color: colors.black54, fontWeight: FontWeight.bold),),
                          ),
                          const SizedBox(height: 2,),
                          Card(
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 4,
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:colors.whiteTemp ),
                              child: Center(
                                child: TextFormField(
                                  maxLength: 40,
                                  controller: emailcontroller,
                                  // obscureText: _isHidden ? true : false,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return "Email is required";
                                    }
                                    if (!v.contains("@",)) {
                                      return "Enter Valid Email Id";
                                    }else{
                                      if (!v.contains(".com",)) {
                                        return "Enter Valid Email Id";
                                      }

                                    }
                                  },
                                  // maxLength: 10,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    counterText: "",
                                    contentPadding: const EdgeInsets.only(
                                        left: 15, top: 15),
                                    hintText: "Enter email Id",hintStyle: TextStyle(color: colors.secondary),
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: colors.secondary,
                                      size: 24,

                                    ),

                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),


                          Center(
                            child: Btn(
                              title: "Update",
                              height: 50,
                              width: 320,

                              onPress: () {

                              },
                            ),
                          ),

                          SizedBox(height: 70,),

                        ],
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );

  }




  Future<void> _displayPickImageDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add optional parameters'),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('PICK'),
                  onPressed: () {

                  }),
            ],
          );
        });
  }




}





