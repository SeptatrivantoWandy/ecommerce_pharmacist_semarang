import 'package:ecommerce_pharmacist_semarang/mvc/controller/order_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/drug/drug_response.dart';
import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class AddToCartModal {
  Widget medicineNameUILabel(DrugData drugData) {
    return Container(
      width: double.infinity,
      margin: PaddingMarginManager.horizontallySuperView,
      child: Text(
        drugData.drugName,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget qtyUIButton(OrderController orderController, StateSetter setState) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusManager.textfieldRadius,
        color: ColorManager.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: orderController.quantityMedicine == 1
                  ? ColorManager.disabledBackground
                  : const Color.fromARGB(255, 255, 223, 217),
              borderRadius: BorderRadiusManager.textfieldRadius,
            ),
            height: 34,
            width: 34,
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: orderController.quantityMedicine == 1
                  ? null
                  : () {
                      setState(() {
                        orderController.decrementQuantity();
                      });
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
              '${orderController.quantityMedicine}',
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
                setState(() {
                  orderController.incrementQuantity();
                });
              },
              icon: const Icon(Icons.add),
              color: ColorManager.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget qtySectionUIContainer(
      OrderController orderController, StateSetter setState, DrugData drugData) {
    return IntrinsicHeight(
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadiusManager.textfieldRadius,
              // child: Image.asset(
              //   'assets/123650.jpeg',
              //   height: 124,
              //   // width: 200,
              //   fit: BoxFit.cover,
              // ),
              child: Container(
                color: ColorManager.white,
                child: Image.network(
                  drugData.drugImage,
                  height: 100,
                  fit: BoxFit.fitHeight,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Failed to load image');
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child; // Image is fully loaded
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Jumlah Pesanan',
                style: TextStyle(
                  fontSize: FontSizeManager.subheadFootnote,
                  color: ColorManager.subheadFootnote,
                ),
              ),
              const SizedBox(height: 8),
              qtyUIButton(orderController, setState)
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget totalHargaUILabel(DrugData drugData) {
    return Container(
      margin: PaddingMarginManager.horizontallySuperView,
      decoration: BoxDecoration(
        color: ColorManager.greyPrimaryBackground,
        borderRadius: BorderRadiusManager.textfieldRadius * 4,
      ),
      padding: const EdgeInsets.only(left: 12),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.sell_rounded,
                  size: 20,
                  color: ColorManager.primary,
                ),
                SizedBox(width: 8),
                Text(
                  'TOTAL HARGA',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Rp${drugData.drugDetail.hrg1Hv}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorManager.primary,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 74,
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadiusManager.textfieldRadius * 4,
                  ),
                  child: Text(
                    drugData.drugDetail.drugMeasure,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: ColorManager.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget addToCartUIButton(BuildContext context,
      OrderController orderController, DrugData drugData) {
    return Container(
      margin: PaddingMarginManager.horizontallySuperView,
      height: 34,
      width: double.infinity,
      child: FilledButton(
        onPressed: () {
          orderController.masukkanKeranjangPressed();
          Navigator.of(context).pop();
        },
        style: FilledButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: const Text(
          'Masukkan Keranjang',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void medicineListPressed(BuildContext context,
      OrderController orderController, DrugData drugData) {
    orderController.quantityMedicine = 1;
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 6),
                Container(
                  width: 38,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: ColorManager.primary,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // const SizedBox(height: 12),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 40,
                        width: 52,
                      ),
                      const Text(
                        'Tambah Keranjang',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 40,
                        width: 52,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.cancel,
                            // size: 32,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  // height: 188,
                  width: double.infinity,
                  child: Column(
                    children: [
                      qtySectionUIContainer(orderController, setState, drugData),
                      const SizedBox(height: 8),
                      medicineNameUILabel(drugData),
                      const SizedBox(height: 8),
                      totalHargaUILabel(drugData),
                      const SizedBox(height: 16),
                      addToCartUIButton(context, orderController, drugData),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
