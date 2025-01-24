import 'dart:async';

import 'package:ecommerce_pharmacist_semarang/mvc/model/cart/cart_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/deletecartitem/delete_cart_item_request.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/deletecartitem/delete_cart_item_response.dart';
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
  String customerCode = '';
  List<CartData> cartDataList = [];
  List<EditedCartData> editedCartDataList = [];
  String cartError = '';
  String editCartError = '';
  String deleteCartError = '';
  double totalCartPrice = 0.0;
  String totalCartValue = '';

  Timer? debounce;
  String isEditSuccess = 'isLoading';

  ScrollController scrollController = ScrollController();
  double scrollPercentage = 0.0;

  TextEditingController paymentMethodUIController = TextEditingController();
  final List<String> paymentMethodItems = [
    'Kredit',
    'Tunai',
    'Cash on Delivery'
  ];

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await futurePrefs;
    userCode = prefs.getString('userCode') ?? '';
    customerCode = prefs.getString('customerCode') ?? '';

    if (customerCode.isEmpty) {
      customerCode = userCode;
    }
  }

  Future<bool> viewDidLoad() async {
    // Wait for user data to be loaded first
    await loadUserData();

    // Then fetch Piutang data after user data is loaded
    if (userCode.isNotEmpty) {
      final bool isSuccessFetchCart = await fetchCart();
      return isSuccessFetchCart;
    } else {
      if (kDebugMode) {
        print('User code not found');
      }
      return false;
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

  double calculateDrugPriceTotal(
      double priceMedicine, int quantityMedicine, double finalDisc) {
    final double totalPriceMedicine = (priceMedicine * quantityMedicine) -
        ((priceMedicine * quantityMedicine) * (finalDisc / 100));

    // print('($priceMedicine * $quantityMedicine) - (($priceMedicine * $quantityMedicine) * ($finalDisc / 100)) = $totalPriceMedicine');

    return totalPriceMedicine;
  }

  Future<bool> fetchCart() async {
    isEditSuccess = 'isLoading';

    // Create an instance of CartService
    CartService cartService = CartService();

    // Fetch the CartResponse from the service
    CartResponse? response = await cartService.getCart(userCode, customerCode);

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
      isEditSuccess = 'isSuccess';
      cartError = '';

      // response.printCartResponse();

      // Initialize a list to store formatted CartData
      List<CartData> formattedCartDataList = [];
      editedCartDataList = [];
      totalCartPrice = 0.0;

      // Iterate through the response data and format the values
      for (var cartItem in response.cartData) {
        // Format the cart price and calculate the total

        double cartPriceValue = calculateDrugPriceTotal(
          double.parse(cartItem.cartDrugPrice),
          int.parse(cartItem.cartQty),
          double.parse(cartItem.cartDiscount),
        );

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
          customerCode: customerCode,
          drugMeasure: cartItem.cartMeasure,
          drugQty: int.parse(cartItem.cartQty),
          bonus: int.parse(cartItem.cartBonus),
          drugPrice: double.parse(cartItem.cartDrugPrice),
          discount: double.parse(cartItem.cartDiscount),
          drugPriceTotal: calculateDrugPriceTotal(
            double.parse(cartItem.cartDrugPrice),
            int.parse(cartItem.cartQty),
            double.parse(cartItem.cartDiscount),
          ),
        );
        editedCartDataList.add(initiatedCartData);
      }

      return true;
    } else {
      // If there was an error fetching the data, store the error message
      isEditSuccess = 'isFailure';
      cartError = response?.message ?? 'Failed to fetch cart data';
      return false;
    }
  }

  Future<void> deleteItemPressed(
    BuildContext context,
    String drugCode,
    CartDialog cartDialog,
    VoidCallback refreshData,
    StateSetter setState,
    int index,
    CartData deleteCartData,
  ) async {
    if (debounce == null || !debounce!.isActive) {
      final bool isAgree =
          await cartDialog.confirmDeleteItemAlertDialog(context);
      if (isAgree) {
        editedCartDataList.removeAt(index);
        cartDataList.removeAt(index);
        if (context.mounted) {
          final bool isSuccess = await deleteOrder(
            context,
            cartDialog,
            userCode,
            drugCode,
            customerCode,
          );
          if (!isSuccess) {
            EditedCartData undoEditedDelete = EditedCartData(
              drugCode: deleteCartData.drugData.drugCode,
              customerCode: customerCode,
              drugMeasure: deleteCartData.cartMeasure,
              drugQty: int.parse(deleteCartData.cartQty),
              bonus: int.parse(deleteCartData.cartBonus),
              drugPrice: double.parse(deleteCartData.cartDrugPrice),
              discount: double.parse(deleteCartData.cartDiscount),
              drugPriceTotal: calculateDrugPriceTotal(
                double.parse(deleteCartData.cartDrugPrice),
                int.parse(deleteCartData.cartQty),
                double.parse(deleteCartData.cartDiscount),
              ),
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
            setState(() {});
          } else {
            refreshData();
          }
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
      final bool isSuccess =
          await editOrder(context, cartDialog, refreshData, setState);
      completer.complete(isSuccess); // Complete the future after the timer
    });

    return completer.future;
  }

  Future<bool> editOrder(
    BuildContext context,
    CartDialog cartDialog,
    VoidCallback refreshData,
    StateSetter setState,
  ) async {
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
        isEditSuccess = 'isSuccess';

        try {
          bool isSuccessRefresh = await viewDidLoad();
          if (isSuccessRefresh && context.mounted) {
            Navigator.of(context).pop();
            setState(() {});
            return isSuccessRefresh;
          } else {
            if (context.mounted) {
              Navigator.of(context).pop();
              return false;
            }
            return false;
          }
        } catch (e) {
          if (kDebugMode) {
            print('error');
          }
          if (context.mounted) {
            Navigator.of(context).pop();
            return false;
          }
          return false;
        }
      } else {
        isEditSuccess = 'isFailure';
        editCartError = response.message;
        if (context.mounted) {
          Navigator.of(context).pop();
          cartDialog.failureAlertDialog(
            context,
            'Gagal melakukan update cart',
            editCartError,
          );
        }
        setState(() {});
        return response.status;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      if (context.mounted) {
        Navigator.of(context).pop();
        return false;
      }
      return false;
    }
  }

  Future<bool> deleteOrder(
    BuildContext context,
    CartDialog cartDialog,
    String deletingUsercode,
    String deletingDrugCode,
    String deletingCustomerCode,
  ) async {
    cartDialog.loadingAlertDialog(context);
    deleteCartError = '';

    DeleteCartItemService service = DeleteCartItemService();
    DeleteCartItemRequest request = DeleteCartItemRequest(
      userCode: deletingUsercode,
      drugCode: deletingDrugCode,
      customerCode: deletingCustomerCode,
    );

    try {
      DeleteCartItemResponse response = await service.deleteCartItem(request);

      if (response.status) {
        isEditSuccess = 'isSuccess';

        try {
          bool isSuccessRefresh = await viewDidLoad();
          if (isSuccessRefresh && context.mounted) {
            Navigator.of(context).pop();
            return isSuccessRefresh;
          } else {
            if (context.mounted) {
              Navigator.of(context).pop();
              return false;
            }
            return false;
          }
        } catch (e) {
          if (kDebugMode) {
            print('error');
          }
          if (context.mounted) {
            Navigator.of(context).pop();
            return false;
          }
          return false;
        }
      } else {
        isEditSuccess = 'isFailure';
        deleteCartError = response.message;
        if (context.mounted) {
          Navigator.of(context).pop();
          cartDialog.failureAlertDialog(
            context,
            'Gagal melakukan hapus cart',
            deleteCartError,
          );
        }
        // setState(() {});
        return response.status;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      if (context.mounted) {
        Navigator.of(context).pop();
        return false;
      }
      return false;
    }
  }

  void paymentMethodModalPressed(BuildContext context, int index) {
    paymentMethodUIController.text = paymentMethodItems[index];
    Navigator.pop(context);
  }

  Future<bool> konfirmasiOrderPressed(
      BuildContext context, CartDialog cartDialog, StateSetter setState) async {
    if (totalCartPrice < 200000) {
      cartDialog.failureAlertDialog(
        context,
        'Total keranjang belanja minimal Rp200.000',
        '',
      );
    } else if (paymentMethodUIController.text == '') {
      cartDialog.failureAlertDialog(
        context,
        'Pilih jenis pembayaran terlebih dahulu',
        '',
      );
    } else {
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
              customerCode: customerCode,
              paymentMethod: paymentMethodUIController.text);

          // Simulate a network delay
          // await Future.delayed(const Duration(seconds: 2));

          try {
            ProcessOrderResponse response = await service.processOrder(request);

            if (response.status) {
              final prefs = await SharedPreferences.getInstance();
              bool success = await prefs.remove('customerCode');
              if (success) {
                if (context.mounted) {
                  Navigator.of(context).pop();
                  cartDialog.successAlertDialog(context);
                  return true;
                }
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
              return true;
            }
          } catch (e) {
            if (kDebugMode) {
              print('Error: $e');
            }
            if (context.mounted) {
              Navigator.of(context).pop();
              return false;
            }
            return false;
          }
        }
      }
    }

    return false;
  }
}
