import 'package:ecommerce_pharmacist_semarang/mvc/controller/cart_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/cart_screen/quantity_button.dart';
import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  CartController cartController = CartController();

  Widget qtyUIButton() {
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
              color: cartController.quantityMedicine == 1
                  ? ColorManager.disabledBackground
                  : const Color.fromARGB(255, 255, 223, 217),
              borderRadius: BorderRadiusManager.textfieldRadius,
            ),
            height: 34,
            width: 34,
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: cartController.quantityMedicine == 1
                  ? null
                  : () {
                      setState(() {
                        cartController.decrementQuantity();
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
              '${cartController.quantityMedicine}',
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
                  cartController.incrementQuantity();
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

  Widget deleteCartUIButton() {
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
        onPressed: () {},
        icon: const Icon(
          Symbols.delete_forever_rounded,
        ),
        color: Colors.red,
      ),
    );
  }

  Widget cartUICardView() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusManager.textfieldRadius,
      ),
      margin: PaddingMarginManager.horizontallySuperView,
      padding: PaddingMarginManager.allMiniSuperView,
      child: IntrinsicHeight(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusManager.textfieldRadius,
              child: Image.asset(
                'assets/123650.jpeg',
                height: 62,
                width: 62,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Text(
                          'Amlodipine 10 MG (MDK) 30S',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 54,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.primary,
                          borderRadius: BorderRadiusManager.textfieldRadius * 4,
                        ),
                        child: const Text(
                          textAlign: TextAlign.center,
                          'STRIP',
                          style: TextStyle(
                              color: ColorManager.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Expanded(
                        child: Text(
                          'Rp200.000',
                          style: TextStyle(color: ColorManager.primary),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          const QuantityButton(),
                          const SizedBox(width: 8),
                          deleteCartUIButton()
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cartUIListView() {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return cartUICardView();
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 16,
      ),
    );
  }

  Widget confirmOrderUIButton() {
    return SizedBox(
      height: 34,
      width: double.infinity,
      child: FilledButton(
        onPressed: () {},
        style: FilledButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: const Text(
          'Konfirmasi Order',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget bottomNavigationUIContainer() {
    return BottomAppBar(
      color: ColorManager.backgroundPage,
      height: 136,
      child: Column(
        children: [
          const IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TOTAL',
                  style: TextStyle(
                    fontSize: FontSizeManager.title2,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  'Rp600.000',
                  style: TextStyle(
                    fontSize: FontSizeManager.title2,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          confirmOrderUIButton(),
          const SizedBox(height: 8),
          const Text(
            'Catatan: pembayaran dan konfirmasi order dilakukan manual oleh pihak internal',
            style: TextStyle(
              color: ColorManager.subheadFootnote,
              fontSize: FontSizeManager.subheadFootnote,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget cartViewBody = cartUIListView();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Keranjang Belanja',
        ),
      ),
      body: cartViewBody,
      bottomNavigationBar: bottomNavigationUIContainer(),
    );
  }
}
