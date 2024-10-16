import 'package:ecommerce_pharmacist_semarang/mvc/view/login_screen/login_view.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/settings_screen/settings_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController {
  SettingsDialog mainMenuDialog = SettingsDialog();
  final Future<SharedPreferences> futurePrefs = SharedPreferences.getInstance();
  
  Future<void> logoutAccount(BuildContext context) async {
    final SharedPreferences prefs = await futurePrefs;
    bool success;
    if (context.mounted) {
      mainMenuDialog.loadingAlertDialog(context);
    }
    success = await prefs.clear();
    if (success) {
      if (context.mounted) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => const LoginView(),
          ),
        );
      }
    }
  }
}