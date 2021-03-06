import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikatcha/screens/contact-information.dart';
import 'package:pikatcha/widgets/button.dart';
import 'package:pikatcha/widgets/inputfield.dart';
import 'package:pikatcha/widgets/toast.dart';

class SignUp extends StatelessWidget {


  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
            child: InputField(hint: 'Email',type: TextInputType.emailAddress,controller: email,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: InputField(hint: 'Password',ispassword: true,controller: password,),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(30,100,30,0),
            child: Button(text: 'Register',onclick: (){
              if(email.text!='' && password.text!=''){
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => ContactInformation(email: email.text,password: password.text,)),
                );
              }else{
                ToastBar(color: Colors.red,text: 'Please Fill all the Fields!').show();
              }

            }),
          ),
        ],
      ),
    );
  }
}
