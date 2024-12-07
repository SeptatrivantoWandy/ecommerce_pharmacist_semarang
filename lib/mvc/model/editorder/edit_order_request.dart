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
        print('Drug Price Total: ${item.drugPriceTotal}');
        print('Discount: ${item.discount}');
      }
    }
  }
}

class EditedCartData {
  final String drugCode;
  final String customerCode;
  final String drugMeasure;
  final int drugQty;
  final int bonus;
  final double drugPrice;
  final double drugPriceTotal;
  final double discount;

  EditedCartData({
    required this.drugCode,
    required this.customerCode,
    required this.drugMeasure,
    required this.drugQty,
    required this.bonus,
    required this.drugPrice,
    required this.drugPriceTotal,
    required this.discount,
  });

  Map<String, dynamic> toJson() {
    return {
      'drugCode': drugCode,
      'customerCode': customerCode,
      'drugMeasure': drugMeasure,
      'drugQty': drugQty,
      'bonus': bonus,
      'drugPrice': drugPrice,
      'drugPriceTotal': drugPriceTotal,
      'discount': discount,
    };
  }
}
