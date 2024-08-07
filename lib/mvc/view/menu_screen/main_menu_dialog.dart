import 'package:ecommerce_pharmacist_semarang/mvc/controller/main_menu_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/confirmation_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/loading_dialog.dart';
import 'package:flutter/material.dart';

class MainMenuDialog {
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
      BuildContext context, MainMenuController menuController) async {
    bool? action = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const ConfirmationDialog(
            confirmDialogTitle: 'Logut Akun',
            confirmDialogText:
                'Logut akun anda sekarang? Anda harus melakukan login kembali untuk menggunakan aplikasi ini setelah melakukan logout');
      },
    );
    if (action == true) {
      if (context.mounted) {
        menuController.logoutAccount(context);
      }
    }
  }
}
