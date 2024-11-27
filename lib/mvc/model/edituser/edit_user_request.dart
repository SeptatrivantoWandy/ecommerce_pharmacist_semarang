import 'package:flutter/foundation.dart';

class EditUserRequest {
  final String userCode;
  final String userName;
  final String newPassword;

  EditUserRequest({
    required this.userCode,
    required this.userName,
    required this.newPassword,
  });

  // Convert the EditUserRequest object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'userCode': userCode,
      'userName': userName,
      'newPassword': newPassword,
    };
  }

  // Debugging function to print the request details
  void printEditUserRequest() {
    if (kDebugMode) {
      print('========== printEditUserRequest ==========');
      print('User Code: $userCode');
      print('User Name: $userName');
      print('New Password: $newPassword');
    }
  }
}