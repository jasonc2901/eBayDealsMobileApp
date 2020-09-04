import 'package:ebay_deals_app/Widgets/slide_item.dart';
import 'package:flutter/material.dart';

class BiggestDealContainer extends StatefulWidget {
  var deals;
  String title;
  
  BiggestDealContainer({Key key, @required this.deals, @required this.title})
      : super(key: key);

  @override
  _BiggestDealContainerState createState() => _BiggestDealContainerState();
}

class _BiggestDealContainerState extends State<BiggestDealContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 8.0),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2.2,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 0.0),
          child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.deals == null ? 0 : widget.deals.length,
              itemBuilder: (BuildContext context, int index) {
                var deals = widget.deals[index].toJson();

                return Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: SlideItem(
                      img: deals["deal_img"],
                      title: deals["deal_title"],
                      price: deals["deal_price"],
                      originalPrice: deals["deal_original_price"],
                      height: MediaQuery.of(context).size.height / 2.4,
                      url: deals["deal_url"]),
                );
              }),
        ),
      ],
    );
  }
}