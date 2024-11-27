import 'package:flutter/foundation.dart';

class EditUserResponse {
  final bool status;
  final String message;

  EditUserResponse({
    required this.status,
    required this.message,
  });

  // Factory constructor to create an instance from JSON
  factory EditUserResponse.fromJson(Map<String, dynamic> json) {
    return EditUserResponse(
      status: json['status'],
      message: json['message'],
    );
  }

  // Method to print the EditUserResponse object details
  void printEditUserResponse() {
    if (kDebugMode) {
      print('========== printEditUserResponse ==========');
      print('Status: $status');
      print('Message: $message');
    }
  }
}