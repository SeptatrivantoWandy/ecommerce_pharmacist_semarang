import 'package:flutter/material.dart';

class RegisterController {
  IconData securePasswordIcon = Icons.visibility_off_outlined;
  IconData secureConfirmPasswordIcon = Icons.visibility_off_outlined;
  bool isSecure = true;
  bool isSecureConfirm = true;
  String usernameError = "";
  String passwordError = "";
  String confirmPasswordError = "";
  TextEditingController usernameUIController = TextEditingController();
  TextEditingController passwordUIController = TextEditingController();
  TextEditingController confirmPasswordUIController = TextEditingController();

  String namaError = "";
  String alamatError = "";
  String kotaError = "";
  String npwpError = "";
  TextEditingController namaUIController = TextEditingController();
  TextEditingController alamatUIController = TextEditingController();
  TextEditingController kotaUIController = TextEditingController();
  TextEditingController npwpUIController = TextEditingController();

  void viewDidLoad() {}

  void securePasswordTextfieldPressed() {
    isSecure = !isSecure;
    securePasswordIcon =
        isSecure ? Icons.visibility_off_outlined : Icons.visibility_outlined;
  }

  void secureConfirmPasswordTextfieldPressed() {
    isSecureConfirm = !isSecureConfirm;
    secureConfirmPasswordIcon = isSecureConfirm
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
  }

  bool registerButtonPressed(BuildContext context) {
    return false;
  }

  createAccount() {}
}
