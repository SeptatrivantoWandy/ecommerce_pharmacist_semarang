import 'package:flutter/foundation.dart';

class CartResponse {
  final bool status;
  final String message;
  final List<CartData> cartData;

  CartResponse({
    required this.status,
    required this.message,
    required this.cartData,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    var list = json['cartData'] as List;
    List<CartData> cartDataList =
        list.map((i) => CartData.fromJson(i)).toList();

    return CartResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      cartData: cartDataList,
    );
  }

  void printCartResponse() {
    if (kDebugMode) {
      print('========== printCartResponse ==========');
      print('Status: $status');
      print('Message: $message');
      print('Cart Data:');
      for (var data in cartData) {
        print('User Code: ${data.userCode}');
        print('Cart Measure: ${data.cartMeasure}');
        print('Cart Quantity: ${data.cartQty}');
        print('Cart Bonus: ${data.cartBonus}');
        print('Cart Drug Price: ${data.cartDrugPrice}');
        print('Cart Discount: ${data.cartDiscount}');
        print('Drug Data:');
        print('  Drug Code: ${data.drugData.drugCode}');
        print('  Drug Name: ${data.drugData.drugName}');
        print('  Drug Image: ${data.drugData.drugImage}');
        print('  Drug Detail:');
        print('    Drug Measure: ${data.drugData.drugDetail.drugMeasure}');
        print('    Drug Measure 2: ${data.drugData.drugDetail.drugMeasure2}');
        print('    Harga 1 HV: ${data.drugData.drugDetail.hrg1Hv}');
        print('    Harga 2 HV: ${data.drugData.drugDetail.hrg2Hv}');
        print('    Beli 1a: ${data.drugData.drugDetail.beli1a}');
        print('    Beli 1b: ${data.drugData.drugDetail.beli1b}');
        print('    Bonus 1: ${data.drugData.drugDetail.bonus1}');
        print('    Diskon 1: ${data.drugData.drugDetail.disc1}');
        print('    Harga Jadi 1: ${data.drugData.drugDetail.hrgJadi1}');
        print('    Kondisi 1: ${data.drugData.drugDetail.kond1}');
        print('    Beli 2a: ${data.drugData.drugDetail.beli2a}');
        print('    Beli 2b: ${data.drugData.drugDetail.beli2b}');
        print('    Bonus 2: ${data.drugData.drugDetail.bonus2}');
        print('    Diskon 2: ${data.drugData.drugDetail.disc2}');
        print('    Harga Jadi 2: ${data.drugData.drugDetail.hrgJadi2}');
        print('    Kondisi 2: ${data.drugData.drugDetail.kond2}');
        print('    Beli 3a: ${data.drugData.drugDetail.beli3a}');
        print('    Beli 3b: ${data.drugData.drugDetail.beli3b}');
        print('    Bonus 3: ${data.drugData.drugDetail.bonus3}');
        print('    Diskon 3: ${data.drugData.drugDetail.disc3}');
        print('    Harga Jadi 3: ${data.drugData.drugDetail.hrgJadi3}');
        print('    Kondisi 3: ${data.drugData.drugDetail.kond3}');
        print('---');
      }
    }
  }
}

class CartData {
  final String userCode;
  final String cartMeasure;
  final String cartQty;
  final String cartBonus;
  final String cartDrugPrice;
  final String cartDiscount;
  final CartDetail drugData;

  CartData({
    required this.userCode,
    required this.cartMeasure,
    required this.cartQty,
    required this.cartBonus,
    required this.cartDrugPrice,
    required this.cartDiscount,
    required this.drugData,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      userCode: json['userCode'] ?? '',
      cartMeasure: json['cartMeasure'] ?? '',
      cartQty: json['cartQty'] ?? '',
      cartBonus: json['cartBonus'] ?? '',
      cartDrugPrice: json['cartDrugPrice'] ?? '',
      cartDiscount: json['cartDiscount'] ?? '',
      drugData: CartDetail.fromJson(json['drugData']),
    );
  }
}

class CartDetail {
  final String drugCode;
  final String drugName;
  final String drugImage;
  final DrugDetail drugDetail;

  CartDetail({
    required this.drugCode,
    required this.drugName,
    required this.drugImage,
    required this.drugDetail,
  });

  factory CartDetail.fromJson(Map<String, dynamic> json) {
    return CartDetail(
      drugCode: json['drugCode'] ?? '',
      drugName: json['drugName'] ?? '',
      drugImage: json['drugImage'] ?? '',
      drugDetail: DrugDetail.fromJson(json['drugDetail']),
    );
  }
}

class DrugDetail {
  final String drugMeasure;
  final String drugMeasure2;
  final String hrg1Hv;
  final String hrg2Hv;
  final String beli1a;
  final String beli1b;
  final String bonus1;
  final String disc1;
  final String hrgJadi1;
  final String kond1;
  final String beli2a;
  final String beli2b;
  final String bonus2;
  final String disc2;
  final String hrgJadi2;
  final String kond2;
  final String beli3a;
  final String beli3b;
  final String bonus3;
  final String disc3;
  final String hrgJadi3;
  final String kond3;

  DrugDetail({
    required this.drugMeasure,
    required this.drugMeasure2,
    required this.hrg1Hv,
    required this.hrg2Hv,
    required this.beli1a,
    required this.beli1b,
    required this.bonus1,
    required this.disc1,
    required this.hrgJadi1,
    required this.kond1,
    required this.beli2a,
    required this.beli2b,
    required this.bonus2,
    required this.disc2,
    required this.hrgJadi2,
    required this.kond2,
    required this.beli3a,
    required this.beli3b,
    required this.bonus3,
    required this.disc3,
    required this.hrgJadi3,
    required this.kond3,
  });

  factory DrugDetail.fromJson(Map<String, dynamic> json) {
    return DrugDetail(
      drugMeasure: json['drugMeasure'] ?? '',
      drugMeasure2: json['drugMeasure2'] ?? '',
      hrg1Hv: json['hrg1Hv'] ?? '',
      hrg2Hv: json['hrg2Hv'] ?? '',
      beli1a: json['beli1a'] ?? '',
      beli1b: json['beli1b'] ?? '',
      bonus1: json['bonus1'] ?? '',
      disc1: json['disc1'] ?? '',
      hrgJadi1: json['hrgJadi1'] ?? '',
      kond1: json['kond1'] ?? '',
      beli2a: json['beli2a'] ?? '',
      beli2b: json['beli2b'] ?? '',
      bonus2: json['bonus2'] ?? '',
      disc2: json['disc2'] ?? '',
      hrgJadi2: json['hrgJadi2'] ?? '',
      kond2: json['kond2'] ?? '',
      beli3a: json['beli3a'] ?? '',
      beli3b: json['beli3b'] ?? '',
      bonus3: json['bonus3'] ?? '',
      disc3: json['disc3'] ?? '',
      hrgJadi3: json['hrgJadi3'] ?? '',
      kond3: json['kond3'] ?? '',
    );
  }
}
