import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikatcha/screens/signup.dart';
import 'package:pikatcha/widgets/button.dart';
import 'package:pikatcha/widgets/inputfield.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(30,100,30,0),
                child: Image.asset('images/logo.jpg'),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: InputField(hint: 'Email',type: TextInputType.emailAddress,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: InputField(hint: 'Password',ispassword: true),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30,30,30,0),
              child: Button(text: 'Login',onclick: (){},),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30,15,30,0),
              child: Button(text: 'Create an Account',onclick: (){
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => SignUp()),
                );
              },),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text('OR',style: TextStyle(fontWeight: FontWeight.bold),),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(30,20,30,0),
              child: Button(text: 'Login with Google',onclick: (){},social: true,),
            )

          ],
        ),
      ),
    );
  }
}
