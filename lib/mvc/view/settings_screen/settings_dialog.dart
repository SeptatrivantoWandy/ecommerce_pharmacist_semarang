import 'package:ecommerce_pharmacist_semarang/mvc/controller/settings_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/confirmation_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/loading_dialog.dart';
import 'package:flutter/material.dart';

class SettingsDialog {
  void loadingAlertDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingDialog();
      },
    );
  }

  Future<void> logoutAlertDialog(
      BuildContext context, SettingsController settingsController) async {
    bool? action = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const ConfirmationDialog(
            confirmDialogTitle: 'Logout Akun',
            confirmDialogText:
                'Logout akun anda sekarang? Anda harus melakukan login kembali untuk menggunakan aplikasi ini setelah melakukan logout');
      },
    );
    if (action == true) {
      if (context.mounted) {
        settingsController.logoutAccount(context);
      }
    }
  }
}
