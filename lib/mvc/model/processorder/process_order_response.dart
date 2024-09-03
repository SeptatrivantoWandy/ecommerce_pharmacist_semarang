import 'package:flutter/foundation.dart';

class ProcessOrderResponse {
  bool status;
  String message;

  ProcessOrderResponse({
    required this.status,
    required this.message,
  });

  factory ProcessOrderResponse.fromJson(Map<String, dynamic> json) {
    return ProcessOrderResponse(
      status: json['status'] ?? false, // Provide a default value if null
      message: json['message'] ?? 'Unknown error', // Handle null message
    );
  }

  void printProcessOrderResponse() {
    if (kDebugMode) {
      print('========== printProcessOrderResponse ==========');
      print('Status: $status');
      print('Message: $message');
    }
  }
}