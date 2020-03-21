import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:pikatcha/widgets/button.dart';
import 'package:pikatcha/widgets/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;
import 'home.dart';


class FinalCheckout extends StatefulWidget {
  final String tot;
  final String img1,img2,img3,img4,img5,img6,img7,img8,img9,img10;
  final String size1,size2,size3,size4,size5,size6,size7,size8,size9,size10;
  final String phone,address,email,name,building,unit,postal;

  const FinalCheckout({Key key, this.tot, this.img1, this.img2, this.img3, this.img4, this.img5, this.img6, this.img7, this.img8, this.img9, this.img10, this.size1, this.size2, this.size3, this.size4, this.size5, this.size6, this.size7, this.size8, this.size9, this.size10, this.phone, this.address, this.email, this.name, this.building, this.unit, this.postal}) : super(key: key);
  @override
  _FinalCheckoutState createState() => _FinalCheckoutState();
}

class _FinalCheckoutState extends State<FinalCheckout> {
  String cardNumber = '';

  String expiryDate = '';

  String cardHolderName = '';

  String cvvCode = '';

  bool isCvvFocused = false;

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  checkAvailiability() async {
    Random rnd = Random();
    var r = 10000 + rnd.nextInt(99999 - 10000);
    var x = await Firestore.instance.collection('images').where('code', isEqualTo: r.toString()).getDocuments();
    var availiable = x.documents;

    if(availiable.isEmpty){
      sendToFirestore(r.toString());
    }
    else{
      checkAvailiability();
    }

  }

  sendToFirestore(String code) async {
    try{
      Firestore.instance.collection('images').document(code).setData({
        'image1': widget.img1,
        'image2': widget.img2,
        'image3': widget.img3,
        'image4': widget.img4,
        'image5': widget.img5,
        'image6': widget.img6,
        'image7': widget.img7,
        'image8': widget.img8,
        'image9': widget.img9,
        'image10': widget.img10,

        'size1':widget.size1,
        'size2':widget.size2,
        'size3':widget.size3,
        'size4':widget.size4,
        'size5':widget.size5,
        'size6':widget.size6,
        'size7':widget.size7,
        'size8':widget.size8,
        'size9':widget.size9,
        'size10':widget.size10,

        'isComplete': false,
        'phone': widget.phone,
        'email': widget.email,
        'address': widget.address,
        'name': widget.name,
        'code': code,
        'buildingNo': widget.building,
        'unitNo': widget.unit,
        'postal': widget.postal

      });

      ToastBar(text: 'Data send successfully!',color: Colors.green).show();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      for(int i=1;i<=10;i++){
        prefs.setString('price$i', null);
        prefs.setString('size$i', null);
        prefs.setString('image$i', null);
      }
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context){
        return Home();}));
    }
    catch(e){
      ToastBar(text: 'Something Went Wrong While Uploading Data!',color: Colors.red).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Enter Card Information',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 40,),
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
            ),
            CreditCardForm(
              onCreditCardModelChange: onCreditCardModelChange,
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Button(text: 'Checkout',onclick: () async {
                final CreditCard testCard = CreditCard(
                  number: cardNumber,
                  expMonth: int.parse(expiryDate[0]+expiryDate[1]),
                  expYear: int.parse(expiryDate[3]+expiryDate[4]),
                  cvc: cvvCode,
                );

                //print(int.parse(expiryDate[3]+expiryDate[4]));
                StripePayment.createTokenWithCard(
                  testCard,
                ).then((token) async {
                  try{
                    var response = await http.post('https://api.stripe.com/v1/charges',
                      body: {'amount': '${widget.tot.toString()}','currency': 'usd',"source": token.tokenId},
                      headers: {'Authorization': "Bearer sk_test_Ovju8LDOSOIrGrUYPfUB73RQ00BMawpAck"},
                    );
                    print('Response status: ${response.statusCode}');
                    print('Response body: ${response.body}');

                    checkAvailiability();

                  }
                  catch(e){
                    ToastBar(text: 'Something went Wrong While Processing the Payment',color: Colors.red).show();
                  }
                });

              },),
            )
          ],
        ),
      ),
    );
  }
}
