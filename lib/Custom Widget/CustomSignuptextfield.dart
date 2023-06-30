import 'package:flutter/material.dart';

import '../Color/Color.dart';

class CustomTextFormField extends StatefulWidget {

  final bool? obsecureText;
  final TextEditingController? fieldcontroller;
  final TextInputType? keyboardType;
  final String? hint;
  final int? length;
  final String? validatorr;
  final Icon? icons;





  const CustomTextFormField({Key? key, this.obsecureText, this.fieldcontroller, this.keyboardType, this.hint, this.length, this.validatorr, this.icons}) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
 
  @override
  Widget build(BuildContext context) {
    return  Card(
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color:colors.whiteTemp ),
        child: Center(
          child: TextFormField(
            maxLength: widget.length,

            controller: widget.fieldcontroller,
            keyboardType: widget.keyboardType,
            validator: (msg) {
              if (msg!.isEmpty) {
                return widget.validatorr;
              }
            },
            // maxLength: 10,
            decoration: InputDecoration(
                border: InputBorder.none,
                counterText: "",
                contentPadding: const EdgeInsets.only(
                    left: 15, top: 15),
                hintText: widget.hint,
                hintStyle: TextStyle(color: colors.secondary),


            ),
          ),
        ),
      ),
    );
  }
}


