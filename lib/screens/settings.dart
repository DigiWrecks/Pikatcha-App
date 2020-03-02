import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikatcha/widgets/button.dart';
import 'package:pikatcha/widgets/custom-text.dart';
import 'package:pikatcha/widgets/inputfield.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings',style: TextStyle(fontWeight: FontWeight.bold),),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(width: double.infinity,),
          CustomText(text: 'Change Address',size: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: InputField(hint: '',),
          ),

          SizedBox(height: 20,),
          CustomText(text: 'Change Email',size: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: InputField(hint: '',type: TextInputType.emailAddress,),
          ),


          SizedBox(height: 20,),
          CustomText(text: 'Change Phone Number',size: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: InputField(hint: '',type: TextInputType.phone,),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(30,80,30,0),
            child: Button(text: 'Submit',onclick: (){},),
          ),


        ],
      ),
    );
  }
}
