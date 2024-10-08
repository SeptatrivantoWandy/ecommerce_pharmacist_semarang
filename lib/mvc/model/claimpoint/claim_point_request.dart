import 'package:flutter/foundation.dart';

class ClaimPointRequest {
  String userCode;
  String claimDate;
  int totalPoint;
  String bankName;
  String bankAccountNumber;
  String bankAccountName;

  ClaimPointRequest({
    required this.userCode,
    required this.claimDate,
    required this.totalPoint,
    required this.bankName,
    required this.bankAccountNumber,
    required this.bankAccountName,
  });

  Map<String, dynamic> toJson() {
    return {
      'userCode': userCode,
      'claimDate': claimDate,
      'totalPoint': totalPoint,
      'bankName': bankName,
      'bankAccountNumber': bankAccountNumber,
      'bankAccountName': bankAccountName,
    };
  }

  void printClaimPointRequest() {
    if (kDebugMode) {
      print('========== ClaimPointRequest ==========');
      print('UserCode: $userCode');
      print('ClaimDate: $claimDate');
      print('TotalPoint: $totalPoint');
      print('BankName: $bankName');
      print('BankAccountNumber: $bankAccountNumber');
      print('BankAccountName: $bankAccountName');
    }
  }
}
