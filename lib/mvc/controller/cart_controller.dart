class CartController {
  int quantityMedicine = 1;

  void incrementQuantity() {
    quantityMedicine++;
  }

  void decrementQuantity() {
    if (quantityMedicine > 1) {
      quantityMedicine--;
    }
  }
}