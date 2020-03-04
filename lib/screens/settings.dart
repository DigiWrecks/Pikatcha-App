import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikatcha/screens/home.dart';
import 'package:pikatcha/widgets/button.dart';
import 'package:pikatcha/widgets/custom-text.dart';
import 'package:pikatcha/widgets/inputfield.dart';
import 'package:pikatcha/widgets/toast.dart';

class Settings extends StatelessWidget {

  final String Address;
  final String phoneNo;
  final String uid;

  Settings({Key key, this.Address, this.phoneNo, this.uid}) : super(key: key);

  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();


  updateData(BuildContext context) async {
      await Firestore.instance.collection('users').document(uid).updateData({
        'address': address.text,
        'phone': phone.text
      });
      
      ToastBar(text: 'Data Updated',color: Colors.green).show();

      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => Home()),
      );
  }

  @override
  Widget build(BuildContext context) {

    phone.text = phoneNo;
    address.text = Address;

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
            child: InputField(hint: '',controller: address,),
          ),

          SizedBox(height: 20,),
          CustomText(text: 'Change Phone Number',size: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: InputField(hint: '',type: TextInputType.phone,controller: phone,),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(30,80,30,0),
            child: Button(text: 'Submit',onclick: ()=>updateData(context),),
          ),


        ],
      ),
    );
  }
}
