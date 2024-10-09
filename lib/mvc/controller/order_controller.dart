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

  double quantityMedicine = 1;
  late double priceMedicine;
  late double totalPriceMedicine;

  late int beli1a;
  late int beli1b;
  late int bonus1;
  late double disc1;
  late double hrgJadi1;
  late String kond1;
  late int beli2a;
  late int beli2b;
  late int bonus2;
  late double disc2;
  late double hrgJadi2;
  late String kond2;
  late int beli3a;
  late int beli3b;
  late int bonus3;
  late double disc3;
  late double hrgJadi3;
  late String kond3;

  int finalBonus = 0;
  double finalDisc = 0;

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await futurePrefs;
    userCode = prefs.getString('userCode');
  }

  Future<void> viewDidLoad(CartController cartController) async {
    await loadUserData();
    await fetchMedicineOrder();
    await getCartLength(cartController);
  }

  cartAppBarPressed(BuildContext context, VoidCallback refreshCartLength) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (ctx) => const CartView(),
      ),
    )
        .then((_) {
      refreshCartLength();
    });
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

    // Simulate a network delay
    // await Future.delayed(const Duration(seconds: 2));

    cartLength = cartController.cartDataList.length;
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

    beli1a = int.parse(drugData.drugDetail.beli1a);
    beli1b = int.parse(drugData.drugDetail.beli1b);
    bonus1 = int.parse(drugData.drugDetail.bonus1);
    disc1 = double.parse(drugData.drugDetail.disc1);
    hrgJadi1 = double.parse(drugData.drugDetail.hrgJadi1);
    kond1 = drugData.drugDetail.kond1;
    beli2a = int.parse(drugData.drugDetail.beli2a);
    beli2b = int.parse(drugData.drugDetail.beli2b);
    bonus2 = int.parse(drugData.drugDetail.bonus2);
    disc2 = double.parse(drugData.drugDetail.disc2);
    hrgJadi2 = double.parse(drugData.drugDetail.hrgJadi2);
    kond2 = drugData.drugDetail.kond2;
    beli3a = int.parse(drugData.drugDetail.beli3a);
    beli3b = int.parse(drugData.drugDetail.beli3b);
    bonus3 = int.parse(drugData.drugDetail.bonus3);
    disc3 = double.parse(drugData.drugDetail.disc3);
    hrgJadi3 = double.parse(drugData.drugDetail.hrgJadi3);
    kond3 = drugData.drugDetail.kond3;

    quantityMedicine = 1;

    priceMedicine = double.parse(drugData.drugDetail.hrg1Hv);
    priceFormula();

    totalPriceMedicine = (priceMedicine * quantityMedicine) - ((priceMedicine * quantityMedicine) * (finalDisc / 100));
    finalBonus = 0;
    finalDisc = 0;
  }

  void drugMeasureSegmentedButtonChanged(int index, DrugData drugData) {
    if (index == 0) {
      priceMedicine = double.parse(drugData.drugDetail.hrg1Hv);
    } else {
      priceMedicine = double.parse(drugData.drugDetail.hrg2Hv);
    }

    priceFormula();

    totalPriceMedicine = (priceMedicine * quantityMedicine) - ((priceMedicine * quantityMedicine) * (finalDisc / 100));
    // print('($priceMedicine * $quantityMedicine) - (($priceMedicine * $quantityMedicine) * ($finalDisc / 100)) = $totalPriceMedicine');
  }

  void priceFormula() {
    finalBonus = 0;
    finalDisc = 0;

    if (kond1.isNotEmpty &&
        kond1 != 'N' &&
        quantityMedicine >= beli1a &&
        quantityMedicine <= beli1b) {
      if (bonus1 != 0) {
        finalBonus = bonus1;
        finalDisc = 0;
      }
      if (disc1 != 0) {
        finalBonus = 0;
        finalDisc = disc1;
      }
      if (hrgJadi1 != 0) {
        finalBonus = 0;
        finalDisc = 0;
        priceMedicine = hrgJadi1;
      }
    } else if (kond2.isNotEmpty &&
        quantityMedicine >= beli2a &&
        quantityMedicine <= beli2b) {
      if (bonus2 != 0) {
        finalBonus = bonus2;
        finalDisc = 0;
      }
      if (disc2 != 0) {
        finalBonus = 0;
        finalDisc = disc2;
      }
      if (hrgJadi2 != 0) {
        finalBonus = 0;
        finalDisc = 0;
        priceMedicine = hrgJadi2;
      }
    } else if (kond3.isNotEmpty &&
        quantityMedicine >= beli3a &&
        quantityMedicine <= beli3b) {
      if (bonus3 != 0) {
        finalBonus = bonus3;
        finalDisc = 0;
      }
      if (disc3 != 0) {
        finalBonus = 0;
        finalDisc = disc3;
      }
      if (hrgJadi3 != 0) {
        finalBonus = 0;
        finalDisc = 0;
        priceMedicine = hrgJadi3;
      }
    }
  }

  void incrementQuantity(DrugData drugData) {
    quantityMedicine++;
    priceFormula();

    totalPriceMedicine = (priceMedicine * quantityMedicine) - ((priceMedicine * quantityMedicine) * (finalDisc / 100));
    // print('($priceMedicine * $quantityMedicine) - (($priceMedicine * $quantityMedicine) * ($finalDisc / 100)) = $totalPriceMedicine');
  }

  void decrementQuantity(DrugData drugData) {
    quantityMedicine--;
    priceFormula();

    totalPriceMedicine = (priceMedicine * quantityMedicine) - ((priceMedicine * quantityMedicine) * (finalDisc / 100));
  }

  Future<bool> masukkanKeranjangPressed(
    BuildContext context,
    String drugCode,
    OrderDialog orderDialog,
  ) async {
    priceFormula();
    AddToCartService service = AddToCartService();
    AddToCartRequest request = AddToCartRequest(
      userCode: userCode!,
      drugCode: drugCode,
      drugMeasure: drugMeasure,
      drugQty: quantityMedicine.round(),
      bonus: finalBonus,
      drugPrice: priceMedicine,
      drugPriceTotal: totalPriceMedicine,
      discount: finalDisc, 
    );

    // request.printAddToCartRequest();

    // Simulate a network delay
    // await Future.delayed(const Duration(seconds: 2));

    try {
      orderError = '';
      AddToCartResponse response = await service.addToCart(request);

      // response.printAddToCartResponse();

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
