import 'package:flutter/foundation.dart';

class DrugResponse {
  final bool status;
  final String message;
  final List<DrugData> drugData;

  DrugResponse({
    required this.status,
    required this.message,
    required this.drugData,
  });

  factory DrugResponse.fromJson(Map<String, dynamic> json) {
    var list = json['drugData'] as List;
    List<DrugData> drugDataList =
        list.map((i) => DrugData.fromJson(i)).toList();

    return DrugResponse(
      status: json['status'],
      message: json['message'],
      drugData: drugDataList,
    );
  }

  // Method to print the DrugResponse object details
  void printDrugResponse() {
    if (kDebugMode) {
      print('========== printDrugResponse ==========');
      print('Status: $status');
      print('Message: $message');
      print('Drug Data:');
      for (var drug in drugData) {
        print('Drug Code: ${drug.drugCode}');
        print('Drug Name: ${drug.drugName}');
        print('Drug Image: ${drug.drugImage}');
        print('Drug Details:');
        print('  Measure: ${drug.drugDetail.drugMeasure}');
        print('  Measure2: ${drug.drugDetail.drugMeasure2}');
        print('  Price 1: ${drug.drugDetail.hrg1Hv}');
        print('  Price 2: ${drug.drugDetail.hrg2Hv}');
        print('  Buy 1a: ${drug.drugDetail.beli1a}');
        print('  Buy 1b: ${drug.drugDetail.beli1b}');
        print('  Bonus 1: ${drug.drugDetail.bonus1}');
        print('  Discount 1: ${drug.drugDetail.disc1}');
        print('  Final Price 1: ${drug.drugDetail.hrgJadi1}');
        print('  Condition 1: ${drug.drugDetail.kond1}');
        print('  Buy 2a: ${drug.drugDetail.beli2a}');
        print('  Buy 2b: ${drug.drugDetail.beli2b}');
        print('  Bonus 2: ${drug.drugDetail.bonus2}');
        print('  Discount 2: ${drug.drugDetail.disc2}');
        print('  Final Price 2: ${drug.drugDetail.hrgJadi2}');
        print('  Condition 2: ${drug.drugDetail.kond2}');
        print('  Buy 3a: ${drug.drugDetail.beli3a}');
        print('  Buy 3b: ${drug.drugDetail.beli3b}');
        print('  Bonus 3: ${drug.drugDetail.bonus3}');
        print('  Discount 3: ${drug.drugDetail.disc3}');
        print('  Final Price 3: ${drug.drugDetail.hrgJadi3}');
        print('  Condition 3: ${drug.drugDetail.kond3}');
        print('  Expiry Date: ${drug.drugDetail.expiryDate}');
        print('======'); // Print a blank line between drugs for readability
      }
    }
  }
}

class DrugData {
  final String drugCode;
  final String drugName;
  final String drugImage;
  final DrugDetail drugDetail;

  DrugData({
    required this.drugCode,
    required this.drugName,
    required this.drugImage,
    required this.drugDetail,
  });

  factory DrugData.fromJson(Map<String, dynamic> json) {
    return DrugData(
      drugCode: json['drugCode'],
      drugName: json['drugName'],
      drugImage: json['drugImage'],
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
  final String expiryDate;

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
    required this.expiryDate,
  });

  factory DrugDetail.fromJson(Map<String, dynamic> json) {
    return DrugDetail(
      drugMeasure: json['drugMeasure'],
      drugMeasure2: json['drugMeasure2'],
      hrg1Hv: json['hrg1Hv'],
      hrg2Hv: json['hrg2Hv'],
      beli1a: json['beli1a'],
      beli1b: json['beli1b'],
      bonus1: json['bonus1'],
      disc1: json['disc1'],
      hrgJadi1: json['hrgJadi1'],
      kond1: json['kond1'],
      beli2a: json['beli2a'],
      beli2b: json['beli2b'],
      bonus2: json['bonus2'],
      disc2: json['disc2'],
      hrgJadi2: json['hrgJadi2'],
      kond2: json['kond2'],
      beli3a: json['beli3a'],
      beli3b: json['beli3b'],
      bonus3: json['bonus3'],
      disc3: json['disc3'],
      hrgJadi3: json['hrgJadi3'],
      kond3: json['kond3'],
      expiryDate: json['expiryDate']
    );
  }
}
