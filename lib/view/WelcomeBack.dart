import 'dart:io';
import 'package:ebay_deals_app/view/HomePage.dart';
import 'package:ebay_deals_app/view/WelcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WelcomeBack extends StatefulWidget {
  final FirebaseUser user;

  const WelcomeBack(
    this.user,
  );

  @override
  _WelcomeBackState createState() => _WelcomeBackState();
}
  

class _WelcomeBackState extends State<WelcomeBack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF333333),
        body: Column(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 150),
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: FileImage(File(widget.user.photoUrl)),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Welcome Back, " + widget.user.displayName,
              style: TextStyle(
                fontSize: 52.0,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 70.0),
            Container(
              width: 170,
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(widget.user)));
                  },
                  child: Text(
                    "View Today's Deals",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              width: 170,
              child: FlatButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomePage()));
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  color: Colors.red[400],
              ),
            ),
          ],
        ));
  }
}
