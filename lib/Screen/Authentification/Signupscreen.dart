import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../Api/api_services.dart';
import '../../Color/Color.dart';
import '../../Custom Widget/AppBtn.dart';
import 'LoginScreen.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
  final _formKey = GlobalKey<FormState>();
  bool isLoading1 = false;
  bool _isObscure = true;
  bool _isObscuree = true;
  TextEditingController titlecontroller = TextEditingController();

  TextEditingController namecontroller = TextEditingController();
  TextEditingController middlenamecontroller = TextEditingController();

  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController dateofbirthcontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: colors.primary,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0.75),
                  child: Container(
                      height: MediaQuery.of(context).size.height / 5,
                      child: Image.asset(
                        "assets/images/splashlogo.png",
                        scale: 6.2,
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.2,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "SignUp",
                        style: TextStyle(
                            color: colors.blackTemp,
                            fontWeight: FontWeight.bold,
                            fontSize: 35),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 1.4,
                          child: SingleChildScrollView(
                            child: Column(children: [
                              // Card(
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(10)),
                              //   elevation: 4,
                              //   child: Container(
                              //     height: 60,
                              //     decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(15),
                              //         color: colors.whiteTemp),
                              //     child: Row(children: [
                              //
                              //       SizedBox(width: 15,),
                              //     Icon(Icons.person, color: colors.secondary),
                              //       SizedBox(width: 10,),
                              //
                              //
                              //       DropdownButtonHideUnderline(
                              //       child: DropdownButton(
                              //       hint: Text('Please choose a Title              ',style: TextStyle( color: colors.secondary),), // Not necessary for Option 1
                              //       value: _selectedtitle,
                              //       onChanged: (newValue) {
                              //         setState(() {
                              //           _selectedtitle = newValue;
                              //         });
                              //       },
                              //       items: _titlelists.map((location) {
                              //         return DropdownMenuItem(
                              //           child: new Text(location),
                              //           value: location,
                              //         );
                              //       }).toList(),
                              //   ),
                              //     ),
                              //
                              //     ]),
                              //
                              //
                              //   ),
                              // ),


                              SizedBox(
                                height: 10,
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
                                        hintText: "Enter Full Name",
                                        hintStyle:
                                            TextStyle(color: colors.secondary),
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
                              SizedBox(
                                height: 10,
                              ),
                              // Card(
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(10)),
                              //   elevation: 4,
                              //   child: Container(
                              //     height: 60,
                              //     decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(15),
                              //         color: colors.whiteTemp),
                              //     child: Center(
                              //       child: TextFormField(
                              //         controller: middlenamecontroller,
                              //         // obscureText: _isHidden ? true : false,
                              //         keyboardType: TextInputType.text,
                              //         validator: (msg) {
                              //           if (msg!.isEmpty) {
                              //             return "Please Fill This Field!";
                              //           }
                              //         },
                              //         maxLength: 40,
                              //         decoration: InputDecoration(
                              //           border: InputBorder.none,
                              //           counterText: "",
                              //           contentPadding: const EdgeInsets.only(
                              //               left: 15, top: 15),
                              //           hintText: "Enter Middle Name",
                              //           hintStyle:
                              //               TextStyle(color: colors.secondary),
                              //           prefixIcon: const Icon(
                              //             Icons.person,
                              //             color: colors.secondary,
                              //             size: 24,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              //
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // Card(
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(10)),
                              //   elevation: 4,
                              //   child: Container(
                              //     height: 60,
                              //     decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(15),
                              //         color: colors.whiteTemp),
                              //     child: Center(
                              //       child: TextFormField(
                              //         controller: lastnamecontroller,
                              //         // obscureText: _isHidden ? true : false,
                              //         keyboardType: TextInputType.text,
                              //         validator: (msg) {
                              //           if (msg!.isEmpty) {
                              //             return "Please Fill This Field!";
                              //           }
                              //         },
                              //         maxLength: 40,
                              //         decoration: InputDecoration(
                              //           border: InputBorder.none,
                              //           counterText: "",
                              //           contentPadding: const EdgeInsets.only(
                              //               left: 15, top: 15),
                              //           hintText: "Enter  Surname",
                              //           hintStyle:
                              //           TextStyle(color: colors.secondary),
                              //           prefixIcon: const Icon(
                              //             Icons.person,
                              //             color: colors.secondary,
                              //             size: 24,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // Card(
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(10)),
                              //   elevation: 4,
                              //   child: Container(
                              //     height: 60,
                              //     decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(15),
                              //         color: colors.whiteTemp),
                              //     child: Center(
                              //       child: TextFormField(
                              //         controller: dateofbirthcontroller,
                              //         keyboardType: TextInputType.text,
                              //         validator: (msg) {
                              //           if (msg!.isEmpty) {
                              //             return "Please Fill This Field!";
                              //           }
                              //         },
                              //         onTap: () async {
                              //           DateTime? pickedDate = await showDatePicker(
                              //               context: context,
                              //               initialDate: DateTime.now(),
                              //               firstDate: DateTime(1950),
                              //               lastDate: DateTime(2100),
                              //               builder: (context, child) {
                              //                 return Theme(
                              //                     data: Theme.of(context).copyWith(
                              //                         colorScheme: const ColorScheme.light(
                              //                           primary: Colors.grey,
                              //                         )),
                              //                     child: child!);
                              //               });
                              //
                              //           if (pickedDate != null) {
                              //             String formattedDate =
                              //             DateFormat('yyyy-MM-dd').format(pickedDate);
                              //             //formatted date output using intl package =>  2021-03-16
                              //             setState(() {
                              //               dateofbirthcontroller.text = formattedDate; //set output date to TextField value.
                              //
                              //             });
                              //
                              //           }
                              //         },
                              //         maxLength: 10,
                              //         decoration: InputDecoration(
                              //           border: InputBorder.none,
                              //           counterText: "",
                              //           contentPadding: const EdgeInsets.only(
                              //               left: 15, top: 15),
                              //           hintText: "Date Of Birth",
                              //           hintStyle:
                              //               TextStyle(color: colors.secondary),
                              //           prefixIcon:
                              //           IconButton(
                              //               onPressed: () async {
                              //
                              //                 DateTime? pickedDate = await showDatePicker(
                              //                     context: context,
                              //                     initialDate: DateTime.now(),
                              //                     firstDate: DateTime(1950),
                              //                     lastDate: DateTime(2100),
                              //                     builder: (context, child) {
                              //                       return Theme(
                              //                           data: Theme.of(context).copyWith(
                              //                               colorScheme: const ColorScheme.light(
                              //                                 primary: Colors.grey,
                              //                               )),
                              //                           child: child!);
                              //                     });
                              //
                              //                 if (pickedDate != null) {
                              //                   String formattedDate =
                              //                   DateFormat('yyyy-MM-dd').format(pickedDate);
                              //                   //formatted date output using intl package =>  2021-03-16
                              //                   setState(() {
                              //                     dateofbirthcontroller.text = formattedDate; //set output date to TextField value.
                              //
                              //                   });
                              //
                              //                 }
                              //               },
                              //               icon: const Icon(Icons.calendar_month_sharp,color: colors.secondary,)
                              //           ),
                              //
                              //
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),
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
                                      maxLength: 10,
                                      controller: numbercontroller,
                                      // obscureText: _isHidden ? true : false,
                                      keyboardType: TextInputType.number,
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return "Please Enter Mobile Number!";
                                        } else {
                                          if (v.length < 10) {
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
                                        hintText: "Enter Mobile Number",
                                        hintStyle:
                                            TextStyle(color: colors.secondary),
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
                              SizedBox(
                                height: 10,
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
                                      maxLength: 40,
                                      controller: emailcontroller,
                                      // obscureText: _isHidden ? true : false,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return "Email is required";
                                        }
                                        if (!v.contains(
                                          "@",
                                        )) {
                                          return "Enter Valid Email Id";
                                        } else {
                                          if (!v.contains(
                                            ".com",
                                          )) {
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
                                        hintText: "Enter email Id",
                                        hintStyle:
                                            TextStyle(color: colors.secondary),
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
                              SizedBox(
                                height: 10,
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
                                      obscureText: _isObscure,
                                      controller: passwordcontroller,
                                      // obscureText: _isHidden ? true : false,
                                      keyboardType: TextInputType.text,
                                      validator: (msg) {
                                        if (msg!.isEmpty) {
                                          return "Please Enter Password!";
                                        }
                                      },
                                      // maxLength: 10,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          counterText: "",
                                          contentPadding: const EdgeInsets.only(
                                              left: 15, top: 15),
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              color: colors.secondary),
                                          prefixIcon: const Icon(
                                            Icons.lock,
                                            color: colors.secondary,
                                            size: 24,
                                          ),
                                          suffixIcon: IconButton(
                                              icon: Icon(
                                                _isObscure
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: colors.secondary,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _isObscure = !_isObscure;
                                                });
                                              })),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
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
                                      obscureText: _isObscuree,
                                      controller: confirmpasswordcontroller,
                                      // obscureText: _isHidden ? true : false,
                                      keyboardType: TextInputType.text,
                                      validator: (msg) {
                                        if (msg!.isEmpty) {
                                          return "Please Enter Valid Password!";
                                        } else {
                                          if (msg != passwordcontroller.text)
                                            return "Your Password is not matched";
                                        }
                                      },
                                      // maxLength: 10,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          counterText: "",
                                          contentPadding: const EdgeInsets.only(
                                              left: 15, top: 15),
                                          hintText: "Confirm Password",
                                          hintStyle: TextStyle(
                                              color: colors.secondary),
                                          prefixIcon: const Icon(
                                            Icons.lock,
                                            color: colors.secondary,
                                            size: 24,
                                          ),
                                          suffixIcon: IconButton(
                                              icon: Icon(
                                                _isObscuree
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: colors.secondary,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _isObscuree = !_isObscuree;
                                                });
                                              })),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('I Accept ',style: TextStyle(fontSize: 10),),
                              Text('Terms of Use ',style: TextStyle(fontSize: 10, decoration: TextDecoration.underline, ),),
                              Text('And ',style: TextStyle(fontSize: 10),),
                              Text('Privacy Policy',style: TextStyle(fontSize: 10, decoration: TextDecoration.underline,),),


                            ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Btn(
                                height: 50,
                                width: 320,
                                title: isLoading1 == true
                                    ? "Please wait......"
                                    : 'Sign Up',
                                onPress: () {
                                  setState(() {
                                    isLoading1 = true;
                                  });
                                  if (_formKey.currentState!.validate()) {




                                       signupapi();




                                  } else {
                                    setState(() {
                                      isLoading1 = false;
                                    });
                                    Fluttertoast.showToast(
                                        msg:
                                            "Please Enter Correct Credentials!!");
                                  }
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                        color: colors.blackTemp,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        /*Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));*/
                                      },
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Login",
                                            style: TextStyle(
                                                color: colors.secondary,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          )))



                                ],
                              ),


                             SizedBox(
                                height: 100,
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> signupapi() async {
    var headers = {
      'Cookie': 'ci_session=a642d39c9808e567ed13c1f7217675ffc914716b'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiService.register_user));
    request.fields.addAll({
      'mobile': numbercontroller.text,
      'password': passwordcontroller.text,
      'name': namecontroller.text,
      'email': emailcontroller.text,
      'country_code': '+91'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();


    if (response.statusCode == 200) {

       var result = await response.stream.bytesToString();
       var finalrsult = jsonDecode(result);

       if(finalrsult['error']==true){


         showToast(finalrsult['message']);



       }else{


         showToast(finalrsult['message']);
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
       }

    }
    else {
      print(response.reasonPhrase);
    }

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

  void showToastt() {
    Fluttertoast.showToast(
        msg: "Please Select Country Code ",
        toastLength: Toast.LENGTH_LONG,
        // gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black);
  }
}
