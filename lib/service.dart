import 'dart:convert';

import 'package:ecommerce_pharmacist_semarang/mvc/model/addtocart/add_to_cart_request.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/addtocart/add_to_cart_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/banner/banner_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/cart/cart_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/claimpoint/claim_point_request.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/claimpoint/claim_point_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/customer/customer_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/deletecartitem/delete_cart_item_request.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/deletecartitem/delete_cart_item_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/editorder/edit_order_request.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/editorder/edit_order_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/edituser/edit_user_request.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/edituser/edit_user_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/history/history_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/mlgn/mlgn_request.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/mlgn/mlgn_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/mlgnbaru/mlgnbaru_request.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/mlgnbaru/mlgnbaru_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/piutang/piutang_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/drug/drug_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/point/point_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/processorder/process_order_request.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/processorder/process_order_response.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

const baseUrl = 'http://103.178.175.164/ecommercePharmacist';

class HttpStatusError {
  static String getErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad Request: The server could not understand the request due to invalid syntax.';
      case 401:
        return 'Unauthorized: The client must authenticate itself to get the requested response.';
      case 403:
        return 'Forbidden: The client does not have access rights to the content.';
      case 404:
        return 'Not Found: The server can not find the requested resource.';
      case 405:
        return 'Method Not Allowed: The request method is known by the server but is not supported by the target resource.';
      case 408:
        return 'Request Timeout: The server would like to shut down this unused connection.';
      case 429:
        return 'Too Many Requests: The user has sent too many requests in a given amount of time.';
      case 500:
        return 'Internal Server Error: The server has encountered a situation it doesn\'t know how to handle.';
      case 502:
        return 'Bad Gateway: The server was acting as a gateway or proxy and received an invalid response from the upstream server.';
      case 503:
        return 'Service Unavailable: The server is not ready to handle the request.';
      case 504:
        return 'Gateway Timeout: The server is acting as a gateway or proxy and did not get a response from the upstream server.';
      default:
        return 'Unknown Error: An unexpected error occurred with status code $statusCode.';
    }
  }
}

class MlgnService {
  Future<MlgnResponse> login(MlgnRequest request) async {
    final url = Uri.parse('$baseUrl/login.php');

    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(request.toJson()),
          )
          .timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return MlgnResponse.fromJson(jsonResponse);
      } else {
        String errorMessage =
            '${response.statusCode} ${HttpStatusError.getErrorMessage(response.statusCode)}';
        return MlgnResponse(
          status: false,
          message: errorMessage,
          userId: '',
          name: '',
          username: '',
          userCode: '',
          isSales: ''
        );
      }
    } catch (e) {
      // Handle any other exceptions
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return MlgnResponse(
        status: false,
        message: 'An unexpected error occurred.',
        userId: '',
        name: '',
        username: '',
        userCode: '',
        isSales: ''
      );
    }
  }
}

class MlgnBaruService {
  Future<MlgnBaruResponse> register(MlgnBaruRequest request) async {
    final url = Uri.parse('$baseUrl/register.php');

    var requestBody = http.MultipartRequest('POST', url);

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
      contentType:
          MediaType.parse(lookupMimeType(request.pharmacySIAPhoto.path)!),
    ));

    requestBody.files.add(await http.MultipartFile.fromPath(
      'pharmacySIPAPhoto',
      request.pharmacySIPAPhoto.path,
      contentType:
          MediaType.parse(lookupMimeType(request.pharmacySIPAPhoto.path)!),
    ));

    final streamedResponse = await requestBody.send();

    try {
      final response = await http.Response.fromStream(streamedResponse)
          .timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return MlgnBaruResponse.fromJson(jsonResponse);
      } else {
        String errorMessage =
            '${response.statusCode} ${HttpStatusError.getErrorMessage(response.statusCode)}';
        return MlgnBaruResponse(
          status: false,
          message: errorMessage,
        );
      }
    } catch (e) {
      // Handle any other exceptions
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return MlgnBaruResponse(
        status: false,
        message: 'An unexpected error occurred.',
      );
    }
  }
}

