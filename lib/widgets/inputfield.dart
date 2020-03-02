import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final textStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: Color(0xff9E9E9E),
);

class InputField extends StatelessWidget {

  final String hint;
  final TextInputType type;
  final bool ispassword;
  final IconData prefix;
  final TextEditingController controller;

  const InputField({Key key, this.hint, this.type, this.ispassword=false, this.controller, this.prefix}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextField(
        style: textStyle,
        cursorColor: Color(0xff9E9E9E),
        keyboardType: type,
        controller: controller,
        obscureText: ispassword,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: textStyle,
          prefixIcon: prefix!=null?Icon(prefix,color: Colors.black,):null,
          enabledBorder:UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(10)
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 5),
              borderRadius: BorderRadius.circular(10)
          ),

        ),
      ),
    );
  }
}