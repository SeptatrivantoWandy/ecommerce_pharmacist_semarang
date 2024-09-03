import 'dart:async';

import 'package:ecommerce_pharmacist_semarang/mvc/controller/cart_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/cart/cart_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/editorder/edit_order_request.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/cart_screen/cart_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class QuantityButton extends StatefulWidget {
  const QuantityButton({
    super.key,
    required this.index,
    required this.cartController,
    required this.cartDialog,
    required this.refreshData,
    required this.setState,
  });
  final int index;
  final CartController cartController;
  final CartDialog cartDialog;
  final VoidCallback refreshData;
  final StateSetter setState;

  @override
  State<QuantityButton> createState() => _QuantityButtonState();
}

class _QuantityButtonState extends State<QuantityButton> {
  late CartData selectedCartData;

  late String drugCode;
  late String drugMeasure;

  late double quantityMedicine;
  late double priceMedicine;
  late double totalPriceMedicine;
  late double initTotalCartPrice;

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

  @override
  void initState() {
    super.initState();
    setInitialData();
  }

  Future<void> setInitialData() async {
    selectedCartData = widget.cartController.cartDataList[widget.index];

    drugCode = selectedCartData.drugData.drugCode;
    drugMeasure = selectedCartData.cartMeasure;

    quantityMedicine = double.parse(selectedCartData.cartQty);

    if (drugMeasure == selectedCartData.drugData.drugDetail.drugMeasure) {
      priceMedicine = double.parse(selectedCartData.drugData.drugDetail.hrg1Hv);
    } else {
      priceMedicine = double.parse(selectedCartData.drugData.drugDetail.hrg2Hv);
    }

    beli1a = int.parse(selectedCartData.drugData.drugDetail.beli1a);
    beli1b = int.parse(selectedCartData.drugData.drugDetail.beli1b);
    bonus1 = int.parse(selectedCartData.drugData.drugDetail.bonus1);
    disc1 = double.parse(selectedCartData.drugData.drugDetail.disc1);
    hrgJadi1 = double.parse(selectedCartData.drugData.drugDetail.hrgJadi1);
    kond1 = selectedCartData.drugData.drugDetail.kond1;
    beli2a = int.parse(selectedCartData.drugData.drugDetail.beli2a);
    beli2b = int.parse(selectedCartData.drugData.drugDetail.beli2b);
    bonus2 = int.parse(selectedCartData.drugData.drugDetail.bonus2);
    disc2 = double.parse(selectedCartData.drugData.drugDetail.disc2);
    hrgJadi2 = double.parse(selectedCartData.drugData.drugDetail.hrgJadi2);
    kond2 = selectedCartData.drugData.drugDetail.kond2;
    beli3a = int.parse(selectedCartData.drugData.drugDetail.beli3a);
    beli3b = int.parse(selectedCartData.drugData.drugDetail.beli3b);
    bonus3 = int.parse(selectedCartData.drugData.drugDetail.bonus3);
    disc3 = double.parse(selectedCartData.drugData.drugDetail.disc3);
    hrgJadi3 = double.parse(selectedCartData.drugData.drugDetail.hrgJadi3);
    kond3 = selectedCartData.drugData.drugDetail.kond3;

    priceFormula();
    initTotalCartPrice = widget.cartController.totalCartPrice;
    totalPriceMedicine = (priceMedicine * quantityMedicine) -
        ((priceMedicine * quantityMedicine) * (finalDisc / 100));

    if (widget.cartController.debounce == null) {
      EditedCartData newEditedCartData = EditedCartData(
          drugCode: drugCode,
          drugMeasure: drugMeasure,
          drugQty: quantityMedicine.round(),
          bonus: finalBonus,
          drugPrice: totalPriceMedicine,
          discount: finalDisc);

      int selectedIndex = widget.cartController.editedCartDataList.indexWhere(
          (item) =>
              item.drugCode == newEditedCartData.drugCode &&
              item.drugMeasure == newEditedCartData.drugMeasure);
      widget.cartController.editedCartDataList[selectedIndex] =
          newEditedCartData;

      widget.cartController.debounce?.cancel();
      final bool isSuccess = await widget.cartController.preEditCartList(
          context,
          widget.cartDialog,
          newEditedCartData,
          widget.refreshData,
          widget.setState);
      if (!isSuccess) {
        widget.refreshData;
      }
    }
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

  Future<void> incrementQuantity() async {
    widget.setState(() {
      quantityMedicine++;
      priceFormula();

      totalPriceMedicine = (priceMedicine * quantityMedicine) -
          ((priceMedicine * quantityMedicine) * (finalDisc / 100));

      // print(
      //     '($priceMedicine * $quantityMedicine) - (($priceMedicine * $quantityMedicine) * ($finalDisc / 100)) = $totalPriceMedicine');
    });

    EditedCartData newEditedCartData = EditedCartData(
        drugCode: drugCode,
        drugMeasure: drugMeasure,
        drugQty: quantityMedicine.round(),
        bonus: finalBonus,
        drugPrice: totalPriceMedicine,
        discount: finalDisc);

    int selectedIndex = widget.cartController.editedCartDataList.indexWhere(
        (item) =>
            item.drugCode == newEditedCartData.drugCode &&
            item.drugMeasure == newEditedCartData.drugMeasure);
    widget.cartController.editedCartDataList[selectedIndex] = newEditedCartData;

    widget.cartController.debounce?.cancel();
    final bool isSuccess = await widget.cartController.preEditCartList(
        context,
        widget.cartDialog,
        newEditedCartData,
        widget.refreshData,
        widget.setState);
    if (!isSuccess) {
      widget.setState(() {
        setInitialData();
      });

      // widget.refreshData;
    }
  }

  Future<void> decrementQuantity() async {
    widget.setState(() {
      quantityMedicine--;
      priceFormula();

      totalPriceMedicine = (priceMedicine * quantityMedicine) -
          ((priceMedicine * quantityMedicine) * (finalDisc / 100));
    });

    EditedCartData newEditedCartData = EditedCartData(
        drugCode: drugCode,
        drugMeasure: drugMeasure,
        drugQty: quantityMedicine.round(),
        bonus: finalBonus,
        drugPrice: totalPriceMedicine,
        discount: finalDisc);

    int selectedIndex = widget.cartController.editedCartDataList.indexWhere(
        (item) =>
            item.drugCode == newEditedCartData.drugCode &&
            item.drugMeasure == newEditedCartData.drugMeasure);
    widget.cartController.editedCartDataList[selectedIndex] = newEditedCartData;

    widget.cartController.debounce?.cancel();
    final bool isSuccess = await widget.cartController.preEditCartList(
        context,
        widget.cartDialog,
        newEditedCartData,
        widget.refreshData,
        widget.setState);
    if (!isSuccess) {
      widget.setState(() {
        setInitialData();
      });
      // widget.refreshData;
    }
  }

  Widget deleteCartUIButton(CartData cartData, int index) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 223, 217),
        borderRadius: BorderRadiusManager.textfieldRadius,
      ),
      height: 34,
      width: 34,
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: () async {
          await widget.cartController
              .deleteItemPressed(context, cartData, widget.cartDialog, index,
                  widget.refreshData, widget.setState, setInitialData)
              .then((_) {
            widget.refreshData();
          });
        },
        icon: const Icon(
          Symbols.delete_forever_rounded,
        ),
        color: Colors.red,
      ),
    );
  }

  Widget quantityButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusManager.textfieldRadius,
        color: ColorManager.backgroundPage,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: quantityMedicine == 1
                  ? ColorManager.disabledBackground
                  : const Color.fromARGB(255, 255, 223, 217),
              borderRadius: BorderRadiusManager.textfieldRadius,
            ),
            height: 34,
            width: 34,
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: quantityMedicine == 1
                  ? null
                  : () {
                      decrementQuantity();
                    },
              icon: const Icon(
                Icons.remove,
              ),
              color: Colors.red,
            ),
          ),
          SizedBox(
            width: 48,
            child: Text(
              '${quantityMedicine.round()}',
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: ColorManager.greyPrimaryBackground,
              borderRadius: BorderRadiusManager.textfieldRadius,
            ),
            height: 34,
            width: 34,
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                incrementQuantity();
              },
              icon: const Icon(Icons.add),
              color: ColorManager.primary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            'Rp${widget.cartController.formatBalance(double.parse(totalPriceMedicine.toStringAsFixed(2)).round().toString())}',
            style: const TextStyle(color: ColorManager.primary),
          ),
        ),
        const SizedBox(width: 8),
        Row(
          children: [
            quantityButton(),
            const SizedBox(width: 8),
            deleteCartUIButton(
                widget.cartController.cartDataList[widget.index], widget.index)
          ],
        ),
      ],
    );
  }
}
