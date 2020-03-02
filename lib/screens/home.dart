import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikatcha/screens/settings.dart';
import 'package:pikatcha/widgets/button.dart';
import 'package:pikatcha/widgets/custom-text.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var status = 'Select Size';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home',style: TextStyle(fontWeight: FontWeight.bold),),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: (){
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => Settings()),
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

          Padding(
            padding: const EdgeInsets.all(40),
            child: CustomText(text: 'Select your Printable Size',size: 30,),
          ),


          DropdownButton(
            items: [
              DropdownMenuItem(child: CustomText(text: 'Select Size',),value: 'Select Size',),
              DropdownMenuItem(child: CustomText(text: 'Active',),value: 'Active',),
              DropdownMenuItem(child: CustomText(text: 'Closed',),value: 'Closed',),
              DropdownMenuItem(child: CustomText(text: 'Inactive',),value: 'Inactive',),
            ],onChanged:(newValue){
            setState(() {
              status = newValue;
            });
          },
            value: status,
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(30,80,30,0),
            child: Button(text: 'Submit',onclick: (){},),
          ),

        ],
      ),
    );
  }
}
