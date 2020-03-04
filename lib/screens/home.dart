import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pikatcha/screens/settings.dart';
import 'package:pikatcha/widgets/button.dart';
import 'package:pikatcha/widgets/custom-text.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var status = 'Select Size';
  var name,address,phone,uid,email;
  File image;

  Map<String, String> headers = {
    'Authorization': "Bearer  sk_test_Ovju8LDOSOIrGrUYPfUB73RQ00BMawpAck",
    "Content-Type": "application/x-www-form-urlencoded"
  };



  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    uid = prefs.getString('uid');
    var sub = await Firestore.instance.collection('users').where('email',isEqualTo: email).getDocuments();
    var logged = sub.documents;
    name = logged[0].data['name'];
    address = logged[0].data['address'];
    phone = logged[0].data['phone'];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home',style: TextStyle(fontWeight: FontWeight.bold),),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: (){
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => Settings(Address: address,phoneNo: phone,uid: uid,)),
                );
              }
              )
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          Container(width: double.infinity,),
          CustomText(text: 'Upload your Image',size: 30,),

          Padding(
            padding: const EdgeInsets.all(30),
            child: GestureDetector(
              onTap: () async {
                image = await ImagePicker.pickImage(source: ImageSource.gallery);
              },
              child: Container(
                width: 120,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black
                ),
                child: Icon(Icons.cloud_upload,color: Colors.white,size: 70,),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(40),
            child: CustomText(text: 'Select your Printable Size',size: 30,),
          ),


          DropdownButton(
            items: [
              DropdownMenuItem(child: CustomText(text: 'Select Size',),value: 'Select Size',),
              DropdownMenuItem(child: CustomText(text: '2R',),value: '2R',),
              DropdownMenuItem(child: CustomText(text: '3R',),value: '3R',),
              DropdownMenuItem(child: CustomText(text: '4R',),value: '4R',),
              DropdownMenuItem(child: CustomText(text: '5R',),value: '5R',),
              DropdownMenuItem(child: CustomText(text: '6R',),value: '6R',),
            ],onChanged:(newValue){
            setState(() {
              status = newValue;
            });
          },
            value: status,
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(30,80,30,0),
            child: Button(text: 'Submit',onclick: () async {}),
          ),

        ],
      ),
    );
  }
}
