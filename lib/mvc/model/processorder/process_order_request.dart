import 'package:flutter/foundation.dart';

class ProcessOrderRequest {
  String orderDate;
  String userCode;
  String customerCode;
  String paymentMethod;

  ProcessOrderRequest({
    required this.orderDate,
    required this.userCode,
    required this.customerCode,
    required this.paymentMethod
  });

  Map<String, dynamic> toJson() {
    return {
      'orderDate': orderDate,
      'userCode': userCode,
      'customerCode': customerCode,
      'paymentMethod': paymentMethod
    };
  }

  void printProcessOrderRequest() {
    if (kDebugMode) {
      print('========== printProcessOrderRequest ==========');
      print('Order Date: $orderDate');
      print('User Code: $userCode');
      print('Customer Code: $customerCode');
      print('Payment Method: $paymentMethod');
    }
  }
}