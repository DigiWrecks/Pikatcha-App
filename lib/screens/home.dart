import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home',style: TextStyle(fontWeight: FontWeight.bold),),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: (){}
              )
        ],
      ),
    );
  }
}
