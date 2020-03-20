import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikatcha/screens/checkout.dart';
import 'package:pikatcha/screens/settings.dart';
import 'package:pikatcha/widgets/button.dart';
import 'package:pikatcha/widgets/toast.dart';
import 'package:pikatcha/widgets/upload-widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var status = 'Select Size';
  var status2 = 'Select Size';
  var status3 = 'Select Size';
  var status4 = 'Select Size';
  var status5 = 'Select Size';
  var status6 = 'Select Size';
  var status7 = 'Select Size';
  var status8 = 'Select Size';
  var status9 = 'Select Size';
  var status10 = 'Select Size';
  int count = 1;
  var name,address,phone,uid,email,building,unit,postal;


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
    building = logged[0].data['buildingNo'];
    unit = logged[0].data['unitNo'];
    postal = logged[0].data['postal'];
  }


  List<Widget> widgets;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     widgets = [UploadWidget(status: status,index: '1',)];
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          String y;
          count++;
          switch(count){
            case 2:
              y = status2;
              break;
            case 3:
              y = status3;
              break;
            case 4:
              y = status4;
              break;
            case 5:
              y = status5;
              break;
            case 6:
              y = status6;
              break;
            case 7:
              y = status7;
              break;
            case 8:
              y = status8;
              break;
            case 9:
              y = status9;
              break;
            case 10:
              y = status10;
              break;
          }

          setState(() {
            if(count < 11){
              widgets.add(UploadWidget(status: y,index: count.toString(),));
            }

          });
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.add,color: Colors.white,),

      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home',style: TextStyle(fontWeight: FontWeight.bold),),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: (){
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => Settings(Address: address,phoneNo: phone,uid: uid,buildingNo: building,postalCode: postal,unitNo: unit,)),
                );
              }
              )
        ],
      ),

      body: Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: widgets.length,
            itemBuilder: (context,i){
              return widgets[i];
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30,10,30,20),
            child: Button(text: 'Summary',onclick: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();

              var img1 = prefs.getString('image1');
              var img2 = prefs.getString('image2');
              var img3 = prefs.getString('image3');
              var img4 = prefs.getString('image4');
              var img5 = prefs.getString('image5');
              var img6 = prefs.getString('image6');
              var img7 = prefs.getString('image7');
              var img8 = prefs.getString('image8');
              var img9 = prefs.getString('image9');
              var img10 = prefs.getString('image10');

              var size1 = prefs.getString('size1');
              var size2 = prefs.getString('size2');
              var size3 = prefs.getString('size3');
              var size4 = prefs.getString('size4');
              var size5 = prefs.getString('size5');
              var size6 = prefs.getString('size6');
              var size7 = prefs.getString('size7');
              var size8 = prefs.getString('size8');
              var size9 = prefs.getString('size9');
              var size10 = prefs.getString('size10');
              
              var price1 = prefs.getInt('price1')??0;
              var price2 = prefs.getInt('price2')??0;
              var price3 = prefs.getInt('price3')??0;
              var price4 = prefs.getInt('price4')??0;
              var price5 = prefs.getInt('price5')??0;
              var price6 = prefs.getInt('price6')??0;
              var price7 = prefs.getInt('price7')??0;
              var price8 = prefs.getInt('price8')??0;
              var price9 = prefs.getInt('price9')??0;
              var price10 = prefs.getInt('price10')??0;

              int tot = price1 + price2 + price3 + price4 + price5 + price6 + price7 + price8 + price9 + price10;
              //print('total is $tot');

              if(img1==null){
                ToastBar(color: Colors.red,text: 'Please upload a image first').show();
              }
              else if(img1!=null&&size1=='Select Size'){
                ToastBar(color: Colors.red,text: 'Please select a size').show();
              }
              else if(img2!=null&&size2=='Select Size'){
                ToastBar(color: Colors.red,text: 'Please select a size').show();
              }
              else if(img3!=null&&size3=='Select Size'){
                ToastBar(color: Colors.red,text: 'Please select a size').show();
              }
              else if(img4!=null&&size4=='Select Size'){
                ToastBar(color: Colors.red,text: 'Please select a size').show();
              }
              else if(img5!=null&&size5=='Select Size'){
                ToastBar(color: Colors.red,text: 'Please select a size').show();
              }
              else if(img6!=null&&size6=='Select Size'){
                ToastBar(color: Colors.red,text: 'Please select a size').show();
              }
              else if(img7!=null&&size7=='Select Size'){
                ToastBar(color: Colors.red,text: 'Please select a size').show();
              }
              else if(img8!=null&&size8=='Select Size'){
                ToastBar(color: Colors.red,text: 'Please select a size').show();
              }
              else if(img9!=null&&size9=='Select Size'){
                ToastBar(color: Colors.red,text: 'Please select a size').show();
              }
              else if(img10!=null&&size10=='Select Size'){
                ToastBar(color: Colors.red,text: 'Please select a size').show();
              }else{
//                for(int i=1;i<=10;i++){
//                  prefs.setString('price$i', null);
//                  prefs.setString('size$i', null);
//                  prefs.setString('image$i', null);
//                }

                Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => CheckOut(
                    tot: tot,
                    img1: img1,
                    img2: img2,
                    img3: img3,
                    img4: img4,
                    img5: img5,
                    img6: img6,
                    img7: img7,
                    img8: img8,
                    img9: img9,
                    img10: img10,

                    size1: size1,
                    size2: size2,
                    size3: size3,
                    size4: size4,
                    size5: size5,
                    size6: size6,
                    size7: size7,
                    size8: size8,
                    size9: size9,
                    size10: size10,

                    price1: price1,
                    price2: price2,
                    price3: price3,
                    price4: price4,
                    price5: price5,
                    price6: price6,
                    price7: price7,
                    price8: price8,
                    price9: price9,
                    price10: price10,


                    address: address,
                    building: building,
                    postal: postal,
                    unit: unit,
                    email: email,
                    name: name,
                    phone: phone,


                  )),
                );
              }



//              print('image 1 - $img1');
//              print('size 1 - $size1');
//              print('image 2 - $img2');
//              print('size 2 - $size2');
//              print('image 3 - $img3');
//              print('size 3 - $size3');
//              print('image 4 - $img4');
//              print('size 4 - $size4');
//              print('image 5 - $img5');
//              print('size 5 - $size5');
//              print('image 6 - $img6');
//              print('size 6 - $size6');
//              print('image 7 - $img7');
//              print('size 7 - $size7');
//              print('image 8 - $img8');
//              print('size 8 - $size8');
//              print('image 9 - $img9');
//              print('size 9 - $size9');
//              print('image 10 - $img10');
//              print('size 10 - $size10');




            },),
          )

        ],
      ),

    );
  }
}
