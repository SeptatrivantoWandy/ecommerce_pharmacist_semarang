import 'package:flutter/foundation.dart';

class ProcessOrderRequest {
  String orderDate;
  String userCode;

  ProcessOrderRequest({
    required this.orderDate,
    required this.userCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderDate': orderDate,
      'userCode': userCode,
    };
  }

  void printProcessOrderRequest() {
    if (kDebugMode) {
      print('========== printProcessOrderRequest ==========');
      print('Order Date: $orderDate');
      print('User Code: $userCode');
    }
  }
}