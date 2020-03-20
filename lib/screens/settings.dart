import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikatcha/screens/home.dart';
import 'package:pikatcha/widgets/button.dart';
import 'package:pikatcha/widgets/custom-text.dart';
import 'package:pikatcha/widgets/inputfield.dart';
import 'package:pikatcha/widgets/toast.dart';

class Settings extends StatelessWidget {

  final String Address,buildingNo,unitNo,postalCode;
  final String phoneNo;
  final String uid;

  Settings({Key key, this.Address, this.phoneNo, this.uid, this.buildingNo, this.unitNo, this.postalCode}) : super(key: key);

  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController building = TextEditingController();
  TextEditingController unit = TextEditingController();
  TextEditingController postalcode = TextEditingController();


  updateData(BuildContext context) async {
      await Firestore.instance.collection('users').document(uid).updateData({
        'address': address.text,
        'phone': phone.text,
        'buildingNo': building.text,
        'unitNo': unit.text,
        'postal': postalcode.text
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
    building.text = buildingNo;
    unit.text = unitNo;
    postalcode.text = postalCode;

    return Scaffold(
      
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings',style: TextStyle(fontWeight: FontWeight.bold),),
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(width: double.infinity,),
            SizedBox(height: 30,),
            CustomText(text: 'Change Address',size: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: InputField(hint: '',controller: address,settings: true,),
            ),

            SizedBox(height: 20,),
            CustomText(text: 'Change Building No',size: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: InputField(hint: '',controller: building,settings: true,),
            ),

            SizedBox(height: 20,),
            CustomText(text: 'Change Unit No',size: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: InputField(hint: '',controller: unit,settings: true,),
            ),

            SizedBox(height: 20,),
            CustomText(text: 'Change Postal Code',size: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: InputField(hint: '',controller: postalcode,settings: true,),
            ),

            SizedBox(height: 20,),
            CustomText(text: 'Change Phone Number',size: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: InputField(hint: '',type: TextInputType.phone,controller: phone,settings: true,),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(30,80,30,0),
              child: Button(text: 'Submit',onclick: ()=>updateData(context),),
            ),


          ],
        ),
      ),
    );
  }
}
