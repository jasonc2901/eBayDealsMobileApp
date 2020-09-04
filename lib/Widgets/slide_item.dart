import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SlideItem extends StatefulWidget {
  final String img;
  final String title;
  final String price;
  final String url;
  final String originalPrice;
  final double height;

  SlideItem({
    Key key,
    @required this.img,
    @required this.title,
    @required this.price,
    @required this.url,
    this.originalPrice,
    this.height
  }) : super(key: key);

  @override
  _SlideItemState createState() => _SlideItemState();
}

class _SlideItemState extends State<SlideItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.0, bottom: 0.0, left: 6.0, right: 6.0),
      child: FlatButton(
        color: Colors.transparent,
        padding: EdgeInsets.all(0),
        child: Container(
          height: widget.height != null ? widget.height : MediaQuery.of(context).size.height / 2.9,
          width: MediaQuery.of(context).size.width / 1.6,
          child: Card(
            color: Colors.grey[700],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 3.0,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 60),
                      height: MediaQuery.of(context).size.height / 4.5,
                      width: MediaQuery.of(context).size.width - 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        child: Image.network(
                          "${widget.img}",
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        widget.title,
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        "${widget.price}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
                if (widget.originalPrice != null) 
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          "RRP\n${widget.originalPrice}",
                          style: TextStyle(
                            fontSize: 20,
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.w800,
                            color: Colors.red[400],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: RaisedButton(
                      child: Text(
                        "View Deal",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      onPressed: () {
                        launchURL(widget.url);
                      },
                    )),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}
