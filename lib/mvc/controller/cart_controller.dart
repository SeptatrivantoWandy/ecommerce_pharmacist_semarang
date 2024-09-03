import 'dart:async';

import 'package:ecommerce_pharmacist_semarang/mvc/model/cart/cart_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/editorder/edit_order_request.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/editorder/edit_order_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/processorder/process_order_request.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/processorder/process_order_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/cart_screen/cart_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController {
  final Future<SharedPreferences> futurePrefs = SharedPreferences.getInstance();
  String userCode = '';
  List<CartData> cartDataList = [];
  List<EditedCartData> editedCartDataList = [];
  String cartError = '';
  String editCartError = '';
  double totalCartPrice = 0.0;
  String totalCartValue = '';

  Timer? debounce;
  bool isEditSuccess = false;

  ScrollController scrollController = ScrollController();
  double scrollPercentage = 0.0;

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await futurePrefs;
    userCode = prefs.getString('userCode')!;
  }

  Future<void> viewDidLoad() async {
    // Wait for user data to be loaded first
    await loadUserData();

    // Then fetch Piutang data after user data is loaded
    if (userCode.isNotEmpty) {
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
    CartResponse? response = await cartService.getCart(userCode);

    // Simulate empty list
    // CartResponse response = CartResponse(
    //   status: true,
    //   message: 'Success',
    //   cartData: [], // Empty list
    // );

    // Mocked error responseC
    // CartResponse response = CartResponse(
    //   status: false,
    //   message: 'Error fetching data',
    //   cartData: [],
    // );

    // Simulate a network delay
    // await Future.delayed(const Duration(seconds: 2));

    if (response != null && response.status) {
      // If the response is successful
      cartError = '';

      // Initialize a list to store formatted CartData
      List<CartData> formattedCartDataList = [];
      editedCartDataList = [];
      totalCartPrice = 0.0;

      // Iterate through the response data and format the values
      for (var cartItem in response.cartData) {
        // Format the cart price and calculate the total
        double cartPriceValue = double.parse(cartItem.cartDrugPrice);

        // print(cartItem.cartDrugPrice);
        // response.printCartResponse();

        totalCartPrice += cartPriceValue;

        // Create a new CartData with the necessary values
        CartData formattedCartData = CartData(
          userCode: cartItem.userCode,
          cartMeasure: cartItem.cartMeasure,
          cartQty: cartItem.cartQty,
          cartBonus: cartItem.cartBonus,
          cartDrugPrice: cartItem.cartDrugPrice,
          cartDiscount: cartItem.cartDiscount,
          drugData: cartItem.drugData,
        );

        // Add the formatted CartData to the list
        formattedCartDataList.add(formattedCartData);
      }

      // Store the formatted Cart data
      cartDataList = formattedCartDataList;
      totalCartValue = formatBalance(
          double.parse(totalCartPrice.toStringAsFixed(2)).round().toString());

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollPercentage);
        }
      });

      for (var cartItem in cartDataList) {
        EditedCartData initiatedCartData = EditedCartData(
          drugCode: cartItem.drugData.drugCode,
          drugMeasure: cartItem.cartMeasure,
          drugQty: int.parse(cartItem.cartQty),
          bonus: int.parse(cartItem.cartBonus),
          drugPrice: double.parse(cartItem.cartDrugPrice),
          discount: double.parse(cartItem.drugData.drugDetail.bonus1),
        );
        editedCartDataList.add(initiatedCartData);
      }
    } else {
      // If there was an error fetching the data, store the error message
      cartError = response?.message ?? 'Failed to fetch cart data';
    }
  }

  Future<void> deleteItemPressed(
      BuildContext context,
      CartData deleteCartData,
      CartDialog cartDialog,
      int index,
      VoidCallback refreshData,
      StateSetter setState,
      VoidCallback setInitialData) async {
    if (debounce == null || !debounce!.isActive) {
      final bool isAgree =
          await cartDialog.confirmDeleteItemAlertDialog(context);
      if (isAgree) {
        editedCartDataList.removeAt(index);
        cartDataList.removeAt(index);

        if (context.mounted) {
          final bool isSuccess =
              await editOrder(context, cartDialog, refreshData);
          if (!isSuccess) {
            EditedCartData undoEditedDelete = EditedCartData(
              drugCode: deleteCartData.drugData.drugCode,
              drugMeasure: deleteCartData.cartMeasure,
              drugQty: int.parse(deleteCartData.cartQty),
              bonus: int.parse(deleteCartData.cartBonus),
              drugPrice: double.parse(deleteCartData.cartDrugPrice),
              discount: double.parse(deleteCartData.cartDiscount),
            );
            editedCartDataList.insert(index, undoEditedDelete);

            CartData undoDelete = CartData(
              userCode: userCode,
              cartMeasure: deleteCartData.cartMeasure,
              cartQty: deleteCartData.cartQty,
              cartBonus: deleteCartData.cartBonus,
              cartDrugPrice: deleteCartData.cartDrugPrice,
              cartDiscount: deleteCartData.cartDiscount,
              drugData: deleteCartData.drugData,
            );
            cartDataList.insert(index, undoDelete);
          } else {}
        }
      }
    }
  }

  Future<bool> preEditCartList(
      BuildContext context,
      CartDialog cartDialog,
      EditedCartData? selectedEditedCartData,
      VoidCallback refreshData,
      StateSetter setState) async {
    // Use a Completer to wait for the Timer to complete
    final completer = Completer<bool>();

    debounce = Timer(const Duration(seconds: 1), () async {
      final bool isSuccess = await editOrder(context, cartDialog, refreshData);
      completer.complete(isSuccess); // Complete the future after the timer
    });

    return completer.future;
  }

  Future<bool> editOrder(BuildContext context, CartDialog cartDialog,
      VoidCallback refreshData) async {
    // editedCartDataList = [];
    cartDialog.loadingAlertDialog(context);
    editCartError = '';

    EditOrderService service = EditOrderService();
    EditOrderRequest request = EditOrderRequest(
      userCode: userCode,
      editedCartData: editedCartDataList,
    );

    // request.printEditOrderRequest();

    try {
      EditOrderResponse response = await service.editOrder(request);

      // Simulate a network delay
      // await Future.delayed(const Duration(seconds: 2));

      if (response.status) {
        // refreshData();
        if (context.mounted) {
          Navigator.of(context).pop();
        }
        refreshData();
        isEditSuccess = true;
        return response.status;
      } else {
        isEditSuccess = false;
        editCartError = response.message;
        if (context.mounted) {
          Navigator.of(context).pop();
          cartDialog.failureAlertDialog(
            context,
            'Gagal melakukan update cart',
            editCartError,
          );
        }
        return response.status;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return false;
    }
  }

  Future<bool> konfirmasiOrderPressed(
    BuildContext context,
    CartDialog cartDialog,
  ) async {
    if (debounce == null || !debounce!.isActive) {
      bool isAgree = await cartDialog.confirmOrderAlertDialog(context);
      if (isAgree) {
        if (context.mounted) {
          cartDialog.loadingAlertDialog(context);
        }

        ProcessOrderService service = ProcessOrderService();
        ProcessOrderRequest request = ProcessOrderRequest(
          orderDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          userCode: userCode,
        );

        // Simulate a network delay
        // await Future.delayed(const Duration(seconds: 2));

        try {
          ProcessOrderResponse response = await service.processOrder(request);

          if (response.status) {
            if (context.mounted) {
              Navigator.of(context).pop();
              cartDialog.successAlertDialog(context);
              return true;
            }
            return true;
          } else {
            if (context.mounted) {
              Navigator.of(context).pop();
              cartDialog.failureAlertDialog(
                  context,
                  'Terjadi kesalahan teknis, silahkan coba beberapa saat lagi.',
                  response.message);
              return true;
            }
          }
        } catch (e) {
          if (kDebugMode) {
            print('Error: $e');
          }
          return false;
        }
      }
    }

    return false;
  }
}
