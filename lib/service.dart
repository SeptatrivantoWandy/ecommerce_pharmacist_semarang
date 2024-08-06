import 'dart:convert';

import 'package:ecommerce_pharmacist_semarang/mvc/model/mlgn/mlgn_request.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/mlgn/mlgn_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/mlgnbaru/mlgnbaru_request.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/mlgnbaru/mlgnbaru_response.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class MlgnService {
  Future<MlgnResponse> login(MlgnRequest request) async {
    const url = 'http://103.178.175.164/ecommercePharmacist/login.php';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return MlgnResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to login');
    }
  }
}

class MlgnBaruService {
  Future<MlgnBaruResponse> register(MlgnBaruRequest request) async {
    const url = 'http://103.178.175.164/ecommercePharmacist/register.php';

    var requestBody = http.MultipartRequest('POST', Uri.parse(url));

    requestBody.fields['username'] = request.username;
    requestBody.fields['password'] = request.password;
    requestBody.fields['pharmacyName'] = request.pharmacyName;
    requestBody.fields['pharmacyAddress'] = request.pharmacyAddress;
    requestBody.fields['pharmacyCity'] = request.pharmacyCity;
    requestBody.fields['pharmacyPhoneNumber'] = request.pharmacyPhoneNumber;
    requestBody.fields['pharmacyEmail'] = request.pharmacyEmail;
    requestBody.fields['pharmacySIA'] = request.pharmacySIA;
    requestBody.fields['pharmacySIADate'] = request.pharmacySIADate;
    requestBody.fields['pharmacistName'] = request.pharmacistName;
    requestBody.fields['pharmacistSIPA'] = request.pharmacistSIPA;
    requestBody.fields['pharmacistSIPADate'] = request.pharmacistSIPADate;
    requestBody.fields['taxName'] = request.taxName;
    requestBody.fields['taxAddress'] = request.taxAddress;
    requestBody.fields['taxCity'] = request.taxCity;
    requestBody.fields['taxNPWP'] = request.taxNPWP;

    requestBody.files.add(await http.MultipartFile.fromPath(
      'pharmacySIAPhoto',
      request.pharmacySIAPhoto.path,
      contentType: MediaType.parse(lookupMimeType(request.pharmacySIAPhoto.path)!),
    ));

    requestBody.files.add(await http.MultipartFile.fromPath(
      'pharmacySIPAPhoto',
      request.pharmacySIPAPhoto.path,
      contentType: MediaType.parse(lookupMimeType(request.pharmacySIPAPhoto.path)!),
    ));

    final streamedResponse = await requestBody.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return MlgnBaruResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to register');
    }
  }
}