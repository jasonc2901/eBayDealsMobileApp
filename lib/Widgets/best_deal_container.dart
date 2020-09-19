import 'package:ebay_deals_app/Widgets/slide_item.dart';
import 'package:ebay_deals_app/view/ViewAllDealsPage.dart';
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
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  if (widget.deals.length > 4)
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ViewAllDealsPage(widget.deals, widget.title))
                        );
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.right,
                      ),
                    ),
                ],
              ),
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
              itemCount: (widget.deals == null) ? 0 : (widget.deals.length > 4) ? 4 : widget.deals.length,
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
