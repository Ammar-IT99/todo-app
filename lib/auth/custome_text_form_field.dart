import 'package:flutter/material.dart';
import 'package:todo_app/My_Theme.dart';

class CustomTextFormField extends StatelessWidget{
  String label;
  TextInputType keyboardType;
  TextEditingController controller;
  String? Function(String?) validator;
  bool obscureText;
  CustomTextFormField({super.key, required this.label,this.keyboardType=TextInputType.text,required this.controller,required this.validator,this.obscureText=false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText:label ,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: MyTheme.primaryColor,
              width: 2

            ),
          ),
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                color: MyTheme.redColor,
                width: 2

            ),
          ),
     errorBorder: OutlineInputBorder(
       borderRadius: BorderRadius.circular(15),
       borderSide: BorderSide(
           color: MyTheme.primaryColor,
           width: 2

       ),
     ),
        ),
        keyboardType: keyboardType,
        controller:controller ,
        validator: validator,
        obscureText: obscureText,
      ),
    );
  }

}