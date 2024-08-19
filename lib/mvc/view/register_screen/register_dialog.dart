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
                      'Apakah kamu yakin untuk membatalkan registrasi akun?',
                  cancelDialogTitle: 'Batal Registrasi Akun',
                ))) ??
        false;
  }

  void registerAlertDialog(
      BuildContext context, RegisterController registerController) async {
    bool? action = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const ConfirmationDialog(
            confirmDialogTitle: 'Registrasi Akun Baru',
            confirmDialogText:
                'Apakah kamu yakin data yang dikumpulkan sudah benar untuk dilakukan registrasi?');
      },
    );
    if (action == true) {
      if (context.mounted) {
        loadingAlertDialog(context);
        bool success = await registerController.createAccount();
        if (success) {
          if (context.mounted) {
            Navigator.of(context).pop();
            successAlertDialog(context);
          }
        } else {
          if (context.mounted) {
            Navigator.of(context).pop();
            failureAlertDialog(context);
          }
        }
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
          successDialogText:
              'Akun berhasil di registrasi, tim kami akan memberikan informasi melalui Whatsapp atau email apabila anda sudah dapat melakukan login pada aplikasi',
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
          failureDialogText: 'Terjadi kesalahan teknis, silahkan coba beberapa saat lagi',
        );
      },
    );
  }

  void isNotSatisfied(BuildContext context) {
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const FailureDialog(
          failureDialogText:
              'Data gagal di registrasi, periksa kembali data yang belum memenuhi syarat',
        );
      },
    );
  }
}
