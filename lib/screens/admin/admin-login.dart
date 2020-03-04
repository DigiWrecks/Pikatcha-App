import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikatcha/screens/admin/admin-home.dart';
import 'package:pikatcha/screens/contact-information.dart';
import 'package:pikatcha/widgets/button.dart';
import 'package:pikatcha/widgets/inputfield.dart';
import 'package:pikatcha/widgets/toast.dart';

class AdminLogin extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signInAdmin(BuildContext context) async {
    var sub = await Firestore.instance.collection('admin').where('email', isEqualTo: email.text).getDocuments();
    var user = sub.documents;
    if (user.isNotEmpty) {
      if (user[0].data['password'] == password.text) {
        print('admin logged in');

       Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => AdminHomeMain()));
      } else {
        ToastBar(text: 'Email or password is incorrect!', color: Colors.red)
            .show();
      }
    } else {
      ToastBar(text: 'Admin Doesn\' exists!', color: Colors.red).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Admin Login',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: InputField(
              hint: 'Email',
              type: TextInputType.emailAddress,
              controller: email,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: InputField(
              hint: 'Password',
              ispassword: true,
              controller: password,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
            child: Button(
                text: 'Login',
                onclick: () {
                  if (email.text != '' && password.text != '') {
                    signInAdmin(context);
                  } else {
                    ToastBar(
                            color: Colors.red,
                            text: 'Please Fill all the Fields!')
                        .show();
                  }
                }),
          ),
        ],
      ),
    );
  }
}
