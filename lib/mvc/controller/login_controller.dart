import 'package:ecommerce_pharmacist_semarang/mvc/view/menu_screen/menu_view.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/register_screen/register_view.dart';
import 'package:flutter/material.dart';

class LoginController {

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
      passwordError = "Password tidak boleh kosong!";
    } else {
      passwordError = "";
    }

    if (usernameUIController.text.isEmpty) {
      usernameError = "Username tidak boleh kosong!";
    } else {
      usernameError = "";
    }

    if (usernameError.isEmpty && passwordError.isEmpty) {
      return true;
    }
    return false;
  }

  loginAccount(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const MenuView(),
      ),
    );
  }

  void registerButtonPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const RegisterView(),
      ),
    );
  }

}