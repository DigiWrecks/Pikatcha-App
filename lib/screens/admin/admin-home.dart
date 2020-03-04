import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikatcha/screens/admin/admin-complete.dart';
import 'package:pikatcha/screens/admin/admin-order-info.dart';


class AdminHomeMain extends StatefulWidget {

  @override
  _AdminHomeMainState createState() => _AdminHomeMainState();
}

class _AdminHomeMainState extends State<AdminHomeMain> with SingleTickerProviderStateMixin{
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Admin Home',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: new TabBar(
          indicatorColor: Colors.white,
          controller: tabController,
          tabs: <Widget>[
            new Tab(
              child: new Text("Pending",
                  style: new TextStyle(fontWeight: FontWeight.bold)),
            ),
            new Tab(
                child: new Text("Completed",
                  style: new TextStyle(fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),


      body: new TabBarView(
        children: <Widget>[
              AdminPending(),
              AdminComplete()
          ],
        controller: tabController,
      ),

    );
  }
}



class AdminPending extends StatefulWidget {


  @override
  _AdminPendingState createState() => _AdminPendingState();
}

class _AdminPendingState extends State<AdminPending> {

  List<DocumentSnapshot> imageData;
  StreamSubscription<QuerySnapshot> subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = Firestore.instance.collection('images').where('isComplete', isEqualTo: false).snapshots().listen((datasnapshot){
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
          String docId = imageData[i].documentID;

          return Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => AdminOrderInfo(
                    url: url,
                    email: email,
                    name: name,
                    phone: phone,
                    address: address,
                    docId: docId,
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
