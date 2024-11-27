import 'package:ecommerce_pharmacist_semarang/mvc/controller/cart_controller.dart';
import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class PaymentMethodModal {
  void paymentMethodModalPressed(BuildContext context, CartController cartController) {
    showModalBottomSheet(
      backgroundColor: ColorManager.backgroundPage,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 6),
            Container(
              width: 38,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 2, color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Pilih Metode Pembayaran',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 124,
              width: double.infinity,
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
                        cartController.paymentMethodModalPressed(
                          context,
                          index,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        child: Text(
                          cartController.paymentMethodItems[index],
                          style: const TextStyle(
                            fontSize: FontSizeManager.headlineBody,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: 0.5, color: ColorManager.separator),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                itemCount: cartController.paymentMethodItems.length,
              ),
            ),
          ],
        );
      },
    );
  }
}