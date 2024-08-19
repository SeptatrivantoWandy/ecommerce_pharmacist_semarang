import 'package:ecommerce_pharmacist_semarang/mvc/view/cart_screen/cart_view.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/history_screen/history_view.dart';
import 'package:ecommerce_pharmacist_semarang/service.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/drug/drug_response.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderController {
  bool isNotEmptySearch = false;
  TextEditingController searchMedicineUIController = TextEditingController();
  int quantityMedicine = 1;
  String? orderError;
  List<DrugData>? orderDataList;

  Future<void> viewDidLoad() async {
    await fetchMedicineOrder();
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
        hrg1Hv: formatBalance(drugData.drugDetail.hrg1Hv),
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
    } else {
      orderError = 'Failed to fetch drug data.';
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

  void masukkanKeranjangPressed() {
    print('quantityMedicine: ${quantityMedicine}');
  }
}
