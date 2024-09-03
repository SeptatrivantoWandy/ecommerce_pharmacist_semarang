import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/confirmation_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/failure_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/loading_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/success_dialog.dart';
import 'package:flutter/material.dart';

class CartDialog {
  Future<bool> confirmOrderAlertDialog(
      BuildContext context) async {
    bool? action = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const ConfirmationDialog(
            confirmDialogTitle: 'Konfirmasi Order',
            confirmDialogText:
                'Apakah kamu yakin data keranjang belanja sudah benar untuk diajukan konfirmasi order?');
      },
    );
    if (action == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> confirmDeleteItemAlertDialog(
      BuildContext context) async {
    bool? action = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const ConfirmationDialog(
            confirmDialogTitle: 'Hapus Produk',
            confirmDialogText:
                'Apakah kamu yakin untuk menghapus produk ini dari keranjang belanja?');
      },
    );
    if (action == true) {
      return true;
    } else {
      return false;
    }
  }

  void successAlertDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const SuccessDialog(
          successDialogText:
              'Keranjang belanja berhasil diajukan, silahkan tunggu beberapa saat untuk dilakukan konfirmasi internal agar dapat melanjutkan proses transaksi.',
          isPopAgain: true,
        );
      },
    );
  }

  void failureAlertDialog(
    BuildContext context,
    String failureText,
    String failureErrorCode,
  ) {
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
