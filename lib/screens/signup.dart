import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikatcha/widgets/button.dart';
import 'package:pikatcha/widgets/inputfield.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Create an Account',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: InputField(hint: 'Email',type: TextInputType.emailAddress,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: InputField(hint: 'Password',ispassword: true),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(30,100,30,0),
            child: Button(text: 'Register',onclick: (){},),
          ),
        ],
      ),
    );
  }
}
