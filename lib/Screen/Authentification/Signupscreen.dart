import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../Api/api_services.dart';
import '../../Color/Color.dart';
import '../../Custom Widget/AppBtn.dart';
import '../../Custom Widget/gradient_button.dart';
import 'LoginScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key,this.mobile}) : super(key: key);
  final String? mobile ;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

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

  TextEditingController adharController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numbercontroller.text = widget.mobile ?? '' ;
  }

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
                      padding: const EdgeInsets.only(top: 40),
                      child: SizedBox(
                          height: 130,
                          width: 100,
                          child: Image.asset(
                            "assets/images/klinTradeLogo.png",
                            scale: 6.2,
                          )),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "SignUp",
                            style: TextStyle(
                                color: colors.blackTemp,
                                fontWeight: FontWeight.bold,
                                fontSize: 35),
                          ),
                          const SizedBox(
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

                                  const SizedBox(
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
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            counterText: "",
                                            contentPadding: EdgeInsets.only(
                                                left: 15, top: 15),
                                            hintText: "Enter Full Name",
                                            hintStyle:
                                            TextStyle(color: colors.secondary),
                                            prefixIcon: Icon(
                                              Icons.person,
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
                                          readOnly: true,
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
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            counterText: "",
                                            contentPadding: EdgeInsets.only(
                                                left: 15, top: 15),
                                            hintText: "Enter Mobile Number",
                                            hintStyle:
                                            TextStyle(color: colors.secondary),
                                            prefixIcon: Icon(
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
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            counterText: "",
                                            contentPadding: EdgeInsets.only(
                                                left: 15, top: 15),
                                            hintText: "Enter email Id",
                                            hintStyle:
                                            TextStyle(color: colors.secondary),
                                            prefixIcon: Icon(
                                              Icons.email,
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
                                          controller: accountNoController,
                                          // obscureText: _isHidden ? true : false,
                                          keyboardType: TextInputType.text,
                                          validator: (msg) {
                                            if (msg!.isEmpty) {
                                              return "Please Fill This Field!";
                                            }
                                          },
                                          maxLength: 40,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            counterText: "",
                                            contentPadding: EdgeInsets.only(
                                                left: 15, top: 15),
                                            hintText: "Account No.",
                                            hintStyle:
                                            TextStyle(color: colors.secondary),
                                            prefixIcon: Icon(
                                              Icons.account_balance,
                                              color: colors.secondary,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
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
                                          controller: accountNameController,
                                          // obscureText: _isHidden ? true : false,
                                          keyboardType: TextInputType.text,
                                          validator: (msg) {
                                            if (msg!.isEmpty) {
                                              return "Please Fill This Field!";
                                            }
                                          },
                                          maxLength: 40,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            counterText: "",
                                            contentPadding: EdgeInsets.only(
                                                left: 15, top: 15),
                                            hintText: "Acount Name",
                                            hintStyle:
                                            TextStyle(color: colors.secondary),
                                            prefixIcon: Icon(
                                              Icons.person,
                                              color: colors.secondary,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
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
                                          controller: ifscController,
                                          // obscureText: _isHidden ? true : false,
                                          keyboardType: TextInputType.text,
                                          validator: (msg) {
                                            if (msg!.isEmpty) {
                                              return "Please Fill This Field!";
                                            }
                                          },
                                          maxLength: 40,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            counterText: "",
                                            contentPadding: EdgeInsets.only(
                                                left: 15, top: 15),
                                            hintText: "IFSC",
                                            hintStyle:
                                            TextStyle(color: colors.secondary),
                                            prefixIcon: Icon(
                                              Icons.account_balance,
                                              color: colors.secondary,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
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
                                          controller: bankNameController,
                                          // obscureText: _isHidden ? true : false,
                                          keyboardType: TextInputType.text,
                                          validator: (msg) {
                                            if (msg!.isEmpty) {
                                              return "Please Fill This Field!";
                                            }
                                          },
                                          maxLength: 40,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            counterText: "",
                                            contentPadding: EdgeInsets.only(
                                                left: 15, top: 15),
                                            hintText: "Bank Name",
                                            hintStyle:
                                            TextStyle(color: colors.secondary),
                                            prefixIcon: Icon(
                                              Icons.account_balance,
                                              color: colors.secondary,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
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
                                          controller: adharController,
                                          // obscureText: _isHidden ? true : false,
                                          keyboardType: TextInputType.number,
                                          validator: (v) {
                                            if (v!.length !=12) {
                                              return "Enter valid Adhar no";
                                            }
                                          },
                                          // maxLength: 10,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            counterText: "",
                                            contentPadding: EdgeInsets.only(
                                                left: 15, top: 15),
                                            hintText: "Aadhar No.",
                                            hintStyle:
                                            TextStyle(color: colors.secondary),
                                            prefixIcon: Icon(
                                              Icons.credit_card_rounded,
                                              color: colors.secondary,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
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
                                          controller: panController,
                                          // obscureText: _isHidden ? true : false,
                                          keyboardType: TextInputType.emailAddress,
                                          validator: (v) {
                                            if (v!.isEmpty) {
                                              return "PAN is required";
                                            }
                                          },
                                          // maxLength: 10,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            counterText: "",
                                            contentPadding: EdgeInsets.only(
                                                left: 15, top: 15),
                                            hintText: "PAN No",
                                            hintStyle:
                                            TextStyle(color: colors.secondary),
                                            prefixIcon: Icon(
                                              Icons.credit_card_rounded,
                                              color: colors.secondary,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
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
                                              hintStyle: const TextStyle(
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

                                  const SizedBox(
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
                                              hintStyle: const TextStyle(
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
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '  *I Accept ',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      Text(
                                        'Terms of Use ',
                                        style: TextStyle(
                                          fontSize: 10,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      Text(
                                        'And ',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      Text(
                                        'Privacy Policy',
                                        style: TextStyle(
                                          fontSize: 10,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  AppButton(width: double.maxFinite,title: isLoading1? 'Please wait...': 'Sign Up',onTab: isLoading1 ? null : (){
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

                                  },height: 50,),
                              /*    Btn(
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
                                  ),*/
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
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
                                              child: const Text(
                                                "Login",
                                                style: TextStyle(
                                                    color: colors.secondary,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold),
                                              )))
                                    ],
                                  ),

                                  const SizedBox(
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
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiService.register_user));
    request.fields.addAll({
      'mobile': numbercontroller.text,
      'password': passwordcontroller.text,
      'name': namecontroller.text,
      'email': emailcontroller.text,
      'country_code': '+91',
      'dob':'',
      'adharno': adharController.text ,
      'panno':panController.text,
      'account_no':accountNoController.text,
      'account_name': accountNameController.text,
      'ifsc_code':ifscController.text,
      'bank_name':bankNameController.text
    });

    /* request.files.add(await http.MultipartFile.fromPath(
        'user_image', imageFile?.path ?? ''));*/

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalrsult = jsonDecode(result);

      if (finalrsult['error'] == true) {
        showToast(finalrsult['message']);
      } else {
        showToast(finalrsult['message']);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
      }
    } else {
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
