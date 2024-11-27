import 'package:flutter/foundation.dart';

class ProcessOrderRequest {
  String orderDate;
  String userCode;
  String paymentMethod;

  ProcessOrderRequest({
    required this.orderDate,
    required this.userCode,
    required this.paymentMethod
  });

  Map<String, dynamic> toJson() {
    return {
      'orderDate': orderDate,
      'userCode': userCode,
      'paymentMethod': paymentMethod
    };
  }

  void printProcessOrderRequest() {
    if (kDebugMode) {
      print('========== printProcessOrderRequest ==========');
      print('Order Date: $orderDate');
      print('User Code: $userCode');
      print('Payment Method: $paymentMethod');
    }
  }
}