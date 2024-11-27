import 'package:ecommerce_pharmacist_semarang/mvc/model/edituser/edit_user_request.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/edituser/edit_user_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/change_password_screen/change_password_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordController {
  ChangePasswordDialog changePasswordDialog = ChangePasswordDialog();
  // SettingsController settingsController = SettingsController();
  final Future<SharedPreferences> futurePrefs = SharedPreferences.getInstance();

  IconData securePasswordIcon = Icons.visibility_off_outlined;
  bool isSecure = true;
  String usernameError = "";
  String passwordError = "";
  String editUserRequestError = '';
  TextEditingController usernameUIController = TextEditingController();
  TextEditingController passwordUIController = TextEditingController();

  String? username;
  String? userCode;

  void viewDidLoad() async {
    await loadUserData();
    usernameUIController.text = username ?? '';
  }

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await futurePrefs;
    username = prefs.getString('username');
    userCode = prefs.getString('userCode');
  }

  void securePasswordTextfieldPressed() {
    isSecure = !isSecure;
    securePasswordIcon =
        isSecure ? Icons.visibility_off_outlined : Icons.visibility_outlined;
  }

  bool changePasswordButtonPressed() {
    if (passwordUIController.text.isEmpty) {
      passwordError = "Password tidak boleh kosong";
    } else {
      passwordError = "";
    }

    if (usernameUIController.text.isEmpty) {
      usernameError = "Username tidak boleh kosong";
    } else {
      usernameError = "";
    }

    if (usernameError.isEmpty && passwordError.isEmpty) {
      return true;
    }
    return false;
  }

  Future<bool> changePasswordRequest(BuildContext context) async {
    editUserRequestError = '';
    EditUserService service = EditUserService();

    EditUserRequest request = EditUserRequest(
      userCode: userCode!,
      userName: usernameUIController.text,
      newPassword: passwordUIController.text,
    );

    try {
      EditUserResponse response = await service.editUser(request);
      // Handle the response
      if (response.status) {
        editUserRequestError = '';
        return response.status;
      } else {
        editUserRequestError = response.message;
        return response.status;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return false;
    }
  }
}
