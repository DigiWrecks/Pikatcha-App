import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikatcha/widgets/button.dart';
import 'package:pikatcha/widgets/inputfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pikatcha/widgets/toast.dart';

class SignUp extends StatelessWidget {


  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference collectionReference = Firestore.instance.collection('users');

  signUp() async {
    if(email.text!='' && password.text!=''){
      try{
        AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
            email: email.text, password: password.text);
        FirebaseUser user = result.user;
        print(user.uid);

        await collectionReference.document(user.uid).setData({
          'email': email.text,
        });

        email.clear();
        password.clear();
        ToastBar(color: Colors.green,text: 'Signed Up Successfully!').show();
      }
      catch(E){
        ToastBar(color: Colors.red,text: 'Something Went Wrong!').show();
        print(E);
      }
    }else{
      ToastBar(color: Colors.red,text: 'Please Fill all the Fields!').show();
    }
  }



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
            child: Button(text: 'Register',onclick: ()=>signUp(),),
          ),
        ],
      ),
    );
  }
}
