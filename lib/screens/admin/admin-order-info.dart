import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:pikatcha/widgets/button.dart';
import 'package:pikatcha/widgets/toast.dart';

class AdminOrderInfo extends StatelessWidget {
  final String url,name,email,phone,address,docId;

  const AdminOrderInfo({Key key, this.url, this.name, this.email, this.phone, this.address, this.docId}) : super(key: key);

  download(String imgurl) async {
    try{
      var imageId = await ImageDownloader.downloadImage(imgurl);
      ToastBar(text: 'Download Succesful!',color: Colors.green).show();
    }catch(e){
      ToastBar(text: 'Can\'t download image!',color: Colors.red).show();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Order Information',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ListView(
        children: <Widget>[
          Image.network(url),

          Padding(
            padding: const EdgeInsets.fromLTRB(30,40,30,0),
            child: Button(text: 'Download Photo',onclick: ()=>download(url)),
          ),

          SizedBox(height: 25,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ListTile(
              leading: Icon(Icons.person),
              title: SelectableText(name,style: TextStyle(fontSize: 20),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ListTile(
              leading: Icon(Icons.email),
              title: SelectableText(email,style: TextStyle(fontSize: 20),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ListTile(
              leading: Icon(Icons.phone),
              title: SelectableText(phone,style: TextStyle(fontSize: 20),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ListTile(
              leading: Icon(Icons.location_on),
              title: SelectableText(address,style: TextStyle(fontSize: 20),),
            ),
          ),


          Padding(
            padding: const EdgeInsets.fromLTRB(30,30,30,0),
            child: Button(text: 'Mark Order as Complete',onclick: () async {
              try{
                await Firestore.instance.collection('images').document(docId).updateData({
                  'isComplete': true
                });

                ToastBar(text: 'Completed',color: Colors.green).show();

                Navigator.pop(context);
              }
              catch(e){
                ToastBar(text: 'Something went Wrong',color: Colors.red).show();
              }
            }),
          ),

        ],
      ),
    );
  }
}
