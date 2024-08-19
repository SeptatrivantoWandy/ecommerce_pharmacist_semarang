import 'package:flutter/foundation.dart';

class PointResponse {
  bool status;
  String message;
  List<SaldoPointData> saldoPointData;

  PointResponse({
    required this.status,
    required this.message,
    required this.saldoPointData,
  });

  factory PointResponse.fromJson(Map<String, dynamic> json) {
    return PointResponse(
      status: json['status'],
      message: json['message'],
      saldoPointData: List<SaldoPointData>.from(
        json['saldoPointData'].map((data) => SaldoPointData.fromJson(data)),
      ),
    );
  }

  void printPointResponse() {
    if (kDebugMode) {
      print('========== printPointResponse ==========');
      print('Status: $status');
      print('Message: $message');
      print('Saldo Point Data:');
      for (var data in saldoPointData) {
        print('User Code: ${data.userCode}');
        print('Point Date: ${data.pointDate}');
        print('Notes: ${data.notes}');
        print('Point In: ${data.pointIn}');
        print('Point Out: ${data.pointOut}');
        print('Total Point: ${data.totalPoint}');
        print('---');
      }
    }
  }
}

class SaldoPointData {
  String userCode;
  String pointDate;
  String notes;
  String pointIn;
  String pointOut;
  String totalPoint;

  SaldoPointData({
    required this.userCode,
    required this.pointDate,
    required this.notes,
    required this.pointIn,
    required this.pointOut,
    required this.totalPoint,
  });

  factory SaldoPointData.fromJson(Map<String, dynamic> json) {
    return SaldoPointData(
      userCode: json['userCode'],
      pointDate: json['pointDate'],
      notes: json['notes'],
      pointIn: json['pointIn'],
      pointOut: json['pointOut'],
      totalPoint: json['totalPoint'],
    );
  }
}
