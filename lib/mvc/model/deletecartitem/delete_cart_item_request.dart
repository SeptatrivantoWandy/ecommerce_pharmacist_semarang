import 'package:flutter/foundation.dart';

class DeleteCartItemRequest {
  final String userCode;
  final String drugCode;
  final String customerCode;

  DeleteCartItemRequest({
    required this.userCode,
    required this.drugCode,
    required this.customerCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'userCode': userCode,
      'drugCode': drugCode,
      'customerCode': customerCode,
    };
  }

  void printDeleteCartItemRequest() {
    if (kDebugMode) {
      print('========== printDeleteCartItemRequest ==========');
      print('User Code: $userCode');
      print('Drug Code: $drugCode');
      print('Customer Code: $customerCode');
    }
  }
}
