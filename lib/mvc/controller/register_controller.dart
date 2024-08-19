import 'dart:async';
import 'dart:io';

import 'package:ecommerce_pharmacist_semarang/mvc/model/mlgnbaru/mlgnbaru_request.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/mlgnbaru/mlgnbaru_response.dart';
import 'package:ecommerce_pharmacist_semarang/service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class RegisterController {
  IconData securePasswordIcon = Icons.visibility_off_outlined;
  IconData secureConfirmPasswordIcon = Icons.visibility_off_outlined;
  bool isSecure = true;
  bool isSecureConfirm = true;
  String usernameError = '';
  String passwordError = '';
  String confirmPasswordError = '';
  String namaApotekError = '';
  String alamatError = '';
  String kotaError = '';
  String nomorTeleponError = '';
  String emailError = '';
  String nomorIzinApotekError = '';
  String fotoSIAError = '';
  String izinApotekBerlakuSampaiError = '';
  String namaApotekerError = '';
  String nomorIzinApotekerError = '';
  String fotoSIPAError = '';
  String nomorApotekerBerlakuSampaiError = "";
  TextEditingController usernameUIController = TextEditingController();
  TextEditingController passwordUIController = TextEditingController();
  TextEditingController confirmPasswordUIController = TextEditingController();
  TextEditingController namaApotekUIController = TextEditingController();
  TextEditingController alamatUIController = TextEditingController();
  TextEditingController kotaUIController = TextEditingController();
  TextEditingController nomorTeleponUIController = TextEditingController();
  TextEditingController emailUIController = TextEditingController();
  TextEditingController nomorIzinApotekUIController = TextEditingController();
  File? fotoSIAImagePicker;
  TextEditingController izinApotekBerlakuSampaiUIController =
      TextEditingController();
  TextEditingController namaApotekerUIController = TextEditingController();
  TextEditingController nomorIzinApotekerUIController = TextEditingController();
  File? fotoSIPAImagePicker;
  TextEditingController nomorApotekerBerlakuSampaiUIController =
      TextEditingController();

  DateTime? izinApotekBerlakuSelectedDate;
  DateTime? nomorApotekerBerlakuSelectedDate;

  String namaFakturError = "";
  String alamatFakturError = "";
  String kotaFakturError = "";
  String npwpFakturError = "";
  TextEditingController namaFakturUIController = TextEditingController();
  TextEditingController alamatFakturUIController = TextEditingController();
  TextEditingController kotaFakturUIController = TextEditingController();
  TextEditingController npwpFakturUIController = TextEditingController();

  void viewDidLoad() {}

  void securePasswordTextfieldPressed() {
    isSecure = !isSecure;
    securePasswordIcon =
        isSecure ? Icons.visibility_off_outlined : Icons.visibility_outlined;
  }

  void secureConfirmPasswordTextfieldPressed() {
    isSecureConfirm = !isSecureConfirm;
    secureConfirmPasswordIcon = isSecureConfirm
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
  }

  void izinApotekBerlakuSampaiDatePickerPressed(BuildContext context) async {
    await initializeDateFormatting('id_ID', null);

    final now = DateTime.now();
    final initialDate = izinApotekBerlakuSelectedDate ?? DateTime.now();
    final firstDate = DateTime(now.month, now.day);

    if (context.mounted) {
      final pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: DateTime(now.year + 10),
      );
      izinApotekBerlakuSelectedDate =
          pickedDate ?? izinApotekBerlakuSelectedDate ?? now;
    }

    // Define the output format
    DateFormat dayFormat = DateFormat('d'); // Single digit day format
    DateFormat monthYearFormat = DateFormat('MMMM yyyy', 'id_ID');

    // Format the day, month, and year separately
    String formattedDay = dayFormat.format(izinApotekBerlakuSelectedDate!);
    String formattedMonthYear =
        monthYearFormat.format(izinApotekBerlakuSelectedDate!);

    // Combine the formatted parts
    String formattedDate = '$formattedDay $formattedMonthYear';

    izinApotekBerlakuSampaiUIController.text = formattedDate;
  }

  void nomorApotekerBerlakuSampaiDatePickerPressed(BuildContext context) async {
    await initializeDateFormatting('id_ID', null);

    final now = DateTime.now();
    final initialDate = nomorApotekerBerlakuSelectedDate ?? DateTime.now();
    final firstDate = DateTime(now.month, now.day);
    if (context.mounted) {
      final pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: DateTime(now.year + 10),
      );
      nomorApotekerBerlakuSelectedDate =
          pickedDate ?? nomorApotekerBerlakuSelectedDate ?? now;
    }
    // Define the output format
    DateFormat dayFormat = DateFormat('d'); // Single digit day format
    DateFormat monthYearFormat = DateFormat('MMMM yyyy', 'id_ID');

    // Format the day, month, and year separately
    String formattedDay = dayFormat.format(nomorApotekerBerlakuSelectedDate!);
    String formattedMonthYear =
        monthYearFormat.format(nomorApotekerBerlakuSelectedDate!);

    // Combine the formatted parts
    String formattedDate = '$formattedDay $formattedMonthYear';
    nomorApotekerBerlakuSampaiUIController.text = formattedDate;
  }

  Future pickImageFromGallery(String fotoDari) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) {
      return;
    } else {
      if (fotoDari == 'SIA') {
        fotoSIAImagePicker = File(returnedImage.path);
        return;
      } else if (fotoDari == 'SIPA') {
        fotoSIPAImagePicker = File(returnedImage.path);
        return;
      }
      return;
    }
  }

  Future pickImageFromCamera(String fotoDari) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) {
      return;
    } else {
      if (fotoDari == 'SIA') {
        fotoSIAImagePicker = File(returnedImage.path);
      } else if (fotoDari == 'SIPA') {
        fotoSIPAImagePicker = File(returnedImage.path);
      } else {
        return;
      }
    }
  }

  bool registerButtonPressed(BuildContext context) {
    if (usernameUIController.text.isEmpty) {
      usernameError = 'Username tidak boleh kosong';
    } else if (usernameUIController.text.length < 5 ||
        usernameUIController.text.length > 20) {
      usernameError = 'Panjang username harus diantara 5 sampai 20 karakter';
    } else {
      usernameError = '';
    }

    if (passwordUIController.text.isEmpty) {
      passwordError = 'Password tidak boleh kosong';
    } else if (passwordUIController.text.toString().trim().contains(' ')) {
      passwordError = 'Password tidak boleh ada spasi';
    } else {
      passwordError = '';
    }

    // else {
    //   final bool passwordValid = RegExp(
    //     r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d\w\W]{8,}$",
    //   ).hasMatch(
    //     passwordUIController.text.toString().trim(),
    //   );
    //   if (passwordValid == false) {
    //     passwordError =
    //         'Password harus termasuk setidaknya 8 karakter, 1 huruf besar, 1 huruf kecil, and 1 angka';
    //   } else {
    //     passwordError = '';
    //   }
    // }

    if (confirmPasswordUIController.text != passwordUIController.text) {
      confirmPasswordError = 'konfimasi password tidak sesuai';
    } else {
      confirmPasswordError = '';
    }

    if (namaApotekUIController.text.isEmpty) {
      namaApotekError = 'Nama apotek tidak boleh kosong';
    } else {
      namaApotekError = '';
    }

    if (alamatUIController.text.isEmpty) {
      alamatError = 'Alamat tidak boleh kosong';
    } else {
      alamatError = '';
    }

    if (kotaUIController.text.isEmpty) {
      kotaError = 'Kota tidak boleh kosong';
    } else {
      kotaError = '';
    }

    if (nomorTeleponUIController.text.isEmpty) {
      nomorTeleponError = 'Nomor telepon tidak boleh kosong';
    } else if (nomorTeleponUIController.text.toString().trim().contains(' ')) {
      nomorTeleponError = 'nomor telepon tidak boleh ada spasi';
    } else {
      final bool phoneValid = RegExp(
        r"^(\+62|62|0)8[1-9][0-9]{6,9}$",
      ).hasMatch(
        nomorTeleponUIController.text.toString().trim(),
      );
      if (phoneValid == false) {
        nomorTeleponError = 'Nomor telepon tidak valid';
      } else {
        nomorTeleponError = '';
      }
    }

    if (emailUIController.text.isEmpty) {
      emailError = 'Email tidak boleh kosong';
    } else if (emailUIController.text.toString().trim().contains(' ')) {
      emailError = 'Alamat email tidak boleh ada spasi';
    } else {
      final bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(
        emailUIController.text.toString().trim(),
      );
      if (emailValid == false) {
        emailError = 'Email tidak valid';
      } else {
        emailError = '';
      }
    }

    if (nomorIzinApotekUIController.text.isEmpty) {
      nomorIzinApotekError = 'Nomor izin apotek tidak boleh kosong';
    } else {
      nomorIzinApotekError = '';
    }

    if (fotoSIAImagePicker == null) {
      fotoSIAError = 'Anda belum memilih foto SIA';
    } else {
      fotoSIAError = '';
    }

    if (izinApotekBerlakuSampaiUIController.text.isEmpty) {
      izinApotekBerlakuSampaiError =
          'Izin apotek berlaku s/d tidak boleh kosong';
    } else {
      izinApotekBerlakuSampaiError = '';
    }

    if (namaApotekerUIController.text.isEmpty) {
      namaApotekerError = 'Nama apoteker tidak boleh kosong';
    } else {
      namaApotekerError = '';
    }

    if (nomorIzinApotekerUIController.text.isEmpty) {
      nomorIzinApotekerError = 'Nomor izin apoteker tidak boleh kosong';
    } else {
      nomorIzinApotekerError = '';
    }

    if (fotoSIPAImagePicker == null) {
      fotoSIPAError = 'Anda belum memilih foto SIPA';
    } else {
      fotoSIPAError = '';
    }

    if (nomorApotekerBerlakuSampaiUIController.text.isEmpty) {
      nomorApotekerBerlakuSampaiError =
          'Nomor apoteker berlaku s/d tidak boleh kosong';
    } else {
      nomorApotekerBerlakuSampaiError = '';
    }

    if (namaFakturUIController.text.isEmpty) {
      namaFakturError = 'Nama tidak boleh kosong';
    } else {
      namaFakturError = '';
    }

    if (alamatFakturUIController.text.isEmpty) {
      alamatFakturError = 'Alamat tidak boleh kosong';
    } else {
      alamatFakturError = '';
    }

    if (kotaFakturUIController.text.isEmpty) {
      kotaFakturError = 'Kota tidak boleh kosong';
    } else {
      kotaFakturError = '';
    }

    if (npwpFakturUIController.text.isEmpty) {
      npwpFakturError = 'NPWP tidak boleh kosong';
    } else {
      npwpFakturError = '';
    }

    if (usernameError.isEmpty &&
        passwordError.isEmpty &&
        confirmPasswordError.isEmpty &&
        namaApotekError.isEmpty &&
        alamatError.isEmpty &&
        kotaError.isEmpty &&
        nomorTeleponError.isEmpty &&
        emailError.isEmpty &&
        nomorIzinApotekError.isEmpty &&
        fotoSIAError.isEmpty &&
        izinApotekBerlakuSampaiError.isEmpty &&
        namaApotekerError.isEmpty &&
        nomorIzinApotekerError.isEmpty &&
        nomorApotekerBerlakuSampaiError.isEmpty &&
        namaFakturError.isEmpty &&
        alamatFakturError.isEmpty &&
        kotaFakturError.isEmpty &&
        npwpFakturError.isEmpty) {
      return true;
    }
    return false;
  }

  Future<bool> createAccount() async {
    bool success = false;

    MlgnBaruService service = MlgnBaruService();

    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String requestDateSIA = formatter.format(izinApotekBerlakuSelectedDate!);
    String requestDateSIPA =
        formatter.format(nomorApotekerBerlakuSelectedDate!);

    MlgnBaruRequest request = MlgnBaruRequest(
      username: usernameUIController.text,
      password: confirmPasswordUIController.text,
      pharmacyName: namaApotekUIController.text,
      pharmacyAddress: alamatUIController.text,
      pharmacyCity: kotaUIController.text,
      pharmacyPhoneNumber: nomorTeleponUIController.text,
      pharmacyEmail: emailUIController.text,
      pharmacySIA: nomorIzinApotekUIController.text,
      pharmacySIADate: requestDateSIA,
      pharmacistName: namaApotekerUIController.text,
      pharmacistSIPA: nomorIzinApotekerUIController.text,
      pharmacistSIPADate: requestDateSIPA,
      taxName: namaFakturUIController.text,
      taxAddress: alamatFakturUIController.text,
      taxCity: kotaFakturUIController.text,
      taxNPWP: npwpFakturUIController.text,
      pharmacySIAPhoto: fotoSIAImagePicker!,
      pharmacySIPAPhoto: fotoSIPAImagePicker!,
    );

    try {
      MlgnBaruResponse response = await service.register(request);
      response.printMlgnBaruResponse();
      if (response.status) {
        success = true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }

    return success;
  }
}
