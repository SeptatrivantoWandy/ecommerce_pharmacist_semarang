import 'package:flutter/foundation.dart';

class EditOrderResponse {
  final bool status;
  final String message;

  EditOrderResponse({
    required this.status,
    required this.message,
  });

  factory EditOrderResponse.fromJson(Map<String, dynamic> json) {
    return EditOrderResponse(
      status: json['status'],
      message: json['message'],
    );
  }

  // Method to print the EditOrderResponse object details
  void printEditOrderResponse() {
    if (kDebugMode) {
      print('========== printEditOrderResponse ==========');
      print('Status: $status');
      print('Message: $message');
    }
  }
}