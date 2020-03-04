import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pikatcha/screens/admin/admin-login.dart';
import 'package:pikatcha/screens/contact-information2.dart';
import 'package:pikatcha/screens/home.dart';
import 'package:pikatcha/screens/signup.dart';
import 'package:pikatcha/widgets/button.dart';
import 'package:pikatcha/widgets/custom-text.dart';
import 'package:pikatcha/widgets/inputfield.dart';
import 'package:pikatcha/widgets/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatelessWidget {


  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference collectionReference = Firestore.instance.collection('users');
  GoogleSignIn _googleSignIn = GoogleSignIn();

  signInWithEmail(BuildContext context) async {
    try{
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      FirebaseUser user = result.user;
      print(user.uid);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', user.email);
      prefs.setString('uid', user.uid);

      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context){
        return Home();}));
    }
    catch(E){
      print(E);
      ToastBar(color: Colors.red,text: 'Something went Wrong').show();
    }
  }

  signInWithGoogle(BuildContext context) async {
    try{
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user = (await _firebaseAuth.signInWithCredential(credential)).user;

      var sub = await Firestore.instance.collection('users').where('email',isEqualTo: user.email).getDocuments();
      var logged = sub.documents;

      if(logged.isEmpty){
        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context){
          return ContactInformationForGoogle(email: user.email,uid: user.uid,Uname: user.displayName,);}));
      }

      else{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', user.email);
        prefs.setString('uid', user.uid);

        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context){
          return Home();}));
      }
    }
    catch(E){
      print(E);
      ToastBar(color: Colors.red,text: 'Something went Wrong').show();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfff2f2f2),
        textTheme: TextTheme(body1: TextStyle(color: Colors.black)),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0,10,15,0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => AdminLogin()),
                );
              },
              child: Container(child: CustomText(size: 20,text: 'Admin',)),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(30,30,30,0),
                child: Image.asset('images/logo.jpg'),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: InputField(hint: 'Email',type: TextInputType.emailAddress,controller: email,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: InputField(hint: 'Password',ispassword: true,controller: password,),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30,30,30,0),
              child: Button(text: 'Login',onclick: ()=>signInWithEmail(context),),
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
              child: Button(text: 'Login with Google',onclick: ()=>signInWithGoogle(context),social: true,),
            )

          ],
        ),
      ),
    );
  }
}
