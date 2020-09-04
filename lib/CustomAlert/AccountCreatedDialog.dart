import 'dart:ui';
import 'package:ebay_deals_app/view/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountCreatedDialog extends StatelessWidget {
  final String title, description, buttonText;
  final String alertImage;
  final Color buttonColor;
  final FirebaseUser user;

  AccountCreatedDialog(
      {@required this.title,
      @required this.description,
      @required this.buttonText,
      @required this.alertImage,
      @required this.buttonColor,
      @required this.user});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
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
                title,
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  color: buttonColor,
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage(user))
                    );
                  },
                  child: Text(
                    buttonText,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          top: Consts.paddingtop,
          child: ClipOval(
              child: Image.asset(
            alertImage,
            fit: BoxFit.contain,
            width: 10.0,
            height: 110.0,
          )),
        ),
      ],
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 20.0;
  static const double paddingtop = 45.0;
  static const double avatarRadius = 70.0;
}
