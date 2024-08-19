import 'package:flutter/foundation.dart';

class HistoryResponse {
  bool status;
  String message;
  List<HistoryData> orderHistoryData;

  HistoryResponse({
    required this.status,
    required this.message,
    required this.orderHistoryData,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    return HistoryResponse(
      status: json['status'],
      message: json['message'],
      orderHistoryData: List<HistoryData>.from(
        json['orderHistoryData'].map((data) => HistoryData.fromJson(data)),
      ),
    );
  }

  void printHistoryResponse() {
    if (kDebugMode) {
      print('========== printHistoryResponse ==========');
      print("Status: $status");
      print("Message: $message");
      for (var order in orderHistoryData) {
        print("\nOrder No: ${order.orderNo}");
        print("Order Date: ${order.orderDate}");
        print("Order Status: ${order.orderStatus}");
        print("Order Total: ${order.orderTotal}");
        for (var drug in order.drugData) {
          print("  Drug Name: ${drug.drugName}");
          print("  Drug Measure: ${drug.drugMeasure}");
          print("  Order Quantity: ${drug.orderQty}");
          print("  Bonus: ${drug.bonus}");
          print("  Drug Price: ${drug.drugPrice}");
          print("  Discount: ${drug.discount}");
          print("  Drug Price Total: ${drug.drugPriceTotal}");
        }
      }
    }
  }
}

class HistoryData {
  String orderNo;
  String orderDate;
  String orderStatus;
  String orderTotal;
  List<HistoryDrugData> drugData;

  HistoryData({
    required this.orderNo,
    required this.orderDate,
    required this.orderStatus,
    required this.orderTotal,
    required this.drugData,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(
      orderNo: json['orderNo'],
      orderDate: json['orderDate'],
      orderStatus: json['orderStatus'],
      orderTotal: json['orderTotal'].toString(),
      drugData: List<HistoryDrugData>.from(
        json['drugData'].map((data) => HistoryDrugData.fromJson(data)),
      ),
    );
  }
}

class HistoryDrugData {
  String drugName;
  String drugMeasure;
  String orderQty;
  String bonus;
  String drugPrice;
  String discount;
  String drugPriceTotal;

  HistoryDrugData({
    required this.drugName,
    required this.drugMeasure,
    required this.orderQty,
    required this.bonus,
    required this.drugPrice,
    required this.discount,
    required this.drugPriceTotal,
  });

  factory HistoryDrugData.fromJson(Map<String, dynamic> json) {
    return HistoryDrugData(
      drugName: json['drugName'],
      drugMeasure: json['drugMeasure'],
      orderQty: json['orderQty'],
      bonus: json['bonus'],
      drugPrice: json['drugPrice'],
      discount: json['discount'],
      drugPriceTotal: json['drugPriceTotal'],
    );
  }
}
