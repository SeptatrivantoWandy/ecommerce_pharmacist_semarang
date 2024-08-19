import 'package:ecommerce_pharmacist_semarang/mvc/controller/order_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/drug/drug_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/order_screen/add_to_cart_modal.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/empty_container.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/failure_container.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/loading_container.dart';
import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  OrderController orderController = OrderController();
  AddToCartModal addToCartModal = AddToCartModal();

  Future<void> refreshData() async {
    setState(() {}); // Rebuild the widget after data is refreshed
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
          });
        },
        style: const TextStyle(fontSize: FontSizeManager.headlineBody),
        controller: orderController.searchMedicineUIController,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: "Cari Obat",
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 26,
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
                    orderController.searchMedicineUIController.clear();
                    setState(() {
                      orderController.isNotEmptySearch = false;
                    });
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
            addToCartModal.medicineListPressed(context, orderController, drugData);
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
                      const SizedBox(width: 8),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorManager.whitePrimaryBackground,
                              borderRadius:
                                  BorderRadiusManager.textfieldRadius * 4,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 4),
                            child: const Text(
                              '1 - 5 = 3%',
                              style: TextStyle(
                                color: ColorManager.primary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: ColorManager.whitePrimaryBackground,
                              borderRadius:
                                  BorderRadiusManager.textfieldRadius * 4,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 4),
                            child: const Text(
                              '1 - 5 = 3%',
                              style: TextStyle(
                                color: ColorManager.primary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: ColorManager.whitePrimaryBackground,
                              borderRadius:
                                  BorderRadiusManager.textfieldRadius * 4,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 4),
                            child: const Text(
                              '1 - 5 = 3%',
                              style: TextStyle(
                                color: ColorManager.primary,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  drugData.drugName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: ColorManager.whitePrimaryBackground,
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
                              'HARGA',
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
                                borderRadius:
                                    BorderRadiusManager.textfieldRadius * 4,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget orderUIListView() {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: 16),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: orderController.orderDataList!.length,
        itemBuilder: (BuildContext context, int index) {
          return orderUICardView(orderController.orderDataList![index]);
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: 16,
        ),
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
      future: orderController.viewDidLoad(),
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
              IconButton(
                onPressed: () {
                  orderController.cartAppBarPressed(context);
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: ColorManager.primary,
                ),
              )
            ],
          ),
          body: orderViewBody,
        );
      },
    );
  }
}
