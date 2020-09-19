import 'package:ebay_deals_app/view/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
        title: 'Welcome Page',
        home: WelcomePage(),
        debugShowCheckedModeBanner: false); // define it once at root level.
  }
}