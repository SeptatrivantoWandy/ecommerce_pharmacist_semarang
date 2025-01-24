import 'package:ecommerce_pharmacist_semarang/mvc/view/change_password_screen/change_password_view.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/login_screen/login_view.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/settings_screen/settings_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsController {
  SettingsDialog settingsDialog = SettingsDialog();
  final Future<SharedPreferences> futurePrefs = SharedPreferences.getInstance();

  String? username;
  String? name;
  String? userId;
  String? userCode;
  String? isSales;

  String? appName;
  String? packageName;
  String? version;
  String? buildNumber;

  Future<void> viewDidLoad() async {
    await loadUserData();
    await loadPackageInfo();
  }

  Future<void>  loadPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await futurePrefs;
    username = prefs.getString('username');
    name = prefs.getString('name');
    userId = prefs.getString('userId');
    userCode = prefs.getString('userCode');
    isSales = prefs.getString('isSales');
  }

  void changePasswordUIButtonPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const ChangePasswordView(),
      ),
    );
  }

  Future<void> logoutAccount(BuildContext context) async {
    final SharedPreferences prefs = await futurePrefs;
    bool success;
    if (context.mounted) {
      settingsDialog.loadingAlertDialog(context);
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
