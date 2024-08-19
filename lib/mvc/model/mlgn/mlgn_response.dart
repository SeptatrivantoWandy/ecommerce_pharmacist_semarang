import 'package:flutter/foundation.dart';

class MlgnResponse {
  bool status;
  String message;
  String userId;
  String username;
  String userCode;

  MlgnResponse({
    required this.status,
    required this.message,
    required this.userId,
    required this.username,
    required this.userCode,
  });

  factory MlgnResponse.fromJson(Map<String, dynamic> json) {
    return MlgnResponse(
      status: json['status'] ?? false, // Provide a default value if null
      message: json['message'] ?? 'Unknown error', // Handle null message
      userId: json['userId'] ?? '', // Provide a default value for userId
      username: json['username'] ?? '', // Provide a default value for username
      userCode: json['userCode'] ?? '', // Provide a default value for userCode
    );
  }

  void printMlgnResponse() {
    if (kDebugMode) {
      print('========== printMlgnResponse ==========');
      print('Status: $status');
      print('Message: $message');
      print('UserId: $userId');
      print('Username: $username');
      print('UserCode: $userCode');
    }
  }
}
