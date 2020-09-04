class DealsModel {
  int status;
  Data data;

  DealsModel({this.status, this.data});

  DealsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<AllDeals> allDeals;
  List<DealsUnder10> dealsUnder10;
  List<DealsUnder50> dealsUnder50;
  List<DealsUnder100> dealsUnder100;

  Data(
      {this.allDeals,
      this.dealsUnder10,
      this.dealsUnder50,
      this.dealsUnder100});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['all_deals'] != null) {
      allDeals = new List<AllDeals>();
      json['all_deals'].forEach((v) {
        allDeals.add(new AllDeals.fromJson(v));
      });
    }
    if (json['deals_under_10'] != null) {
      dealsUnder10 = new List<DealsUnder10>();
      json['deals_under_10'].forEach((v) {
        dealsUnder10.add(new DealsUnder10.fromJson(v));
      });
    }
    if (json['deals_under_50'] != null) {
      dealsUnder50 = new List<DealsUnder50>();
      json['deals_under_50'].forEach((v) {
        dealsUnder50.add(new DealsUnder50.fromJson(v));
      });
    }
    if (json['deals_under_100'] != null) {
      dealsUnder100 = new List<DealsUnder100>();
      json['deals_under_100'].forEach((v) {
        dealsUnder100.add(new DealsUnder100.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allDeals != null) {
      data['all_deals'] = this.allDeals.map((v) => v.toJson()).toList();
    }
    if (this.dealsUnder10 != null) {
      data['deals_under_10'] =
          this.dealsUnder10.map((v) => v.toJson()).toList();
    }
    if (this.dealsUnder50 != null) {
      data['deals_under_50'] =
          this.dealsUnder50.map((v) => v.toJson()).toList();
    }
    if (this.dealsUnder100 != null) {
      data['deals_under_100'] =
          this.dealsUnder100.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllDeals {
  String dealTitle;
  String dealPrice;
  String dealOriginalPrice;
  String dealImg;
  String dealUrl;

  AllDeals(
      {this.dealTitle,
      this.dealPrice,
      this.dealOriginalPrice,
      this.dealImg,
      this.dealUrl});

  AllDeals.fromJson(Map<String, dynamic> json) {
    dealTitle = json['deal_title'];
    dealPrice = json['deal_price'];
    dealOriginalPrice = json['deal_original_price'];
    dealImg = json['deal_img'];
    dealUrl = json['deal_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal_title'] = this.dealTitle;
    data['deal_price'] = this.dealPrice;
    data['deal_original_price'] = this.dealOriginalPrice;
    data['deal_img'] = this.dealImg;
    data['deal_url'] = this.dealUrl;
    return data;
  }
}

class DealsUnder10 {
  String dealTitle;
  String dealPrice;
  String dealOriginalPrice;
  String dealImg;
  String dealUrl;

  DealsUnder10(
      {this.dealTitle,
      this.dealPrice,
      this.dealOriginalPrice,
      this.dealImg,
      this.dealUrl});

  DealsUnder10.fromJson(Map<String, dynamic> json) {
    dealTitle = json['deal_title'];
    dealPrice = json['deal_price'];
    dealOriginalPrice = json['deal_original_price'];
    dealImg = json['deal_img'];
    dealUrl = json['deal_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal_title'] = this.dealTitle;
    data['deal_price'] = this.dealPrice;
    data['deal_original_price'] = this.dealOriginalPrice;
    data['deal_img'] = this.dealImg;
    data['deal_url'] = this.dealUrl;
    return data;
  }
}

class DealsUnder50 {
  String dealTitle;
  String dealPrice;
  String dealOriginalPrice;
  String dealImg;
  String dealUrl;

  DealsUnder50(
      {this.dealTitle,
      this.dealPrice,
      this.dealOriginalPrice,
      this.dealImg,
      this.dealUrl});

  DealsUnder50.fromJson(Map<String, dynamic> json) {
    dealTitle = json['deal_title'];
    dealPrice = json['deal_price'];
    dealOriginalPrice = json['deal_original_price'];
    dealImg = json['deal_img'];
    dealUrl = json['deal_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal_title'] = this.dealTitle;
    data['deal_price'] = this.dealPrice;
    data['deal_original_price'] = this.dealOriginalPrice;
    data['deal_img'] = this.dealImg;
    data['deal_url'] = this.dealUrl;
    return data;
  }
}

class DealsUnder100 {
  String dealTitle;
  String dealPrice;
  String dealOriginalPrice;
  String dealImg;
  String dealUrl;

  DealsUnder100(
      {this.dealTitle,
      this.dealPrice,
      this.dealOriginalPrice,
      this.dealImg,
      this.dealUrl});

  DealsUnder100.fromJson(Map<String, dynamic> json) {
    dealTitle = json['deal_title'];
    dealPrice = json['deal_price'];
    dealOriginalPrice = json['deal_original_price'];
    dealImg = json['deal_img'];
    dealUrl = json['deal_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal_title'] = this.dealTitle;
    data['deal_price'] = this.dealPrice;
    data['deal_original_price'] = this.dealOriginalPrice;
    data['deal_img'] = this.dealImg;
    data['deal_url'] = this.dealUrl;
    return data;
  }
}