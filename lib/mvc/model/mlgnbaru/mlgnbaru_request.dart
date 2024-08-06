import 'dart:io';

import 'package:flutter/foundation.dart';

class MlgnBaruRequest {
  String username;
  String password;
  String pharmacyName;
  String pharmacyAddress;
  String pharmacyCity;
  String pharmacyPhoneNumber;
  String pharmacyEmail;
  String pharmacySIA;
  String pharmacySIADate;
  String pharmacistName;
  String pharmacistSIPA;
  String pharmacistSIPADate;
  String taxName;
  String taxAddress;
  String taxCity;
  String taxNPWP;
  File pharmacySIAPhoto;
  File pharmacySIPAPhoto;

  MlgnBaruRequest({
    required this.username,
    required this.password,
    required this.pharmacyName,
    required this.pharmacyAddress,
    required this.pharmacyCity,
    required this.pharmacyPhoneNumber,
    required this.pharmacyEmail,
    required this.pharmacySIA,
    required this.pharmacySIADate,
    required this.pharmacistName,
    required this.pharmacistSIPA,
    required this.pharmacistSIPADate,
    required this.taxName,
    required this.taxAddress,
    required this.taxCity,
    required this.taxNPWP,
    required this.pharmacySIAPhoto,
    required this.pharmacySIPAPhoto,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'pharmacyName': pharmacyName,
      'pharmacyAddress': pharmacyAddress,
      'pharmacyCity': pharmacyCity,
      'pharmacyPhoneNumber': pharmacyPhoneNumber,
      'pharmacyEmail': pharmacyEmail,
      'pharmacySIA': pharmacySIA,
      'pharmacySIADate': pharmacySIADate,
      'pharmacistName': pharmacistName,
      'pharmacistSIPA': pharmacistSIPA,
      'pharmacistSIPADate': pharmacistSIPADate,
      'taxName': taxName,
      'taxAddress': taxAddress,
      'taxCity': taxCity,
      'taxNPWP': taxNPWP,
      'pharmacySIAPhoto': pharmacySIAPhoto,
      'pharmacySIPAPhoto': pharmacySIPAPhoto,
    };
  }

  void printMlgnBaruRequest() {
    if (kDebugMode) {
      print('========== printMlgnBaruRequest ==========');
      print('Username: $username');
      print('Password: $password');
      print('Pharmacy Name: $pharmacyName');
      print('Pharmacy Address: $pharmacyAddress');
      print('Pharmacy City: $pharmacyCity');
      print('Pharmacy Phone Number: $pharmacyPhoneNumber');
      print('Pharmacy Email: $pharmacyEmail');
      print('Pharmacy SIA: $pharmacySIA');
      print('Pharmacy SIA Date: $pharmacySIADate');
      print('Pharmacist Name: $pharmacistName');
      print('Pharmacist SIPA: $pharmacistSIPA');
      print('Pharmacist SIPA Date: $pharmacistSIPADate');
      print('Tax Name: $taxName');
      print('Tax Address: $taxAddress');
      print('Tax City: $taxCity');
      print('Tax NPWP: $taxNPWP');
      print('Pharmacy SIA Photo: ${pharmacySIAPhoto.path}');
      print('Pharmacy SIPA Photo: ${pharmacySIPAPhoto.path}');
    }
  }
}
