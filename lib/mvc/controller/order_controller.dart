import 'package:ecommerce_pharmacist_semarang/mvc/controller/cart_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/addtocart/add_to_cart_request.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/addtocart/add_to_cart_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/cart_screen/cart_view.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/history_screen/history_view.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/order_screen/order_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/service.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/drug/drug_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderController {
  final Future<SharedPreferences> futurePrefs = SharedPreferences.getInstance();
  String? userCode;

  bool isNotEmptySearch = false;
  TextEditingController searchMedicineUIController = TextEditingController();
  String drugMeasure = '';
  String? orderError;
  int? cartLength;
  List<DrugData>? orderDataList;
  List<DrugData>? searchDataList;

  int quantityMedicine = 1;
  late int resultDrugPrice;
  late int resultDrugBonus;
  late double resultDrugDiscount;

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await futurePrefs;
    userCode = prefs.getString('userCode');
  }

  Future<void> viewDidLoad(CartController cartController) async {
    await loadUserData();
    await fetchMedicineOrder();
    await getCartLength(cartController);
  }

  cartAppBarPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const CartView(),
      ),
    );
  }

  historyAppBarPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const HistoryView(),
      ),
    );
  }

  Future<void> getCartLength(CartController cartController) async {
    await cartController.viewDidLoad();
    cartLength = cartController.cartDataList!.length;
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

  Future<void> fetchMedicineOrder() async {
    DrugService drugService = DrugService();
    DrugResponse? response = await drugService.getDrug();

    // Simulate a network delay
    // await Future.delayed(const Duration(seconds: 2));

    if (response != null && response.status) {
      orderError = '';
      orderDataList = response.drugData.map((drugData) {
        // Create a new DrugDetail with the formatted hrg1Hv
        DrugDetail formattedDrugDetail = DrugDetail(
          drugMeasure: drugData.drugDetail.drugMeasure,
          drugMeasure2: drugData.drugDetail.drugMeasure2,
          hrg1Hv: drugData.drugDetail.hrg1Hv,
          hrg2Hv: drugData.drugDetail.hrg2Hv,
          beli1a: drugData.drugDetail.beli1a,
          beli1b: drugData.drugDetail.beli1b,
          bonus1: drugData.drugDetail.bonus1,
          disc1: drugData.drugDetail.disc1,
          hrgJadi1: drugData.drugDetail.hrgJadi1,
          kond1: drugData.drugDetail.kond1,
          beli2a: drugData.drugDetail.beli2a,
          beli2b: drugData.drugDetail.beli2b,
          bonus2: drugData.drugDetail.bonus2,
          disc2: drugData.drugDetail.disc2,
          hrgJadi2: drugData.drugDetail.hrgJadi2,
          kond2: drugData.drugDetail.kond2,
          beli3a: drugData.drugDetail.beli3a,
          beli3b: drugData.drugDetail.beli3b,
          bonus3: drugData.drugDetail.bonus3,
          disc3: drugData.drugDetail.disc3,
          hrgJadi3: drugData.drugDetail.hrgJadi3,
          kond3: drugData.drugDetail.kond3,
        );

        // Return a new DrugData object with the formatted DrugDetail
        return DrugData(
          drugCode: drugData.drugCode,
          drugName: drugData.drugName,
          drugImage: drugData.drugImage,
          drugDetail: formattedDrugDetail,
        );
      }).toList();
      if (searchMedicineUIController.text.isNotEmpty) {
        searchDrug(searchMedicineUIController.text);
      } else {
        searchDataList = orderDataList;
      }
    } else {
      orderError = 'Failed to fetch drug data.';
    }
  }

  void searchDrug(String query) {
    // If the search query is empty, show all data
    if (query.isEmpty) {
      searchDataList = orderDataList;
      return;
    }

    // Filter allDrugDataList based on the query
    List<DrugData> filteredList = orderDataList!.where((drugData) {
      // Assuming DrugData has a name property
      return drugData.drugName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    searchDataList = filteredList;
  }

  void cancelSearchPressed() {
    searchMedicineUIController.clear();
    isNotEmptySearch = false;
    searchDataList = orderDataList;
  }

  void initAddToCartModal(DrugData drugData) {
    quantityMedicine = 1;
    resultDrugPrice = double.parse(drugData.drugDetail.hrg1Hv).round();
    resultDrugBonus = int.parse(drugData.drugDetail.bonus1);
    resultDrugDiscount = double.parse(drugData.drugDetail.disc1);
  }

  void incrementQuantity(DrugData drugData) {
    quantityMedicine++;
    int selectedDrugPrice = double.parse(drugData.drugDetail.hrg1Hv).round();

    resultDrugPrice = resultDrugPrice + selectedDrugPrice;
  }

  void decrementQuantity(DrugData drugData) {
    if (quantityMedicine > 1) {
      quantityMedicine--;
      int selectedDrugPrice = double.parse(drugData.drugDetail.hrg1Hv).round();
      resultDrugPrice = resultDrugPrice - selectedDrugPrice;
    }
  }

  Future<bool> masukkanKeranjangPressed(
    BuildContext context,
    String drugCode,
    OrderDialog orderDialog,
  ) async {
    AddToCartService service = AddToCartService();

    AddToCartRequest request = AddToCartRequest(
      userCode: userCode!,
      drugCode: drugCode,
      drugMeasure: drugMeasure,
      drugQty: quantityMedicine,
      bonus: resultDrugBonus,
      drugPrice: resultDrugPrice,
      discount: resultDrugDiscount,
    );

    // Simulate a network delay
    // await Future.delayed(const Duration(seconds: 2));

    try {
      orderError = '';
      AddToCartResponse response = await service.addToCart(request);
      response.printAddToCartResponse();
      if (response.status) {
        orderError = '';
        return response.status;
      } else {
        orderError = response.message;
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
