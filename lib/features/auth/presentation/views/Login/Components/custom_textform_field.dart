import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({super.key,required this.title,required this.onchange});
   Function(String) onchange;
  String title;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onchange,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.white)
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.white)
                    ),
                    
                    
                    labelText: title,
                    labelStyle: TextStyle(color: Colors.white)
                  ),
                  
                );
  }
}