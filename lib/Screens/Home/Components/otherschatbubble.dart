import 'package:chat_app/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OthersChatBubble extends StatelessWidget {
 OthersChatBubble({
    super.key,
    required this.text
  });
  String text;
  @override
  Widget build(BuildContext context) {
    return Align(
    alignment: Alignment.centerRight,
      child: Container(
      
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 25.h),
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
        decoration: BoxDecoration(
            color: Colors.lightBlue,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.r),bottomRight: Radius.zero,topLeft: Radius.circular(25.r),topRight: Radius.circular(25.r))
        ),
        child: Text(
          text,
          style: TextStyle(
            color:Colors.white,
            fontSize: 13.5.sp
             ),
        ),
        ),
    );
  }
}