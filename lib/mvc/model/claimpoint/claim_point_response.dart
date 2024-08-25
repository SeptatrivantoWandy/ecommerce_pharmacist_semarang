import 'package:flutter/foundation.dart';

class ClaimPointResponse {
  bool status;
  String message;

  ClaimPointResponse({
    required this.status,
    required this.message,
  });

  factory ClaimPointResponse.fromJson(Map<String, dynamic> json) {
    return ClaimPointResponse(
      status: json['status'],
      message: json['message'],
    );
  }

  void printClaimPointResponse() {
    if (kDebugMode) {
      print('========== ClaimPointResponse ==========');
      print('Status: $status');
      print('Message: $message');
    }
  }
}