class EditUserService {
  Future<EditUserResponse> editUser(EditUserRequest request) async {
    final url = Uri.parse('$baseUrl/editUserData.php');

    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(request.toJson()),
          )
          .timeout(const Duration(seconds: 4));
          
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return EditUserResponse.fromJson(jsonResponse);
      } else {
        String errorMessage =
            '${response.statusCode} ${HttpStatusError.getErrorMessage(response.statusCode)}';
        return EditUserResponse(
          status: false,
          message: errorMessage,
        );
      }
    } catch (e) {
      // Handle any other exceptions
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return EditUserResponse(
        status: false,
        message: 'An unexpected error occurred.',
      );
    }
  }
}

class BannerService {
  Future<BannerResponse?> getBanners() async {
    final url = Uri.parse('$baseUrl/getBanner.php');

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return BannerResponse.fromJson(jsonResponse);
      } else {
        // Handle non-200 status codes
        String errorMessage =
            '${response.statusCode} ${HttpStatusError.getErrorMessage(response.statusCode)}';
        return BannerResponse(
          status: false,
          message: errorMessage,
          imageData: [],
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return BannerResponse(
        status: false,
        message: 'An unexpected error occurred.',
        imageData: [],
      );
    }
  }
}

class CustomerService {
  Future<CustomerResponse?> getCustomers() async {
    final url = Uri.parse('$baseUrl/getCustomer.php');

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return CustomerResponse.fromJson(jsonResponse);
      } else {
        String errorMessage =
            '${response.statusCode} ${HttpStatusError.getErrorMessage(response.statusCode)}';
        return CustomerResponse(
          status: false,
          message: errorMessage,
          customerData: [],
        );
      }
    } catch (e) {
      // Handle unexpected errors
      return CustomerResponse(
        status: false,
        message: 'An unexpected error occurred.',
        customerData: [],
      );
    }
  }
}

class DrugService {
  // Fetch drug data from the server
  Future<DrugResponse?> getDrug() async {
    final url = Uri.parse('$baseUrl/getDrug.php');

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return DrugResponse.fromJson(jsonResponse);
      } else {
        // Handle non-200 status codes
        String errorMessage =
            '${response.statusCode} ${HttpStatusError.getErrorMessage(response.statusCode)}';
        return DrugResponse(
          status: false,
          message: errorMessage,
          drugData: [],
        );
      }
    } catch (e) {
      // Handle exceptions during the HTTP request
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return DrugResponse(
        status: false,
        message: 'An unexpected error occurred.',
        drugData: [],
      );
    }
  }
}

class AddToCartService {
  Future<AddToCartResponse> addToCart(AddToCartRequest request) async {
    final url = Uri.parse('$baseUrl/addToCart.php');

    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(request.toJson()),
          )
          .timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return AddToCartResponse.fromJson(jsonResponse);
      } else {
        String errorMessage =
            '${response.statusCode} ${HttpStatusError.getErrorMessage(response.statusCode)}';
        return AddToCartResponse(
          status: false,
          exist: false,
          message: errorMessage,
        );
      }
    } catch (e) {
      // Handle any other exceptions
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return AddToCartResponse(
        status: false,
        exist: false,
        message: 'An unexpected error occurred.',
      );
    }
  }
}

class CartService {
  Future<CartResponse?> getCart(String userCode, String customerCode) async {
    final url = Uri.parse('$baseUrl/getCart.php?userCode=$userCode&customerCode=$customerCode');

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 4));
      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return CartResponse.fromJson(jsonResponse);
      } else {
        // Handle non-200 status codes
        String errorMessage =
            '${response.statusCode} ${HttpStatusError.getErrorMessage(response.statusCode)}';
        return CartResponse(
          status: false,
          message: errorMessage,
          cartData: [],
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return CartResponse(
        status: false,
        message: 'An unexpected error occurred.',
        cartData: [],
      );
    }
  }
}

class EditOrderService {
  Future<EditOrderResponse> editOrder(EditOrderRequest request) async {
    final url = Uri.parse('$baseUrl/editOrder.php');
    try {
      final response = await http
          .put(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(
                request.toJson()), // Assuming request.toJson() is implemented
          )
          .timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return EditOrderResponse.fromJson(jsonResponse);
      } else {
        String errorMessage =
            '${response.statusCode} ${HttpStatusError.getErrorMessage(response.statusCode)}';
        return EditOrderResponse(
          status: false,
          message: errorMessage,
        );
      }
    } catch (e) {
      // Handle any other exceptions
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return EditOrderResponse(
        status: false,
        message: 'An unexpected error occurred.',
      );
    }
  }
}

