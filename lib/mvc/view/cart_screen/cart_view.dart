import 'package:ecommerce_pharmacist_semarang/mvc/controller/cart_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/cart/cart_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/cart_screen/quantity_button.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/empty_container.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/failure_container.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/loading_container.dart';
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

  late Future<void> futureView;

  @override
  void initState() {
    super.initState();
    futureView = cartController.viewDidLoad();
  }

  Future<void> refreshData() async {
    setState(() {
      futureView = cartController.viewDidLoad();
    });
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

  Widget cartUICardView(CartData cartData) {
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
            Container(
              color: ColorManager.white,
              child: Image.network(
                cartData.drugData.drugImage,
                height: 62,
                width: 62,
                fit: BoxFit.fitHeight,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 62,
                    width: 62,
                    child: Icon(
                      Icons.broken_image_outlined,
                      size: 48,
                    ),
                  );
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
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          cartData.drugData.drugName,
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
                        child: Text(
                          textAlign: TextAlign.center,
                          cartData.cartMeasure,
                          style: const TextStyle(
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
                      Expanded(
                        child: Text(
                          'Rp${cartData.cartDrugPrice}',
                          style: const TextStyle(color: ColorManager.primary),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          QuantityButton(
                              initialQuantity: int.parse(cartData.cartQty)),
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
    return RefreshIndicator(
      backgroundColor: Colors.white,
      displacement: 0,
      onRefresh: refreshData,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: cartController.cartDataList!.length,
        itemBuilder: (BuildContext context, int index) {
          return cartUICardView(cartController.cartDataList![index]);
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: 16,
        ),
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
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'TOTAL',
                  style: TextStyle(
                      fontSize: FontSizeManager.title2,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp${cartController.totalCartValue}',
                  style: const TextStyle(
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

  Widget muatUlangUIButton() {
    return SizedBox(
      height: 34,
      width: double.infinity,
      child: FilledButton(
        onPressed: refreshData,
        style: FilledButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: const Text(
          'Muat Ulang',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureView, // Assuming you have a `viewDidLoad` method in `cartController`
      builder: (context, snapshot) {
        // Declare variables for body content and bottom navigation bar
        Widget cartViewBody;
        Widget? bottomNavigationBar;

        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading state
          cartViewBody = const LoadingContainer();
          bottomNavigationBar = null; // Hide bottom navigation bar
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (cartController.cartError != null &&
              cartController.cartError!.isNotEmpty) {
            // Show the error state if there's an error message
            cartViewBody = Container(
              margin: PaddingMarginManager.allSuperView,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FailureContainer(
                      failureMessage:
                          'Terjadi kesalahan teknis, silahkan coba beberapa saat lagi.',
                      failureErrorCode: cartController.cartError!,
                    ),
                    const SizedBox(height: 16),
                    muatUlangUIButton()
                  ],
                ),
              ),
            );
            bottomNavigationBar = null; // Hide bottom navigation bar
          } else if (cartController.cartDataList != null &&
              cartController.cartDataList!.isNotEmpty) {
            // Show the success state
            cartViewBody = cartUIListView();
            bottomNavigationBar =
                bottomNavigationUIContainer(); // Show bottom navigation bar
          } else {
            // Show the empty state
            cartViewBody = const Center(
              child: EmptyContainer(
                emptyMessage: 'Tidak ada data dalam keranjang',
              ),
            );
            bottomNavigationBar = null; // Hide bottom navigation bar
          }
        } else {
          // Show the error state
          cartViewBody = Column(
            children: [
              FailureContainer(
                failureMessage:
                    'Terjadi kesalahan teknis, silahkan coba beberapa saat lagi.',
                failureErrorCode: cartController.cartError!,
              ),
            ],
          );
          bottomNavigationBar = null; // Hide bottom navigation bar
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Keranjang Belanja'),
          ),
          body: cartViewBody,
          bottomNavigationBar: bottomNavigationBar,
        );
      },
    );
  }
}
