import 'package:ecommerce_pharmacist_semarang/mvc/view/login_screen/login_view.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/menu_screen/main_menu_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/order_screen/order_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenuController {
  MainMenuDialog mainMenuDialog = MainMenuDialog();
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
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => const LoginView(),
          ),
        );
      }
    }
  }

  void orderPesananFeaturePressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const OrderView(),
      ),
    );
  }
}
