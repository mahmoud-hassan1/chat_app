import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String message,{Color color = Colors.red}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),backgroundColor: color,));
}

