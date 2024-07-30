import 'dart:async';

import 'package:ecommerce_pharmacist_semarang/mvc/controller/login_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/failure_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/loading_dialog.dart';
import 'package:flutter/material.dart';

class LoginDialog {
  void failureAlertDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const FailureDialog(
          failureDialogText: 'Error login, try again later',
        );
      },
    );
  }

  void loadingAlertDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingDialog();
      },
    );
  }

  void loading(BuildContext context, LoginController loginController) {
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).pop();
        loginController.loginAccount(context);
        // failureAlertDialog(context);
      },
    );
  }
}