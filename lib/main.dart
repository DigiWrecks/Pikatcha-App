import 'package:flutter/material.dart';
import 'package:pikatcha/screens/login.dart';
import 'package:pikatcha/splash.dart';
import 'package:pikatcha/widgets/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  for(int i=1;i<=10;i++){
    prefs.setString('price$i', null);
    prefs.setString('size$i', null);
    prefs.setString('image$i', null);
  }
  runApp(MaterialApp(
    home: Splash(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.white,
        scaffoldBackgroundColor: Color(0xfff2f2f2),
      ),

      home: LogIn(),
    );
  }
}