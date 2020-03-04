import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {

  final String text;
  final double size;
  final TextAlign align;

  const CustomText({Key key, this.text, this.size, this.align=TextAlign.center}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
//        fontWeight: FontWeight.bold,
        fontSize: size,
      ),
      textAlign: align,
    );
  }
}
