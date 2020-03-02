import 'package:flutter/material.dart';
import 'package:pikatcha/widgets/button.dart';
import 'package:pikatcha/widgets/inputfield.dart';

class ContactInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Contact Information',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: InputField(hint: 'Name',type: TextInputType.emailAddress,prefix: Icons.person,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: InputField(hint: 'Phone Number',type: TextInputType.number,prefix: Icons.phone_android,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: InputField(hint: 'Address',prefix: Icons.location_city,),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(30,100,30,0),
            child: Button(text: 'Submit',onclick: (){},),
          ),
        ],
      ),
    );
  }
}
