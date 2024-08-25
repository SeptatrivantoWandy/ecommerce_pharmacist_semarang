import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/failure_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/loading_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/success_dialog.dart';
import 'package:flutter/material.dart';

class OrderDialog {
  void successAlertDialog(BuildContext context, String successText) {
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SuccessDialog(
          successDialogText: successText,
          isPopAgain: true,
        );
      },
    );
  }

  void failureAlertDialog(BuildContext context, String failureText, String failureErrorCode) {
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return FailureDialog(
          failureDialogText: failureText,
          failureErrorCode: failureErrorCode,
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
