import 'package:ecommerce_pharmacist_semarang/mvc/view/cart_screen/cart_view.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/history_screen/history_view.dart';
import 'package:flutter/material.dart';

class OrderController {
  bool isNotEmptySearch = false;
  TextEditingController searchMedicineUIController = TextEditingController();
  int quantityMedicine = 1;

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

  fetchMedicineOrder() {
    return print('fetching medicine');
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
