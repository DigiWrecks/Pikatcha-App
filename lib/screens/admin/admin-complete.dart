import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikatcha/screens/admin/admin-order-info-complete.dart';
import 'package:pikatcha/widgets/button.dart';

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

              String name = imageData[i].data['name'];
              String email = imageData[i].data['email'];
              String phone = imageData[i].data['phone'];
              String address = imageData[i].data['address'];
              String buildingNo = imageData[i].data['buildingNo'];
              String unitNo = imageData[i].data['unitNo'];
              String postalCode = imageData[i].data['postal'];
              String orderID = imageData[i].data['code'];

              List<String> images = [];
              List<String> sizes = [];

              String img1 = imageData[i].data['image1'];
              String img2 = imageData[i].data['image2'];
              String img3 = imageData[i].data['image3'];
              String img4 = imageData[i].data['image4'];
              String img5 = imageData[i].data['image5'];
              String img6 = imageData[i].data['image6'];
              String img7 = imageData[i].data['image7'];
              String img8 = imageData[i].data['image8'];
              String img9 = imageData[i].data['image9'];
              String img10 = imageData[i].data['image10'];

              String size1 = imageData[i].data['size1'];
              String size2 = imageData[i].data['size2'];
              String size3 = imageData[i].data['size3'];
              String size4 = imageData[i].data['size4'];
              String size5 = imageData[i].data['size5'];
              String size6 = imageData[i].data['size6'];
              String size7 = imageData[i].data['size7'];
              String size8 = imageData[i].data['size8'];
              String size9 = imageData[i].data['size9'];
              String size10 = imageData[i].data['size10'];

              if(img1!=null){
                images.add(img1);
                sizes.add(size1);
              }
              if(img2!=null){
                images.add(img2);
                sizes.add(size2);
              }
              if(img3!=null){
                images.add(img3);
                sizes.add(size3);
              }
              if(img4!=null){
                images.add(img4);
                sizes.add(size4);
              }
              if(img5!=null){
                images.add(img5);
                sizes.add(size5);
              }
              if(img6!=null){
                images.add(img6);
                sizes.add(size6);
              }
              if(img7!=null){
                images.add(img7);
                sizes.add(size7);
              }
              if(img8!=null){
                images.add(img8);
                sizes.add(size8);
              }
              if(img9!=null){
                images.add(img9);
                sizes.add(size9);
              }
              if(img10!=null){
                images.add(img10);
                sizes.add(size10);
              }

              return Padding(
                padding: const EdgeInsets.all(20),
                child: Button(text: orderID,onclick: (){
                  print(images);
                  print(sizes);
                  Navigator.push(context, CupertinoPageRoute(builder: (context){
                    return AdminOrderInfoComplete(phone: phone,name: name,email: email,address: address,docId: orderID,images: images,sizes: sizes,unit: unitNo,postal: postalCode,building: buildingNo,);}));
                }),
              );


            }
        ):Center(child: CircularProgressIndicator(backgroundColor: Colors.red,),)
    );
  }
}