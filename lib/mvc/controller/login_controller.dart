import 'package:ecommerce_pharmacist_semarang/mvc/view/login_screen/login_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/menu_screen/menu_view.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/register_screen/register_view.dart';
import 'package:flutter/material.dart';

class LoginController {
  LoginDialog loginDialog = LoginDialog();

  IconData securePasswordIcon = Icons.visibility_off_outlined;
  bool isSecure = true;
  String usernameError = "";
  String passwordError = "";
  TextEditingController usernameUIController = TextEditingController();
  TextEditingController passwordUIController = TextEditingController();

  void viewDidLoad() {}

  void securePasswordTextfieldPressed() {
    isSecure = !isSecure;
    securePasswordIcon =
        isSecure ? Icons.visibility_off_outlined : Icons.visibility_outlined;
  }

  bool loginButtonPressed() {
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

  loginAccount(BuildContext context) async {
    bool success = false;
    await Future.delayed(const Duration(seconds: 2), () {
      print('Login success');
      success = true; // Set this based on your actual account creation logic
    });
    if (context.mounted) {
      Navigator.of(context).pop();
    }
    if (success) {
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => const MenuView(),
          ),
        );
      }
    } else {
      if (context.mounted) {
        loginDialog.failureAlertDialog(context);
      }
    }
  }

  void registerButtonPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const RegisterView(),
      ),
    );
  }
}
