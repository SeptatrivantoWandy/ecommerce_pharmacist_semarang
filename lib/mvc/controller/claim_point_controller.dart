import 'package:flutter/material.dart';

class ClaimPointController {
  String jumlahKlaimError = "";
  String namaBankError = "";
  String nomorRekeningError = "";
  String atasNamaError = "";

  TextEditingController jumlahKlaimUIController = TextEditingController();
  TextEditingController namaBankUIController = TextEditingController();
  TextEditingController nomorRekeningUIController = TextEditingController();
  TextEditingController atasNamaUIController = TextEditingController();

  bool konfirmasiKlaimPointButtonPressed() {
    if (jumlahKlaimUIController.text.isEmpty) {
      jumlahKlaimError = 'Jumlah klaim tidak boleh kosong';
    } else {
      jumlahKlaimError = '';
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
}