class DeleteCartItemService {
  Future<DeleteCartItemResponse> deleteCartItem(DeleteCartItemRequest request) async {
    final url = Uri.parse('$baseUrl/deleteOrder.php');

    try {
      final response = await http
          .delete(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(request.toJson()),
          )
          .timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return DeleteCartItemResponse.fromJson(jsonResponse);
      } else {
        String errorMessage =
            '${response.statusCode} ${HttpStatusError.getErrorMessage(response.statusCode)}';
        return DeleteCartItemResponse(
          status: false,
          message: errorMessage,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return DeleteCartItemResponse(
        status: false,
        message: 'An unexpected error occurred.',
      );
    }
  }
}

class ProcessOrderService {
  Future<ProcessOrderResponse> processOrder(ProcessOrderRequest request) async {
    final url = Uri.parse('$baseUrl/processOrder.php');

    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(
                request.toJson()), // Assuming request.toJson() is implemented
          )
          .timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return ProcessOrderResponse.fromJson(jsonResponse);
      } else {
        String errorMessage =
            '${response.statusCode} ${HttpStatusError.getErrorMessage(response.statusCode)}';
        return ProcessOrderResponse(
          status: false,
          message: errorMessage,
        );
      }
    } catch (e) {
      // Handle any other exceptions
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return ProcessOrderResponse(
        status: false,
        message: 'An unexpected error occurred.',
      );
    }
  }
}

class HistoryService {
  Future<HistoryResponse?> getHistoryOrder(String userCode, String customerCode) async {
    final url = Uri.parse('$baseUrl//getHistoryOrder.php?userCode=$userCode&customerCode=$customerCode');

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 4));
      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return HistoryResponse.fromJson(jsonResponse);
      } else {
        // Handle non-200 status codes
        String errorMessage =
            '${response.statusCode} ${HttpStatusError.getErrorMessage(response.statusCode)}';
        return HistoryResponse(
          status: false,
          message: errorMessage,
          orderHistoryData: [],
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return HistoryResponse(
        status: false,
        message: 'An unexpected error occurred.',
        orderHistoryData: [],
      );
    }
  }
}

class PiutangService {
  Future<PiutangResponse?> getPiutang(String userCode) async {
    final url = Uri.parse('$baseUrl/getPiutang.php?userCode=$userCode');

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return PiutangResponse.fromJson(jsonResponse);
      } else {
        String errorMessage =
            '${response.statusCode} ${HttpStatusError.getErrorMessage(response.statusCode)}';
        return PiutangResponse(
          status: false,
          message: errorMessage,
          piutangData: [],
        );
      }
    } catch (e) {
      // Handle any other exceptions
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return PiutangResponse(
        status: false,
        message: 'An unexpected error occurred.',
        piutangData: [],
      );
    }
  }
}

class PointService {
  Future<PointResponse?> getSaldoPoint(
      String userCode, String startDate, String endDate) async {
    final url = Uri.parse(
        '$baseUrl/getSaldoPoint.php?userCode=$userCode&startDate=$startDate&endDate=$endDate');

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 4));
      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return PointResponse.fromJson(jsonResponse);
      } else {
        // Handle non-200 status codes
        String errorMessage =
            '${response.statusCode} ${HttpStatusError.getErrorMessage(response.statusCode)}';
        return PointResponse(
          status: false,
          message: errorMessage,
          totalPointNow: '',
          saldoPointData: [],
        );
      }
    } catch (e) {
      print('object');
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return PointResponse(
        status: false,
        message: 'An unexpected error occurred.',
        totalPointNow: '',
        saldoPointData: [],
      );
    }
  }
}

class ClaimPointService {
  Future<ClaimPointResponse> claimPoints(ClaimPointRequest request) async {
    final url = Uri.parse('$baseUrl/claimPoint.php');

    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(request.toJson()),
          )
          .timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return ClaimPointResponse.fromJson(jsonResponse);
      } else {
        String errorMessage =
            '${response.statusCode} ${HttpStatusError.getErrorMessage(response.statusCode)}';
        return ClaimPointResponse(
          status: false,
          message: errorMessage,
        );
      }
    } catch (e) {
      // Handle any other exceptions
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return ClaimPointResponse(
        status: false,
        message: 'An unexpected error occurred.',
      );
    }
  }
}
