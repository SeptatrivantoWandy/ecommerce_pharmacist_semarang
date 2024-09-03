import 'package:flutter/foundation.dart';

class EditOrderRequest {
  final String userCode;
  final List<EditedCartData> editedCartData;

  EditOrderRequest({
    required this.userCode,
    required this.editedCartData,
  });

  Map<String, dynamic> toJson() {
    return {
      'userCode': userCode,
      'cartData': editedCartData.map((item) => item.toJson()).toList(),
    };
  }

  void printEditOrderRequest() {
    if (kDebugMode) {
      print('========== printEditOrderRequest ==========');
      print('User Code: $userCode');
      for (var item in editedCartData) {
        print('------');
        print('Drug Code: ${item.drugCode}');
        print('Drug Measure: ${item.drugMeasure}');
        print('Drug Quantity: ${item.drugQty}');
        print('Bonus: ${item.bonus}');
        print('Drug Price: ${item.drugPrice}');
        print('Discount: ${item.discount}');
      }
    }
  }
}

class EditedCartData {
  final String drugCode;
  final String drugMeasure;
  final int drugQty;
  final int bonus;
  final double drugPrice;
  final double discount;

  EditedCartData({
    required this.drugCode,
    required this.drugMeasure,
    required this.drugQty,
    required this.bonus,
    required this.drugPrice,
    required this.discount,
  });

  Map<String, dynamic> toJson() {
    return {
      'drugCode': drugCode,
      'drugMeasure': drugMeasure,
      'drugQty': drugQty,
      'bonus': bonus,
      'drugPrice': drugPrice,
      'discount': discount,
    };
  }
}