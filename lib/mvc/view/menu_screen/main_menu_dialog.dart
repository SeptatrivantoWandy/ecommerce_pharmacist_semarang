import 'package:ecommerce_pharmacist_semarang/mvc/controller/main_menu_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/agreement_dialog.dart';
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
      BuildContext context, MainMenuController mainMenuController, MainMenuDialog mainMenuDialog) async {
    bool? action = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AgreementDialog(
          agreementTitleText: 'Sesi Berakhir',
          agreementDialogText: 'Aplikasi akan melakukan logout setiap harinya. Silahkan lakukan logout akun.',
          agreementButtonText: 'Logout Akun',
        );
      },
    );
    if (action == true) {
      if (context.mounted) {
        mainMenuController.logoutAccount(context, mainMenuDialog);
      }
    }
  }
}
