import 'dart:io';
import 'dart:ui';
import 'package:ebay_deals_app/view/WelcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileBanner extends StatelessWidget {
  final String displayName, email;
  final File profilePic;

  UserProfileBanner(
      {@required this.displayName,
      @required this.email,
      @required this.profilePic});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: userProfile(context),
    );
  }

  userProfile(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              width: 350,
              padding: EdgeInsets.only(
                top: Consts.avatarRadius + Consts.padding - 10.0,
                bottom: Consts.padding,
                left: Consts.padding,
                right: Consts.padding,
              ),
              margin: EdgeInsets.only(top: Consts.avatarRadius),
              decoration: new BoxDecoration(
                color: Colors.grey[800],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(Consts.padding),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // To make the card compact
                children: <Widget>[
                  Text(
                    "Display name: $displayName",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Email: $email",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 13.0),
                  FlatButton(
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
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      color: Colors.grey[400],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.transparent,
                backgroundImage: FileImage(profilePic),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 20.0;
  static const double paddingtop = 30.0;
  static const double avatarRadius = 70.0;
}
