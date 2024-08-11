import 'package:flutter/material.dart';

class OrderController {
  bool isNotEmptySearch = false;
  TextEditingController searchMedicineUIController = TextEditingController();
  int quantityMedicine = 1;

  fetchMedicineOrder () {
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