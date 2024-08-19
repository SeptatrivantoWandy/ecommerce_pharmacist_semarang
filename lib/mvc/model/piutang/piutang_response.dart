import 'package:flutter/foundation.dart';

class PiutangResponse {
  final bool status;
  final String message;
  final List<PiutangData> piutangData;

  PiutangResponse({
    required this.status,
    required this.message,
    required this.piutangData,
  });

  factory PiutangResponse.fromJson(Map<String, dynamic> json) {
    var piutangList = json['piutangData'] as List;
    List<PiutangData> piutangDataList =
        piutangList.map((i) => PiutangData.fromJson(i)).toList();

    return PiutangResponse(
      status: json['status'],
      message: json['message'],
      piutangData: piutangDataList,
    );
  }

  void printPiutangResponse() {
    if (kDebugMode) {
      print('========== printPiutangResponse ==========');
      print('Status: $status');
      print('Message: $message');
      print('Piutang Data:');
      for (var piutang in piutangData) {
        print('User Code: ${piutang.userCode}');
        print('Invoice No: ${piutang.invoiceNo}');
        print('Invoice Date: ${piutang.invoiceDate}');
        print('Invoice Due Date: ${piutang.invoiceDueDate}');
        print('Balance: ${piutang.balance}');
        print('---');
      }
    }
  }
}

class PiutangData {
  final String userCode;
  final String invoiceNo;
  final String invoiceDate;
  final String invoiceDueDate;
  final String balance;

  PiutangData({
    required this.userCode,
    required this.invoiceNo,
    required this.invoiceDate,
    required this.invoiceDueDate,
    required this.balance,
  });

  factory PiutangData.fromJson(Map<String, dynamic> json) {
    return PiutangData(
      userCode: json['userCode'],
      invoiceNo: json['invoiceNo'],
      invoiceDate: json['invoiceDate'],
      invoiceDueDate: json['invoiceDueDate'],
      balance: json['balance'],
    );
  }
}
