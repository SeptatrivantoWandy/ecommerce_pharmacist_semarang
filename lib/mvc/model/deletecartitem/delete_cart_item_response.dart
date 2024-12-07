import 'package:flutter/foundation.dart';

class DeleteCartItemResponse {
  final bool status;
  final String message;

  DeleteCartItemResponse({
    required this.status,
    required this.message,
  });

  factory DeleteCartItemResponse.fromJson(Map<String, dynamic> json) {
    return DeleteCartItemResponse(
      status: json['status'] ?? false, // Default to false if null
      message: json['message'] ?? 'Unknown error', // Handle null message
    );
  }

  void printDeleteCartItemResponse() {
    if (kDebugMode) {
      print('========== printDeleteCartItemResponse ==========');
      print('Status: $status');
      print('Message: $message');
    }
  }
}