import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewAllDealWidget extends StatefulWidget {
  final String img;
  final String title;
  final String price;
  final String url;
  final String originalPrice;

  ViewAllDealWidget(
      {Key key,
      @required this.img,
      @required this.title,
      @required this.price,
      @required this.url,
      @required this.originalPrice})
      : super(key: key);

  @override
  _ViewAllDealWidgetState createState() => _ViewAllDealWidgetState();
}

class _ViewAllDealWidgetState extends State<ViewAllDealWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 150,
                height: 150,
                child: Image.network(
                  "${widget.img}",
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                    width: 220,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "${widget.title}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 120.0, left: 70.0),
                  child: Text(
                    widget.price,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 65.0, top: 150),
                    child: RaisedButton(
                      color: Colors.grey[700],
                      child: Text(
                        "View Deal",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      onPressed: () {
                        launchURL(widget.url);
                      },
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url, 
      forceWebView: true,
      enableDomStorage: true,
      enableJavaScript: true
    );
  } else {
    throw 'Could not launch $url';
  }
}