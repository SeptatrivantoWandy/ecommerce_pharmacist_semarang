import 'package:ecommerce_pharmacist_semarang/mvc/controller/order_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/order_screen/add_to_cart_modal.dart';
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

  Widget orderUICardView() {
    return Container(
      margin: PaddingMarginManager.horizontallySuperView,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadiusManager.textfieldRadius,
        child: InkWell(
          borderRadius: BorderRadiusManager.textfieldRadius,
          onTap: () {
            addToCartModal.medicineListPressed(context, orderController);
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
                          child: Image.asset(
                            'assets/123650.jpeg',
                            height: 124,
                            fit: BoxFit.cover,
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
                                horizontal: 24, vertical: 8),
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
                                horizontal: 24, vertical: 8),
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
                                horizontal: 24, vertical: 8),
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
                const Text(
                  'Amlodipine 10 MG (MDK) 30S',
                  style: TextStyle(
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
                            const Text(
                              'Rp2.000.000',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.primary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius:
                                    BorderRadiusManager.textfieldRadius * 4,
                              ),
                              child: const Text(
                                'BOX',
                                style: TextStyle(color: ColorManager.white),
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
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return orderUICardView();
          },
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
                height: 16,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget orderViewBody = Column(
      children: [
        searchUITextField(),
        const SizedBox(height: 16),
        orderUIListView()
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Pesanan'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.history_rounded,
              color: ColorManager.primary,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: ColorManager.primary,
            ),
          )
        ],
      ),
      body: orderViewBody,
    );
  }
}
