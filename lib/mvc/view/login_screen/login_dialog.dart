import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/failure_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/loading_dialog.dart';
import 'package:flutter/material.dart';

class LoginDialog {
  void failureAlertDialog(BuildContext context, String failureText) {
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return FailureDialog(
          failureDialogText: failureText,
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
}
