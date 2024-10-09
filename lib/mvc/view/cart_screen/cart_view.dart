import 'package:ecommerce_pharmacist_semarang/mvc/controller/cart_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/cart/cart_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/cart_screen/cart_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/cart_screen/quantity_button.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/empty_container.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/failure_container.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/loading_container.dart';
import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  CartController cartController = CartController();
  CartDialog cartDialog = CartDialog();

  late Future<void> futureView;

  @override
  void initState() {
    super.initState();
    futureView = cartController.viewDidLoad();
    cartController.scrollController.addListener(() {
      setState(() {
        cartController.scrollPercentage =
            cartController.scrollController.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    // Always dispose the controller to avoid memory leaks
    cartController.scrollController.dispose();
    super.dispose();
  }

  Future<bool> refreshData() async {
    if (cartController.debounce == null || !cartController.debounce!.isActive) {
      if (cartController.isEditSuccess == 'isSuccess') {
        setState(() {
          futureView = cartController.viewDidLoad();
        });
        return true;
      } else {
        bool isEditSuccess = false;
        if (context.mounted) {
          BuildContext localContext = context;
          isEditSuccess = await cartController.editOrder(
            localContext,
            cartDialog,
            refreshData,
            setState,
          );
        }
        if (isEditSuccess) {
          setState(() {
            futureView = cartController.viewDidLoad();
          });
          return true;
        }
      }
    }
    return false;
  }

  Widget cartUICardView(CartData cartData, int index) {
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
                        width: 64,
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
                  QuantityButton(
                    index: index,
                    cartController: cartController,
                    cartDialog: cartDialog,
                    refreshData: refreshData,
                    setState: setState,
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
        controller: cartController.scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: cartController.cartDataList.length,
        itemBuilder: (BuildContext context, int index) {
          return cartUICardView(cartController.cartDataList[index], index);
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
        onPressed: cartController.debounce != null &&
                !cartController.debounce!.isActive
            ? () async {
                if (cartController.isEditSuccess == 'isSuccess') {
                  cartController.konfirmasiOrderPressed(
                    context,
                    cartDialog,
                  );
                } else {
                  final bool isEditSuccess = await cartController.editOrder(
                    context,
                    cartDialog,
                    refreshData,
                    setState,
                  );
                  if (isEditSuccess && context.mounted) {
                    BuildContext localContext = context;
                    cartController.konfirmasiOrderPressed(
                      localContext,
                      cartDialog,
                    );
                  }
                }
              }
            : null,
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
      height: 142,
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
                cartController.debounce != null &&
                        !cartController.debounce!.isActive
                    ? Text(
                        'Rp${cartController.isEditSuccess == 'isSuccess' ? cartController.totalCartValue : '-1'}',
                        style: TextStyle(
                          fontSize: FontSizeManager.title2,
                          fontWeight: FontWeight.bold,
                          color: cartController.debounce != null &&
                                  !cartController.debounce!.isActive &&
                                  cartController.isEditSuccess == 'isSuccess'
                              ? ColorManager.primary
                              : ColorManager.negative,
                        ),
                      )
                    : Shimmer.fromColors(
                        baseColor: ColorManager.disabledBackground,
                        highlightColor: const Color.fromARGB(0, 0, 0, 0),
                        child: Container(
                          width: 118.0,
                          height: 26.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadiusManager.textfieldRadius,
                          ),
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
      future:
          futureView, // Assuming you have a `viewDidLoad` method in `cartController`
      builder: (context, snapshot) {
        // Declare variables for body content and bottom navigation bar
        Widget cartViewBody;
        Widget? bottomNavigationBar;

        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading state
          cartViewBody = const LoadingContainer();
          bottomNavigationBar = null; // Hide bottom navigation bar
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (cartController.cartError.isNotEmpty) {
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
                      failureErrorCode: cartController.cartError,
                    ),
                    const SizedBox(height: 16),
                    muatUlangUIButton()
                  ],
                ),
              ),
            );
            bottomNavigationBar = null; // Hide bottom navigation bar
          } else if (cartController.cartDataList.isNotEmpty) {
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
                failureErrorCode: cartController.cartError,
              ),
            ],
          );
          bottomNavigationBar = null; // Hide bottom navigation bar
        }

        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (didPop) {
              return;
            }
            if (cartController.debounce == null ||
                !cartController.debounce!.isActive) {
              Navigator.of(context).pop();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Keranjang Belanja'),
            ),
            body: cartViewBody,
            bottomNavigationBar: bottomNavigationBar,
          ),
        );
      },
    );
  }
}
