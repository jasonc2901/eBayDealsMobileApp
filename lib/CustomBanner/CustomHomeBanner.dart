import 'dart:ui';
import 'package:flutter/material.dart';

class CustomHomeBanner extends StatelessWidget {
  final String title, info, pic;

  CustomHomeBanner(
      {@required this.title,
      @required this.info,
      @required this.pic});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: headerContent(context),
    );
  }

  headerContent(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            width: 600,
            padding: EdgeInsets.only(
              top: Consts.avatarRadius + Consts.padding - 40.0,
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
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                      textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.0),
                Text(
                  info,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          Positioned(
            left: Consts.padding,
            right: Consts.padding,
            top: Consts.paddingtop,
            child: CircleAvatar(
              radius: 50,
              child: ClipOval(
                child: Image.asset(
                  pic,
                ),
              ),
              backgroundColor: Colors.transparent,
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
