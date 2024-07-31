import 'dart:async';

import 'package:ecommerce_pharmacist_semarang/mvc/controller/register_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/cancel_back_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/confirmation_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/failure_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/loading_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/success_dialog.dart';
import 'package:flutter/material.dart';

class RegisterDialog {

  Future<bool> cancelAlertDialog(BuildContext context) async {
    return (await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => const CancelBackDialog(
                  cancelDialogText:
                      'Are you sure to cancel register your account?',
                  cancelDialogTitle: 'Cancel Register Account',
                ))) ??
        false;
  }

  void registerAlertDialog(BuildContext context, RegisterController registerController) async {
    bool? action = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const ConfirmationDialog(
            confirmDialogTitle: 'Register New Account',
            confirmDialogText:
                'Are you sure your data is correct to register?');
      },
    );
    if (action == true) {
      if (context.mounted) {
        registerController.createAccount();
        loadingAlertDialog(context);
        loading(context);
      }
    }
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

  void successAlertDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const SuccessDialog(
          successDialogText: 'Account registered successfully',
        );
      },
    );
  }

  void failureAlertDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const FailureDialog(
          failureDialogText: 'Account unsuccessfully registered, try again later',
        );
      },
    );
  }

  void loading(BuildContext context) {
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).pop();
        successAlertDialog(context);
        // failureAlertDialog(context);
      },
    );
  }
}
