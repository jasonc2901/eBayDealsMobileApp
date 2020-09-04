import 'package:ebay_deals_app/networking/ApiProvider.dart';
import 'package:ebay_deals_app/models/DealsModel.dart';
import 'dart:async';

class DealsRepository {
  ApiProvider _provider = ApiProvider();

  Future<DealsModel> fetchDealsData() async {
    final response = await _provider.get("api/deals");
    return DealsModel.fromJson(response);
  }
}