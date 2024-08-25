import 'package:flutter/foundation.dart';

class AddToCartResponse {
  final bool status;
  final bool exist;
  final String message;

  AddToCartResponse({
    required this.status,
    required this.exist,
    required this.message,
  });

  // Factory constructor to create an instance of AddToCartResponse from a JSON map
  factory AddToCartResponse.fromJson(Map<String, dynamic> json) {
    return AddToCartResponse(
      status: json['status'],
      exist: json['exist'],
      message: json['message'],
    );
  }

  // Debugging function to print the response details
  void printAddToCartResponse() {
    if (kDebugMode) {
      print('========== printAddToCartResponse ==========');
      print('Status: $status');
      print('Exist: $exist');
      print('Message: $message');
    }
  }
}