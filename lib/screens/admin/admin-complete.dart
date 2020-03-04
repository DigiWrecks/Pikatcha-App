import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikatcha/screens/admin/admin-order-info-complete.dart';

class AdminComplete extends StatefulWidget {


  @override
  _AdminCompleteState createState() => _AdminCompleteState();
}

class _AdminCompleteState extends State<AdminComplete> {

  List<DocumentSnapshot> imageData;
  StreamSubscription<QuerySnapshot> subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = Firestore.instance.collection('images').where('isComplete', isEqualTo: true).snapshots().listen((datasnapshot){
      setState(() {
        imageData = datasnapshot.documents;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: imageData!=null?ListView.builder(
          itemCount: imageData.length,
          itemBuilder: (context,i){

            String url = imageData[i].data['image'];
            String name = imageData[i].data['name'];
            String email = imageData[i].data['email'];
            String phone = imageData[i].data['phone'];
            String address = imageData[i].data['address'];

            return Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => AdminOrderInfoComplete(
                      url: url,
                      email: email,
                      name: name,
                      phone: phone,
                      address: address,

                    )),
                  );
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(url)),
              ),
            );
          },
        )
            :Center(child: CircularProgressIndicator(backgroundColor: Colors.red,),)
    );
  }
}