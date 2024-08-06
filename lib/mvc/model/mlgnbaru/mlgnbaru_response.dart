import 'package:flutter/foundation.dart';

class MlgnBaruResponse {
  bool status;
  String message;

  MlgnBaruResponse({
    required this.status,
    required this.message,
  });

  factory MlgnBaruResponse.fromJson(Map<String, dynamic> json) {
    return MlgnBaruResponse(
      status: json['status'],
      message: json['message'],
    );
  }

  void printMlgnBaruResponse() {
    if (kDebugMode) {
      print('========== printMlgnBaruResponse ==========');
      print('Status: $status');
      print('Message: $message');
    }
  }
}
