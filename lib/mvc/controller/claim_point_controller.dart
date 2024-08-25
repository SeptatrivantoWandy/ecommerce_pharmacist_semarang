import 'package:ecommerce_pharmacist_semarang/mvc/model/claimpoint/claim_point_request.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/claimpoint/claim_point_response.dart';
import 'package:ecommerce_pharmacist_semarang/service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClaimPointController {
  String jumlahKlaimError = "";
  String namaBankError = "";
  String nomorRekeningError = "";
  String atasNamaError = "";

  String claimPointError = '';

  TextEditingController jumlahKlaimUIController =
      TextEditingController(text: '0');
  TextEditingController namaBankUIController = TextEditingController();
  TextEditingController nomorRekeningUIController = TextEditingController();
  TextEditingController atasNamaUIController = TextEditingController();

  String? sisaSaldo;

  bool konfirmasiKlaimPointButtonPressed() {
    if (jumlahKlaimUIController.text == '0') {
      jumlahKlaimError = 'Jumlah klaim tidak boleh kosong';
    } else {
      if (double.parse(sisaSaldo!.replaceAll('.', '')) < 0) {
        jumlahKlaimError = 'Jumlah klaim melebihi total saldo poin';
      } else {
        jumlahKlaimError = '';
      }
    }

    if (namaBankUIController.text.isEmpty) {
      namaBankError = 'Nama bank tidak boleh kosong';
    } else {
      namaBankError = '';
    }

    if (nomorRekeningUIController.text.isEmpty) {
      nomorRekeningError = 'Nomor Rekening tidak boleh kosong';
    } else {
      nomorRekeningError = '';
    }

    if (atasNamaUIController.text.isEmpty) {
      atasNamaError = 'Atas nama tidak boleh kosong';
    } else {
      atasNamaError = '';
    }

    if (jumlahKlaimError.isEmpty &&
        namaBankError.isEmpty &&
        nomorRekeningError.isEmpty &&
        atasNamaError.isEmpty) {
      return true;
    }

    return false;
  }

  String formatBalance(String balance) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    );
    double parsedBalance = double.parse(balance);
    return currencyFormat.format(parsedBalance);
  }

  void jumlahKlaimUITextFieldChanged(String value, String? totalSaldoPoint) {
    jumlahKlaimUIController.text = formatBalance(value);
    double doubleSisaSaldo =
        double.parse(totalSaldoPoint!) - double.parse(value);
    sisaSaldo = formatBalance(doubleSisaSaldo.toString());
  }

  Future<bool> claimPointsRequest(String userCode) async {
    claimPointError = '';
    ClaimPointService service = ClaimPointService();

    ClaimPointRequest request = ClaimPointRequest(
      userCode: userCode,
      claimDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      invoiceNumber: "A009224082001",
      totalPoint: int.parse(jumlahKlaimUIController.text.replaceAll('.', '')),
      bankName: namaBankUIController.text,
      bankAccountNumber: nomorRekeningUIController.text,
      bankAccountName: namaBankUIController.text,
    );
    try {
      ClaimPointResponse response = await service.claimPoints(request);
      // Handle the response
      if (response.status) {
        claimPointError = '';
        return response.status;
      } else {
        claimPointError = response.message;
        return response.status;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return false;
    }
  }
}
