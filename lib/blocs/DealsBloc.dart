import 'dart:async';
import 'package:ebay_deals_app/networking/Response.dart';
import 'package:ebay_deals_app/repository/DealsRepository.dart';
import 'package:ebay_deals_app/models/DealsModel.dart';

class DealsBloc {
  DealsRepository _dealsRepository;
  StreamController _dealsController;

  StreamSink<Response<DealsModel>> get dealsDataSink =>
      _dealsController.sink;

  Stream<Response<DealsModel>> get dealsDataStream =>
      _dealsController.stream;

  DealsBloc() {
    _dealsController = StreamController<Response<DealsModel>>();
    _dealsRepository = DealsRepository();
    fetchDeals();
  }

  fetchDeals() async {
    dealsDataSink.add(Response.loading('Fetching todays deals!'));
    try {
      DealsModel dealsDetails =
          await _dealsRepository.fetchDealsData();
      dealsDataSink.add(Response.completed(dealsDetails));
    } catch (e) {
      dealsDataSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _dealsController?.close();
  }
}
