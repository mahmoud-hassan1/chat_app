import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({super.key,required this.title,required this.width,required this.height,required this.onTap});
  VoidCallback onTap;
  String title;
  double width,height;
  @override
  Widget build(BuildContext context) {
    return  Padding(
                padding: EdgeInsets.symmetric(horizontal: .02*width),
                child: ElevatedButton(onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(double.infinity, .07*height),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                 child: Text(
                  title,
                  style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.sp
                  ),
                  
                ),
                
                 ),
              );
  }
}