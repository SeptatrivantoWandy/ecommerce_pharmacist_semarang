import 'package:flutter/foundation.dart';

class MlgnRequest {
  String username;
  String password;

  MlgnRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  void printMlgnRequest() {
    if (kDebugMode) {
      print('========== printMlgnRequest ==========');
      print('Username: $username');
      print('Password: $password');
    }
  }
}
