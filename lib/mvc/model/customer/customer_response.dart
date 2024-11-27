import 'package:flutter/foundation.dart';

class CustomerResponse {
  final bool status;
  final String message;
  final List<CustomerData> customerData;

  CustomerResponse({
    required this.status,
    required this.message,
    required this.customerData,
  });

  factory CustomerResponse.fromJson(Map<String, dynamic> json) {
    var customerList = json['customerData'] as List;
    List<CustomerData> customerDataList =
        customerList.map((i) => CustomerData.fromJson(i)).toList();

    return CustomerResponse(
      status: json['status'],
      message: json['message'],
      customerData: customerDataList,
    );
  }

  void printCustomerResponse() {
    if (kDebugMode) {
      print('========== Customer Response ==========');
      print('Status: $status');
      print('Message: $message');
      print('Customer Data:');
      for (var customer in customerData) {
        print('Customer Code: ${customer.customerCode}');
        print('Customer Name: ${customer.customerName}');
        print('---');
      }
    }
  }
}

class CustomerData {
  final String customerCode;
  final String customerName;

  CustomerData({
    required this.customerCode,
    required this.customerName,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      customerCode: json['customerCode'],
      customerName: json['customerName'],
    );
  }
}
