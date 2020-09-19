import 'package:ebay_deals_app/Widgets/view_all_deal_widget.dart';
import 'package:flutter/material.dart';

class ViewAllDealsPage extends StatefulWidget {
  var deals;
  final title;
  ViewAllDealsPage(this.deals, this.title);

  @override
  _ViewAllDealsPageState createState() => _ViewAllDealsPageState();
}

class _ViewAllDealsPageState extends State<ViewAllDealsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          title: Text('View All Page',
              style: TextStyle(color: Colors.white, fontSize: 20)),
          backgroundColor: Color(0xFF333333),
        ),
        backgroundColor: Color(0xFF333333),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 40),
              child: Text(
                widget.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
            ),
            ListView.builder(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: widget.deals.length,
                itemBuilder: (BuildContext context, int index) {
                  var dealsJson = widget.deals[index].toJson();
                  return ViewAllDealWidget(
                      img: dealsJson['deal_img'],
                      title: dealsJson['deal_title'],
                      price: dealsJson['deal_price'],
                      url: dealsJson['deal_url'],
                      originalPrice: dealsJson['deal_original_price']);
                }),
          ],
        ));
  }
}
