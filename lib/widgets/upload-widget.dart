import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:pikatcha/widgets/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'button.dart';
import 'custom-text.dart';

class UploadWidget extends StatefulWidget {
  final String status;
  final String index;

  const UploadWidget({Key key, this.status, this.index}) : super(key: key);

  @override
  _UploadWidgetState createState() => _UploadWidgetState();
}

class _UploadWidgetState extends State<UploadWidget> {
  File image;
  bool enableButton;
  String x;
  String imageURL;
  var _icon = Icons.cloud_upload;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    x = widget.status;
    enableButton = false;
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: () async {
                image = await ImagePicker.pickImage(source: ImageSource.gallery);
                var price;
                switch(x){
                  case '2R':
                    price = 0200;
                    break;
                  case '3R':
                    price = 0230;
                    break;
                  case '4R':
                    price = 0260;
                    break;
                  case '5R':
                    price = 0300;
                    break;
                  case '6R':
                    price = 0400;
                    break;
                }
                try{
                    ToastBar(color: Colors.orangeAccent,text: 'Uploading').show();
                    StorageReference ref = FirebaseStorage.instance.ref().child("${basename(image.path)}");
                    StorageUploadTask uploadTask = ref.putFile(image);
                    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
                    imageURL = (await downloadUrl.ref.getDownloadURL());
                    print("url is $imageURL");
                    enableButton = false;
                    setState(() {
                      _icon = Icons.check_circle_outline;
                    });
                    ToastBar(color: Colors.green,text: 'Upload Sucessful!').show();
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    print(widget.index);
                    prefs.setString('size${widget.index}', x);
                    prefs.setString('image${widget.index}', imageURL);
                    prefs.setInt('price${widget.index}', price);

                  }
                  catch(e){
                    ToastBar(color: Colors.red,text: 'Upload is not Sucessful!').show();
                    print(e);
                  }

              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black
                ),
                child: Icon(_icon,color: Colors.white,size: 40,),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 30),
            child: DropdownButton(
              isExpanded: true,
              items: [
              DropdownMenuItem(child: CustomText(text: 'Select Size',),value: 'Select Size',),
              DropdownMenuItem(child: CustomText(text: '2R - \$2.00',),value: '2R',),
              DropdownMenuItem(child: CustomText(text: '3R - \$2.30',),value: '3R',),
              DropdownMenuItem(child: CustomText(text: '4R - \$2.60',),value: '4R',),
              DropdownMenuItem(child: CustomText(text: '5R - \$3.00',),value: '5R',),
              DropdownMenuItem(child: CustomText(text: '6R - \$4.00',),value: '6R',),
            ],onChanged:(newValue) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            setState(() {
              x = newValue;
              prefs.setString('size${widget.index}', x);
              var price;
              switch(x){
                case '2R':
                  price = 0200;
                  break;
                case '3R':
                  price = 0230;
                  break;
                case '4R':
                  price = 0260;
                  break;
                case '5R':
                  price = 0300;
                  break;
                case '6R':
                  price = 0400;
                  break;
              }
              prefs.setInt('price${widget.index}', price);
            });

        },
            value: x,
        ),
          ),
        ),
//        Expanded(child: Padding(
//          padding: const EdgeInsets.all(15),
//          child: Button(text: 'Upload',onclick: () async {
//            var price;
//            switch(x){
//              case '2R':
//                price = 0200;
//                break;
//              case '3R':
//                price = 0230;
//                break;
//              case '4R':
//                price = 0260;
//                break;
//              case '5R':
//                price = 0300;
//                break;
//              case '6R':
//                price = 0400;
//                break;
//            }
//
//
//            if(enableButton == true){
//              try{
//                ToastBar(color: Colors.orangeAccent,text: 'Uploading').show();
//                StorageReference ref = FirebaseStorage.instance.ref().child("${basename(image.path)}");
//                StorageUploadTask uploadTask = ref.putFile(image);
//                final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
//                imageURL = (await downloadUrl.ref.getDownloadURL());
//                print("url is $imageURL");
//                enableButton = false;
//                setState(() {
//                  _icon = Icons.check_circle_outline;
//                });
//                ToastBar(color: Colors.green,text: 'Upload Sucessful!').show();
//                SharedPreferences prefs = await SharedPreferences.getInstance();
//                print(widget.index);
//                prefs.setString('size${widget.index}', x);
//                prefs.setString('image${widget.index}', imageURL);
//                prefs.setInt('price${widget.index}', price);
//
//              }
//              catch(e){
//                ToastBar(color: Colors.red,text: 'Upload is not Sucessful!').show();
//                print(e);
//              }
//            }
//            else{
//              print('disabled');
//              null;
//            }
//
//          },),
//        )
//        ),
      ],
    );
  }
}
