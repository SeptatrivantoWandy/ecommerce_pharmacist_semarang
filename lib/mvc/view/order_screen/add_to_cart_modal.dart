import 'package:ecommerce_pharmacist_semarang/mvc/controller/order_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/drug/drug_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/order_screen/drug_measure_segmented_button.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/order_screen/order_dialog.dart';
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

  Widget qtyUIButton(
    OrderController orderController,
    StateSetter setState,
    DrugData drugData,
  ) {
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
                        orderController.decrementQuantity(drugData);
                      });
                    },
              icon: const Icon(
                Icons.remove,
              ),
              color: Colors.red,
            ),
          ),
          SizedBox(
            width: 56,
            child: Text(
              '${orderController.quantityMedicine.round()}',
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
                  orderController.incrementQuantity(drugData);
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

  Widget qtySectionUIContainer(OrderController orderController,
      StateSetter setState, DrugData drugData) {
    return IntrinsicHeight(
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadiusManager.textfieldRadius,
              child: Container(
                color: ColorManager.white,
                child: Image.network(
                  drugData.drugImage,
                  height: 116,
                  fit: BoxFit.fitHeight,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      height: 116,
                      width: 62,
                      child: Icon(
                        Icons.broken_image_outlined,
                        size: 48,
                        color: ColorManager.disabledBackground,
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child; // Image is fully loaded
                    } else {
                      return const SizedBox(
                        height: 116,
                        width: 62,
                        child: Center(
                          child: SizedBox(
                            height: 48,
                            width: 48,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
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
                'Satuan Obat',
                style: TextStyle(
                  fontSize: FontSizeManager.subheadFootnote,
                  color: ColorManager.subheadFootnote,
                ),
              ),
              const SizedBox(height: 2),
              DrugMeasureSegmentedButton(
                drugMeasure: drugData.drugDetail.drugMeasure,
                drugMeasure2: drugData.drugDetail.drugMeasure2,
                orderController: orderController,
                drugData: drugData,
                setState: setState,
              ),
              const SizedBox(height: 16),
              const Text(
                'Jumlah Pesanan',
                style: TextStyle(
                  fontSize: FontSizeManager.subheadFootnote,
                  color: ColorManager.subheadFootnote,
                ),
              ),
              const SizedBox(height: 2),
              qtyUIButton(orderController, setState, drugData)
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget totalHargaUILabel(DrugData drugData, OrderController orderController) {
    return Container(
      margin: PaddingMarginManager.horizontallySuperView,
      decoration: BoxDecoration(
        color: ColorManager.greyPrimaryBackground,
        borderRadius: BorderRadiusManager.textfieldRadius * 4,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.sell_rounded,
                  size: 16,
                  color: ColorManager.primary,
                ),
                SizedBox(width: 4),
                Text(
                  'TOTAL HARGA',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Rp${orderController.formatBalance(double.parse(orderController.totalPriceMedicine.toStringAsFixed(2)).round().toString())}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorManager.primary,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget addToCartUIButton(
      BuildContext context,
      OrderController orderController,
      DrugData drugData,
      OrderDialog orderDialog,
      VoidCallback refreshCartLength) {
    return Container(
      margin: PaddingMarginManager.horizontallySuperView,
      height: 34,
      width: double.infinity,
      child: FilledButton(
        onPressed: () async {
          orderDialog.loadingAlertDialog(context);
          bool isSuccess = await orderController.masukkanKeranjangPressed(
            context,
            drugData.drugCode,
            orderDialog,
          );
          if (context.mounted) {
            Navigator.of(context).pop();
          }
          if (isSuccess) {
            if (context.mounted) {
              // Navigator.of(context).pop();
              orderDialog.successAlertDialog(
                  context, 'Produk berhasil ditambahkan ke keranjang.');
              refreshCartLength();
            }
          } else {
            if (context.mounted) {
              // Navigator.of(context).pop();
              orderDialog.failureAlertDialog(
                context,
                'Gagal menambahkan ke keranjang.',
                orderController.orderError!,
              );
            }
          }
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

  void medicineListPressed(
    BuildContext context,
    OrderController orderController,
    DrugData drugData,
    OrderDialog orderDialog,
    VoidCallback refreshCartLength,
  ) {
    orderController.initAddToCartModal(drugData);
    showModalBottomSheet(
      backgroundColor: ColorManager.backgroundPage,
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
                      qtySectionUIContainer(
                          orderController, setState, drugData),
                      const SizedBox(height: 8),
                      medicineNameUILabel(drugData),
                      const SizedBox(height: 8),
                      totalHargaUILabel(drugData, orderController),
                      const SizedBox(height: 16),
                      addToCartUIButton(context, orderController, drugData,
                          orderDialog, refreshCartLength),
                      const SizedBox(height: 16),
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
