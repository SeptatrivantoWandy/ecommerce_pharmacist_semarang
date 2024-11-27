import 'package:ecommerce_pharmacist_semarang/mvc/controller/customer_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/empty_container.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/failure_container.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/loading_container.dart';
import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class CustomerView extends StatefulWidget {
  const CustomerView({super.key});

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  CustomerController customerController = CustomerController();
  late Future<void> futureView;

  @override
  void initState() {
    super.initState();
    futureView = customerController.viewDidLoad();
  }

  Future<void> refreshData() async {
    setState(() {
      futureView = customerController.viewDidLoad();
    });
  }

  searchUITextField() {
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
            customerController.isNotEmptySearch = value.isNotEmpty;
            customerController.searchDrug(value);
          });
        },
        style: const TextStyle(fontSize: FontSizeManager.headlineBody),
        controller: customerController.searchCustomerUIController,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: "Cari Pelanggan",
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 24,
            color: ColorManager.primary,
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 36,
            minHeight: 34,
          ),
          suffixIcon: customerController.isNotEmptySearch
              ? IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      customerController.cancelSearchPressed();
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

  Widget customerListView() {
    if (customerController.searchDataList!.isEmpty) {
      return const Expanded(
        child: Center(
          child: EmptyContainer(
            emptyMessage: 'Pelanggan tidak ditemukan',
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
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: double.infinity,
                child: InkWell(
                  onTap: () {
                    customerController.customerUIListItemPressed(
                        context, index);
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Text(
                      customerController.searchDataList?[index].customerName ??
                          '',
                      style: const TextStyle(
                        fontSize: FontSizeManager.headlineBody,
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: ColorManager.separator),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            itemCount: customerController.searchDataList?.length ?? 0,
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
      future: futureView,
      builder: (context, snapshot) {
        Widget customerViewBody = Container();

        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading state
          customerViewBody = const LoadingContainer();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (customerController.customerError.isNotEmpty) {
            customerViewBody = Container(
              margin: PaddingMarginManager.allSuperView,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FailureContainer(
                      failureMessage:
                          'Terjadi kesalahan teknis, silahkan coba beberapa saat lagi.',
                      failureErrorCode: customerController.customerError,
                    ),
                    const SizedBox(height: 16),
                    muatUlangUIButton()
                  ],
                ),
              ),
            );
          } else if (customerController.customerDataList != null &&
              customerController.customerDataList!.isNotEmpty) {
            customerViewBody = Column(
              children: [
                searchUITextField(),
                const SizedBox(height: 16),
                customerListView(),
              ],
            );
          } else {
            // Show the empty state
            customerViewBody = const Center(
              child: EmptyContainer(
                emptyMessage: 'Tidak ada data customer',
              ),
            );
          }
        } else {
          // Show the error state
          customerViewBody = Column(
            children: [
              FailureContainer(
                failureMessage:
                    'Terjadi kesalahan teknis, silahkan coba beberapa saat lagi.',
                failureErrorCode: customerController.customerError,
              ),
            ],
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Pilih Pelanggan'),
          ),
          body: customerViewBody,
        );
      },
    );
  }
}
