import 'package:ecommerce_pharmacist_semarang/mvc/model/mlgn/mlgn_request.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/mlgn/mlgn_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/login_screen/login_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/menu_screen/main_menu_view.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/register_screen/register_view.dart';
import 'package:ecommerce_pharmacist_semarang/service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  LoginDialog loginDialog = LoginDialog();

  IconData securePasswordIcon = Icons.visibility_off_outlined;
  bool isSecure = true;
  String usernameError = "";
  String passwordError = "";
  TextEditingController usernameUIController = TextEditingController();
  TextEditingController passwordUIController = TextEditingController();

  final Future<SharedPreferences> futurePrefs = SharedPreferences.getInstance();

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

  Future<void> saveLastSessionDate() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    await prefs.setString('lastSessionDate', now.toIso8601String());
  }

  Future<void> loginAccount(BuildContext context) async {
    final SharedPreferences prefs = await futurePrefs;
    MlgnService service = MlgnService();
    MlgnRequest request = MlgnRequest(
      username: usernameUIController.text,
      password: passwordUIController.text,
    );

    try {
      MlgnResponse response = await service.login(request);
      if (response.status) {
        if (await prefs.setString('username', response.username) &&
            await prefs.setString('name', response.name) &&
            await prefs.setString('userId', response.userId) &&
            await prefs.setString('userCode', response.userCode) &&
            await prefs.setString('isSales', response.isSales)) {
          saveLastSessionDate();
          if (context.mounted) {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const MainMenuView(),
              ),
            );
          }
        }
      } else {
        if (context.mounted) {
          Navigator.of(context).pop();
          loginDialog.failureAlertDialog(context, response.message);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      if (context.mounted) {
        Navigator.of(context).pop();
        loginDialog.failureAlertDialog(
            context, 'An unexpected error occurred.');
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
