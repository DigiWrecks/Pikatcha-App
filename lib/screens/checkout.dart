import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:pikatcha/widgets/button.dart';
import 'package:pikatcha/widgets/custom-text.dart';
import 'package:pikatcha/widgets/toast.dart';
import 'package:stripe_payment/stripe_payment.dart';

import 'finalcheckout.dart';

class CheckOut extends StatefulWidget {
  final int tot;
  final String img1,img2,img3,img4,img5,img6,img7,img8,img9,img10;
  final String size1,size2,size3,size4,size5,size6,size7,size8,size9,size10;
  final int price1,price2,price3,price4,price5,price6,price7,price8,price9,price10;
  final String phone,address,email,name,building,unit,postal;


  const CheckOut({Key key, this.tot, this.img1, this.img2, this.img3, this.img4, this.img5, this.img6, this.img7, this.img8, this.img9, this.img10, this.size1, this.size2, this.size3, this.size4, this.size5, this.size6, this.size7, this.size8, this.size9, this.size10, this.phone, this.address, this.email, this.name, this.building, this.unit, this.postal, this.price1, this.price2, this.price3, this.price4, this.price5, this.price6, this.price7, this.price8, this.price9, this.price10}) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  List<String> images= [];
  List<String> sizes= [];
  List<String> prices= [];

  createLists(){
    if(widget.img1!=null){
      images.add(widget.img1);
      sizes.add(widget.size1);
      prices.add('\$'+(widget.price1/100).toString()+'0');
    }
    if(widget.img2!=null){
      images.add(widget.img2);
      sizes.add(widget.size2);
      prices.add('\$'+(widget.price2/100).toString()+'0');
    }
    if(widget.img3!=null){
      images.add(widget.img3);
      sizes.add(widget.size3);
      prices.add('\$'+(widget.price3/100).toString()+'0');
    }
    if(widget.img4!=null){
      images.add(widget.img4);
      sizes.add(widget.size4);
      prices.add('\$'+(widget.price4/100).toString()+'0');
    }
    if(widget.img5!=null){
      images.add(widget.img5);
      sizes.add(widget.size5);
      prices.add('\$'+(widget.price5/100).toString()+'0');
    }
    if(widget.img6!=null){
      images.add(widget.img6);
      sizes.add(widget.size6);
      prices.add('\$'+(widget.price6/100).toString()+'0');
    }
    if(widget.img7!=null){
      images.add(widget.img7);
      sizes.add(widget.size7);
      prices.add('\$'+(widget.price7/100).toString()+'0');
    }
    if(widget.img8!=null){
      images.add(widget.img8);
      sizes.add(widget.size8);
      prices.add('\$'+(widget.price8/100).toString()+'0');
    }
    if(widget.img9!=null){
      images.add(widget.img9);
      sizes.add(widget.size9);
      prices.add('\$'+(widget.price9/100).toString()+'0');
    }
    if(widget.img10!=null){
      images.add(widget.img10);
      sizes.add(widget.size10);
      prices.add('\$'+(widget.price10/100).toString()+'0');
    }
  }





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createLists();
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: "pk_test_pg8BcqpX5LuCX9OENxsvuw3500SWwOScEp",
        androidPayMode: 'test',
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Checkout',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height:40,),
            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: images.length,
              itemBuilder: (context,i){

                String url = images[i];
                String size = sizes[i];
                String price = prices[i];
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
                            child: CustomText(text: 'Price - $price',size: 25,),
                          ),
                        ],),
                      SizedBox(height: 10,),

                    ],
                  ),
                );
              },
            ),
            Container(width: double.infinity,),
            SizedBox(height: 20,),
            CustomText(text: 'Your Total',size: 40,),
            SizedBox(height: 10,),
            CustomText(text: '\$${widget.tot/100}0',size: 70,),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Button(text: 'Checkout',onclick: (){
                Navigator.push(context, CupertinoPageRoute(builder: (context){
                  return FinalCheckout(
                    unit: widget.unit,
                    postal: widget.postal,
                    building: widget.building,
                    address: widget.address,
                    email: widget.email,
                    name: widget.name,
                    phone: widget.phone,

                    size1: widget.size1,
                    size2: widget.size2,
                    size3: widget.size3,
                    size4: widget.size4,
                    size5: widget.size5,
                    size6: widget.size6,
                    size7: widget.size7,
                    size8: widget.size8,
                    size9: widget.size9,
                    size10: widget.size10,

                    img1: widget.img1,
                    img2: widget.img2,
                    img3: widget.img3,
                    img4: widget.img4,
                    img5: widget.img5,
                    img6: widget.img6,
                    img7: widget.img7,
                    img8: widget.img8,
                    img9: widget.img9,
                    img10: widget.img10,

                    tot: widget.tot.toString(),




                  );}));
              },),
            )
          ],
        ),
      ),
    );
  }
}

//          Padding(
//            padding: const EdgeInsets.fromLTRB(30,0,30,20),
//            child: Button(text: 'Proceed to Pay',onclick: () async {
//                String API_GET_TOKEN = 'http://192.168.8.155/braintree/main.php';
//                String checkout = 'http://192.168.8.155/braintree/checkout.php';
//                String clientNonce = await http.read(API_GET_TOKEN);
//                print(clientNonce);
//
//                BraintreePayment braintreePayment = new BraintreePayment();
//              var data = await braintreePayment.showDropIn(
//                  nonce: clientNonce,
//                  amount: "1234",
//                  enableGooglePay: false);
//
//              print("Response of the payment ${data['paymentNonce']}");
//
//                var response = await http.post(checkout, body: {'amount': '1234', 'nonce': data['paymentNonce']});
//                print('Response status: ${response.statusCode}');
//                print('Response body: ${response.body}');
//
//            }),
//          ),