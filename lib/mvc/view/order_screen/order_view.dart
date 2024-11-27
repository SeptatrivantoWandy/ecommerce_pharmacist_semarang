import 'package:ecommerce_pharmacist_semarang/mvc/controller/cart_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/controller/order_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/drug/drug_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/order_screen/add_to_cart_modal.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/order_screen/order_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/empty_container.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/failure_container.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/loading_container.dart';
import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key, required this.customerName});
  final String customerName;

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  OrderController orderController = OrderController();
  CartController cartController = CartController();
  OrderDialog orderDialog = OrderDialog();
  AddToCartModal addToCartModal = AddToCartModal();

  late Future<void> futureView;

  @override
  void initState() {
    super.initState();
    futureView = orderController.viewDidLoad(cartController);
  }

  Future<void> refreshData() async {
    setState(() {
      futureView = orderController.viewDidLoad(cartController);
    });
  }

  Future<void> refreshCartLength() async {
    await orderController.getCartLength(cartController);
    setState(() {});
  }

  Widget searchUITextField() {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadiusManager.textfieldRadius,
      ),
      height: SizeManager.textFieldContainerHeight,
      margin: PaddingMarginManager.textField,
      child: TextField(
        onChanged: (value) {
          setState(() {
            orderController.isNotEmptySearch = value.isNotEmpty;
            orderController.searchDrug(value);
          });
        },
        style: const TextStyle(fontSize: FontSizeManager.headlineBody),
        controller: orderController.searchMedicineUIController,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: "Cari Obat",
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 24,
            color: ColorManager.primary,
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 36,
            minHeight: 34,
          ),
          suffixIcon: orderController.isNotEmptySearch
              ? IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    orderController.cancelSearchPressed();
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.cancel_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  Widget orderUICardView(DrugData drugData) {
    return Container(
      margin: PaddingMarginManager.horizontallySuperView,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadiusManager.textfieldRadius,
        child: InkWell(
          borderRadius: BorderRadiusManager.textfieldRadius,
          onTap: () {
            addToCartModal.medicineListPressed(
              context,
              orderController,
              drugData,
              orderDialog,
              refreshCartLength,
            );
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadiusManager.textfieldRadius,
                          child: Container(
                            color: ColorManager.white,
                            child: drugData.drugImage.isNotEmpty
                                ? Image.network(
                                    drugData.drugImage,
                                    height: 100,
                                    fit: BoxFit.fitHeight,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        padding:
                                            PaddingMarginManager.allSuperView,
                                        height: 100,
                                        width: 62,
                                        child: Image.asset(
                                          'assets/semesta_megah_sentosa_icon.png',
                                          height: 12,
                                          width: 12,
                                        ),
                                      );
                                    },
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child; // Image is fully loaded
                                      } else {
                                        return const SizedBox(
                                          height: 100,
                                          width: 62,
                                          child: Center(
                                            child: SizedBox(
                                              height: 48,
                                              width: 48,
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  )
                                : Container(
                                    padding: PaddingMarginManager.allSuperView,
                                    height: 100,
                                    width: 62,
                                    child: Image.asset(
                                      'assets/semesta_megah_sentosa_icon.png',
                                      height: 12,
                                      width: 12,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        children: [
                          Container(
                            width: 175,
                            decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius:
                                  BorderRadiusManager.textfieldRadius * 4,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 4),
                            child: Text(
                              drugData.drugDetail.kond1.isEmpty
                                  ? '-'
                                  : orderController.reformatCondition(
                                      drugData.drugDetail.kond1),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: ColorManager.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 175,
                            decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius:
                                  BorderRadiusManager.textfieldRadius * 4,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 4),
                            child: Text(
                              drugData.drugDetail.kond2.isEmpty
                                  ? '-'
                                  : orderController.reformatCondition(
                                      drugData.drugDetail.kond2),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: ColorManager.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 175,
                            decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius:
                                  BorderRadiusManager.textfieldRadius * 4,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 4),
                            child: Text(
                              drugData.drugDetail.kond3.isEmpty
                                  ? '-'
                                  : orderController.reformatCondition(
                                      drugData.drugDetail.kond3),
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
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: drugData.drugName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors
                              .black, // Assuming default text color is black
                        ),
                      ),
                      TextSpan(
                        text: ' (${drugData.drugDetail.drugMeasure}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorManager
                              .primary, // Blue color for drugMeasure
                        ),
                      ),
                      drugData.drugDetail.drugMeasure2.isNotEmpty
                          ? TextSpan(
                              text: ', ${drugData.drugDetail.drugMeasure2})',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager
                                    .primary, // Blue color for drugMeasure
                              ),
                            )
                          : const TextSpan(
                              text: ')',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager
                                    .primary, // Blue color for drugMeasure
                              ),
                            ),
                      TextSpan(
                        text: ' ${drugData.drugDetail.expiryDate}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.negative,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: ColorManager.whitePrimaryBackground,
                    borderRadius: BorderRadiusManager.textfieldRadius * 4,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                              'HNA',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Rp${orderController.formatBalance(double.parse(drugData.drugDetail.hrg1Hv).round().toString())}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.primary,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget orderUIListView() {
    if (orderController.searchDataList!.isEmpty) {
      return const Expanded(
        child: Center(
          child: EmptyContainer(
            emptyMessage: 'Obat tidak ditemukan',
          ),
        ),
      );
    } else {
      return Expanded(
        child: RefreshIndicator(
          backgroundColor: Colors.white,
          displacement: 0,
          onRefresh: refreshData,
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 16),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: orderController.searchDataList!.length,
            itemBuilder: (BuildContext context, int index) {
              return orderUICardView(orderController.searchDataList![index]);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 16,
            ),
          ),
        ),
      );
    }
  }

  Widget muatUlangUIButton() {
    return SizedBox(
      height: 34,
      width: double.infinity,
      child: FilledButton(
        onPressed: () {
          refreshData();
        },
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

  cartUIIconButton() {
    return Stack(
      clipBehavior: Clip.none, // To allow the badge to overflow the stack
      children: [
        IconButton(
          onPressed: () {
            orderController.cartAppBarPressed(context, refreshCartLength);
          },
          icon: const Icon(
            Icons.shopping_cart_outlined,
            color: ColorManager.primary,
          ),
        ),
        if (orderController.cartLength != null &&
            orderController.cartLength! > 0)
          Positioned(
            top: 6,
            right: 10,
            child: InkWell(
              onTap: () {
                orderController.cartAppBarPressed(context, refreshCartLength);
              },
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadiusManager.textfieldRadius * 4,
              ),
              child: Container(
                alignment: Alignment.center,
                height: 16,
                width: 16,
                decoration: const BoxDecoration(
                  color: ColorManager.negative, // Background color of the badge
                  shape: BoxShape.circle,
                ),
                child: Text(
                  orderController.cartLength.toString(),
                  style: const TextStyle(
                    color: ColorManager.white, // Text color of the badge
                    fontSize: FontSizeManager.subheadFootnote -
                        2, // Font size of the badge text
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget customerNameUILabel() {
    return Container(
      margin: PaddingMarginManager.horizontallySuperView,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nama Pelanggan',
            style: TextStyle(
              fontSize: FontSizeManager.subheadFootnote,
              color: ColorManager.subheadFootnote,
            ),
          ),
          const SizedBox(height: 2),
          Text(widget.customerName),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureView,
      builder: (context, snapshot) {
        Widget orderViewBody;

        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading state
          orderViewBody = const LoadingContainer();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (orderController.orderError != null &&
              orderController.orderError!.isNotEmpty) {
            // Show the error state if there's an error message
            orderViewBody = Container(
              margin: PaddingMarginManager.allSuperView,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FailureContainer(
                      failureMessage:
                          'Terjadi kesalahan teknis, silahkan coba beberapa saat lagi.',
                      failureErrorCode: orderController.orderError!,
                    ),
                    const SizedBox(height: 16),
                    muatUlangUIButton()
                  ],
                ),
              ),
            );
          } else if (orderController.orderDataList != null &&
              orderController.orderDataList!.isNotEmpty) {
            // Show the success state
            orderViewBody = Column(
              children: [
                customerNameUILabel(),
                const SizedBox(height: 12),
                searchUITextField(),
                const SizedBox(height: 16),
                orderUIListView()
              ],
            );
          } else {
            // Show the empty state
            orderViewBody = const Center(
              child: EmptyContainer(
                emptyMessage: 'Tidak ada data obat',
              ),
            );
          }
        } else {
          // Show the error state
          orderViewBody = Column(
            children: [
              FailureContainer(
                failureMessage:
                    'Terjadi kesalahan teknis, silahkan coba beberapa saat lagi.',
                failureErrorCode: orderController.orderError!,
              ),
            ],
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Order Pesanan'),
            actions: [
              IconButton(
                onPressed: () {
                  orderController.historyAppBarPressed(context);
                },
                icon: const Icon(
                  Icons.history_rounded,
                  color: ColorManager.primary,
                ),
              ),
              cartUIIconButton()
            ],
          ),
          body: orderViewBody,
        );
      },
    );
  }
}
