import 'package:ecommerce_pharmacist_semarang/mvc/model/cart/cart_response.dart';
import 'package:ecommerce_pharmacist_semarang/service.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController {
  int quantityMedicine = 1;
  final Future<SharedPreferences> futurePrefs = SharedPreferences.getInstance();
  String? userCode;
  List<CartData>? cartDataList;
  String? cartError;
  String totalCartValue = '';

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await futurePrefs;
    userCode = prefs.getString('userCode');
  }

  Future<void> viewDidLoad() async {
    // Wait for user data to be loaded first
    await loadUserData();

    // Then fetch Piutang data after user data is loaded
    if (userCode != null && userCode!.isNotEmpty) {
      await fetchCart();
    } else {
      if (kDebugMode) {
        print('User code not found');
      }
    }
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

  Future<void> fetchCart() async {
    // Create an instance of CartService
    CartService cartService = CartService();

    // Fetch the CartResponse from the service
    CartResponse? response = await cartService.getCart(userCode!);

    // Simulate empty list
    // CartResponse response = CartResponse(
    //   status: true,
    //   message: 'Success',
    //   cartData: [], // Empty list
    // );

    // Mocked error response
    // CartResponse response = CartResponse(
    //   status: false,
    //   message: 'Error fetching data',
    //   cartData: [],
    // );

    // Simulate a network delay
    // await Future.delayed(const Duration(seconds: 2));

    if (response != null && response.status) {
      // If the response is successful
      cartError = null;

      // Initialize a list to store formatted CartData
      List<CartData> formattedCartDataList = [];

      double totalCartPrice = 0.0;

      // Iterate through the response data and format the values
      for (var cartItem in response.cartData) {
        // Format the cart price and calculate the total
        double cartPriceValue = double.parse(cartItem.cartDrugPrice);
        totalCartPrice += cartPriceValue;

        // Create a new CartData with the necessary values
        CartData formattedCartData = CartData(
          userCode: cartItem.userCode,
          cartMeasure: cartItem.cartMeasure,
          cartQty: cartItem.cartQty,
          cartBonus: cartItem.cartBonus,
          cartDrugPrice: formatBalance(cartItem.cartDrugPrice),
          cartDiscount: cartItem.cartDiscount,
          drugData: cartItem.drugData,
        );

        // Add the formatted CartData to the list
        formattedCartDataList.add(formattedCartData);
      }

      // Store the formatted Cart data
      cartDataList = formattedCartDataList;
      totalCartValue = formatBalance(totalCartPrice.toString());
    } else {
      // If there was an error fetching the data, store the error message
      cartError = response?.message ?? 'Failed to fetch cart data';
    }
  }

  void incrementQuantity() {
    quantityMedicine++;
  }

  void decrementQuantity() {
    if (quantityMedicine > 1) {
      quantityMedicine--;
    }
  }
}
