import 'package:ecommerce_pharmacist_semarang/mvc/controller/change_password_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/cancel_back_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/confirmation_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/failure_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/loading_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/success_dialog.dart';
import 'package:flutter/material.dart';

class ChangePasswordDialog {
  Future<bool> cancelAlertDialog(BuildContext context) async {
    return (await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => const CancelBackDialog(
                  cancelDialogText:
                      'Apakah kamu yakin untuk membatalkan perubahan?',
                  cancelDialogTitle: 'Batal Perubahan Akun',
                ))) ??
        false;
  }

  void changePasswordAlertDialog(
      BuildContext context, ChangePasswordController changePasswordController) async {
    bool? action = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const ConfirmationDialog(
            confirmDialogTitle: 'Ganti Password',
            confirmDialogText:
                'Apakah kamu yakin data yang dikumpulkan sudah benar untuk dilakukan perubahan?');
      },
    );
    if (action == true) {
      if (context.mounted) {
        loadingAlertDialog(context);
        bool success = await changePasswordController.changePasswordRequest(context);
        if (success) {
          if (context.mounted) {
            Navigator.of(context).pop();
            successAlertDialog(context);
          }
        } else {
          if (context.mounted) {
            Navigator.of(context).pop();
            failureAlertDialog(context, changePasswordController.editUserRequestError);
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
              'Akun berhasil dilakukan perubahan, tim kami akan memberikan informasi melalui Whatsapp atau email apabila anda sudah dapat melakukan login dengan perubahan baru pada aplikasi.',
          isSuccessFromCartPage: false,
        );
      },
    );
  }

  void failureAlertDialog(BuildContext context, String failureErrorCode) {
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return FailureDialog(
          failureDialogText:
              'Terjadi kesalahan teknis, silahkan coba beberapa saat lagi.',
          failureErrorCode: failureErrorCode,
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
              'Data gagal dilakukan perubahan, periksa kembali data yang belum memenuhi syarat.',
          failureErrorCode: '',
        );
      },
    );
  }
}