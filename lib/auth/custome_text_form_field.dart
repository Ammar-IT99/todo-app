import 'package:flutter/material.dart';
import '../my_theme.dart';

class CustomTextFormField extends StatelessWidget{
 final String label;
 final TextInputType keyboardType;
 final TextEditingController controller;
 final String? Function(String?) validator;
 final bool obscureText;
  const CustomTextFormField({super.key, required this.label,this.keyboardType=TextInputType.text,required this.controller,required this.validator,this.obscureText=false});

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