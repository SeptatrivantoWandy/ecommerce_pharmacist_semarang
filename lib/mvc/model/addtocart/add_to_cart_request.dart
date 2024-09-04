import 'package:flutter/foundation.dart';

class AddToCartRequest {
  final String userCode;
  final String drugCode;
  final String drugMeasure;
  final int drugQty;
  final int bonus;
  final double drugPrice;
  final double drugPriceTotal;
  final double discount;

  AddToCartRequest({
    required this.userCode,
    required this.drugCode,
    required this.drugMeasure,
    required this.drugQty,
    required this.bonus,
    required this.drugPrice,
    required this.drugPriceTotal,
    required this.discount,
  });

  // Convert a AddToCartRequest object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'userCode': userCode,
      'drugCode': drugCode,
      'drugMeasure': drugMeasure,
      'drugQty': drugQty,
      'bonus': bonus,
      'drugPrice': drugPrice,
      'drugPriceTotal': drugPriceTotal,
      'discount': discount,
    };
  }

  // Debugging function to print the request details
  void printAddToCartRequest() {
    if (kDebugMode) {
      print('========== printAddToCartRequest ==========');
      print('User Code: $userCode');
      print('Drug Code: $drugCode');
      print('Drug Measure: $drugMeasure');
      print('Drug Quantity: $drugQty');
      print('Bonus: $bonus');
      print('Drug Price: $drugPrice');
      print('Drug Price Total: $drugPriceTotal');
      print('Discount: $discount');
    }
  }
}