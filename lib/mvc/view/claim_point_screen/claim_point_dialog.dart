import 'package:ecommerce_pharmacist_semarang/mvc/controller/claim_point_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/cancel_back_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/confirmation_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/failure_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/loading_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/success_dialog.dart';
import 'package:flutter/material.dart';

class ClaimPointDialog {
  void claimPointAlertDialog(
    BuildContext context,
    ClaimPointController claimPointController,
    String userCode,
  ) async {
    bool? action = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const ConfirmationDialog(
            confirmDialogTitle: 'Klaim Saldo Poin',
            confirmDialogText:
                'Apakah kamu yakin data yang dikumpulkan sudah benar untuk melakukan proses klaim saldo poin?');
      },
    );
    if (action == true) {
      if (context.mounted) {
        loadingAlertDialog(context);
        bool success = await claimPointController.claimPointsRequest(userCode);
        if (success) {
          if (context.mounted) {
            Navigator.of(context).pop();
            successAlertDialog(context);
          }
        } else {
          if (context.mounted) {
            Navigator.of(context).pop();
            failureAlertDialog(context, claimPointController);
          }
        }
      }
    }
  }

  Future<bool> cancelAlertDialog(BuildContext context) async {
    return (await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => const CancelBackDialog(
                  cancelDialogText:
                      'Apakah kamu yakin untuk membatalkan klaim poin?',
                  cancelDialogTitle: 'Batal Klaim Poin',
                ))) ??
        false;
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
              'Saldo point berhasil di ajukan, silahkan tunggu beberapa saat untuk dilakukan verifikasi internal agar dapat ditransfer ke nomor rekening tujuan.',
          isPopAgain: true,
        );
      },
    );
  }

  void failureAlertDialog(BuildContext context, ClaimPointController claimPointController) {
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return FailureDialog(
          failureDialogText:
              'Terjadi kesalahan teknis, silahkan coba beberapa saat lagi.',
          failureErrorCode: claimPointController.claimPointError,
        );
      },
    );
  }
}
