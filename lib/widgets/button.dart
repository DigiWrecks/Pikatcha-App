import 'package:flutter/material.dart';


class Button extends StatelessWidget {

  final onclick;
  final String text;
  final bool social;
  final IconData icon;


  const Button({Key key, this.onclick, this.text, this.social=false, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        onPressed: onclick,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: Colors.black)
        ),
        color: Colors.white,
        textColor: Colors.black,
        padding: EdgeInsets.all(15),
        child: social?Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                width: 25,
                height: 25,
                child: Image(image: AssetImage('images/google.png'))),
            SizedBox(width: 10,),
            Text(text,style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w900),)
          ],
        ):Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
      ),
    );
  }
}