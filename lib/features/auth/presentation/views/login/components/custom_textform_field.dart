import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({super.key,required this.title,required this.onchange});
   Function(String) onchange;
  String title;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onchange,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.white)
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.white)
                    ),
                    
                    
                    labelText: title,
                    labelStyle: const TextStyle(color: Colors.white)
                  ),
                  
                );
  }
}