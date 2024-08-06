import 'package:flutter/foundation.dart';

class MlgnResponse {
  bool status;
  String message;
  String userId;
  String username;

  MlgnResponse({
    required this.status,
    required this.message,
    required this.userId,
    required this.username,
  });

  factory MlgnResponse.fromJson(Map<String, dynamic> json) {
    return MlgnResponse(
      status: json['status'],
      message: json['message'],
      userId: json['userId'],
      username: json['username'],
    );
  }

  void printMlgnResponse() {
    if (kDebugMode) {
      print('========== printMlgnResponse ==========');
      print('Status: $status');
      print('Message: $message');
      print('UserId: $userId');
      print('Username: $username');
    }
  }
}
