import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:pikatcha/widgets/button.dart';
import 'package:pikatcha/widgets/custom-text.dart';
import 'package:pikatcha/widgets/toast.dart';

class AdminOrderInfoComplete extends StatelessWidget {
  final String name, email, phone, address, docId,building,unit,postal;
  final List<String> images, sizes;

  const AdminOrderInfoComplete(
      {Key key,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.docId,
        this.images,
        this.sizes, this.building, this.unit, this.postal})
      : super(key: key);

  download(String imgurl) async {
    try {
      var imageId = await ImageDownloader.downloadImage(imgurl);
      ToastBar(text: 'Download Succesful!', color: Colors.green).show();
    } catch (e) {
      ToastBar(text: 'Can\'t download image!', color: Colors.red).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Order Information - $docId',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ListTile(
                leading: Icon(Icons.person),
                title: SelectableText(
                  name,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ListTile(
                leading: Icon(Icons.email),
                title: SelectableText(
                  email,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ListTile(
                leading: Icon(Icons.phone),
                title: SelectableText(
                  phone,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ListTile(
                leading: Icon(Icons.location_on),
                title: SelectableText(
                  address,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ListTile(
                leading: Icon(Icons.location_on),
                title: SelectableText(
                  building,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ListTile(
                leading: Icon(Icons.location_on),
                title: SelectableText(
                  unit,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ListTile(
                leading: Icon(Icons.location_on),
                title: SelectableText(
                  postal,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 20,),
            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: images.length,
              itemBuilder: (context,i){

                String url = images[i];
                String size = sizes[i];
                return Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black,width: 2)

                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(url)),
                      ),

                      Row(
                        children: <Widget>[
                          Expanded(
                            child: CustomText(text: 'Size - $size',size: 25,),
                          ),
                          Expanded(
                            child: IconButton(icon: Icon(Icons.cloud_download,size: 30,), onPressed: ()=>download(url)),
                          )
                        ],)

                    ],
                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
