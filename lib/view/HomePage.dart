import 'dart:io';
import 'package:ebay_deals_app/CustomAlert/CustomAlert.dart';
import 'package:ebay_deals_app/CustomBanner/UserProfileBanner.dart';
import 'package:ebay_deals_app/Widgets/best_deal_container.dart';
import 'package:ebay_deals_app/Widgets/deal_container.dart';
import 'package:ebay_deals_app/Widgets/slide_item.dart';
import 'package:ebay_deals_app/models/DealsModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ebay_deals_app/blocs/DealsBloc.dart';
import 'package:ebay_deals_app/networking/Response.dart';
import 'package:ebay_deals_app/CustomBanner/CustomHomeBanner.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;

  const HomePage(
    this.user,
  );

  @override
  _ShowHomePageState createState() => _ShowHomePageState();
}

class _ShowHomePageState extends State<HomePage> {
  DealsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = DealsBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          title: Text('Home Page',
              style: TextStyle(color: Colors.white, fontSize: 20)),
          backgroundColor: Color(0xFF333333),
        ),
        backgroundColor: Color(0xFF333333),
        body: RefreshIndicator(
          onRefresh: () => _bloc.fetchDeals(),
          child: StreamBuilder<Response<DealsModel>>(
            stream: _bloc.dealsDataStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    return Loading(loadingMessage: snapshot.data.message);
                    break;
                  case Status.COMPLETED:
                    return DealsHomePage(
                        dealsData: snapshot.data.data, user: widget.user);
                    break;
                  case Status.ERROR:
                    String error = snapshot.data.message;
                    String errorDesc = '';

                    if (error.contains(
                        "Error occured while Communication with Server with StatusCode : 500")) {
                      error = "Unknown error with server";
                      errorDesc = "Please try again!";
                    }

                    print("Error Simplified: " + error.toString());
                    return Error(
                      errorMessage: error,
                      errorDescription: errorDesc,
                      onRetryPressed: () => _bloc.fetchDeals(),
                    );
                    break;
                }
              }
              return Container();
            },
          ),
        ));
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class DealsHomePage extends StatelessWidget {
  final DealsModel dealsData;
  final FirebaseUser user;

  const DealsHomePage({Key key, this.dealsData, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _displayName = user.displayName;
    String _email = user.email;
    File pathToImg = File(user.photoUrl);

    //lists to store all deals and the best deals
    List<AllDeals> allDeals = dealsData.data.allDeals;
    List<AllDeals> biggestSavings = new List<AllDeals>();

    for(int i = 0; i < dealsData.data.allDeals.length; i++){
      //turns each deal into json object and extracts the original price
      var dealJson = allDeals[i].toJson();
      String originalPrice = dealJson['deal_original_price'];
      
      //checks if object has an original price and adds the ones that do into best deals
      if(originalPrice.toString().contains("null")){
        ;
      }else {
        biggestSavings.add(allDeals[i]); 
      }
    }

    return Scaffold(
      backgroundColor: Color(0xFF333333),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            UserProfileBanner(
                displayName: _displayName,
                email: _email,
                profilePic: pathToImg),
            CustomHomeBanner(
                title: "Top Deals on eBay",
                info: "Hello $_displayName, Browse the top deals below!",
                pic: "assets/ebay.png"),
            if (biggestSavings.length >= 0)
              BiggestDealContainer(
                deals: biggestSavings, 
                title: "Biggest Savings"
            ),
            if (dealsData.data.dealsUnder10.length >= 1)
              DealContainer(
                deals: dealsData.data.dealsUnder10,
                title: "Deals Under £10",
              ),
            
            if (dealsData.data.dealsUnder50.length >= 1)
              DealContainer(
                deals: dealsData.data.dealsUnder50,
                title: "Deals Under £50",
              ),

            if (dealsData.data.dealsUnder100.length >= 1)
              DealContainer(
                deals: dealsData.data.dealsUnder100,
                title: "Deals Under £100",
              ),
            
            DealContainer(deals: dealsData.data.allDeals, title: "All Deals"),
          ],
        ),
      ),
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;
  final String errorDescription;
  final Function onRetryPressed;

  const Error(
      {Key key, this.errorMessage, this.errorDescription, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
        title: errorMessage,
        description: errorDescription,
        buttonText: "Retry",
        alertImage: "assets/x.png",
        buttonColor: Colors.red[600]);
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
  }
}
