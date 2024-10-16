import 'package:ecommerce_pharmacist_semarang/mvc/controller/history_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/history/history_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/empty_container.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/failure_container.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/loading_container.dart';
import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  HistoryController historyController = HistoryController();

  late Future<void> futureView;

  @override
  void initState() {
    super.initState();
    futureView = historyController.viewDidLoad();
  }

  Future<void> refreshData() async {
    setState(() {
      futureView = historyController.viewDidLoad();
    });
  }

  Widget historyItemUICardView(HistoryDrugData historyDrugData) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.whitePrimaryBackground,
        borderRadius: BorderRadiusManager.textfieldRadius,
      ),
      margin: PaddingMarginManager.miniHorizontallySuperView,
      padding: PaddingMarginManager.miniHorizontallySuperView,
      child: Column(
        children: [
          const SizedBox(height: 8),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: const Iconify(
                    Ri.medicine_bottle_fill,
                    size: 16,
                    color: ColorManager.primary,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    historyDrugData.drugName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
                    historyDrugData.drugMeasure,
                    style: const TextStyle(
                      color: ColorManager.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 4),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Jumlah',
                      style: TextStyle(color: Color.fromRGBO(22, 133, 129, 1)),
                    ),
                    Text(historyDrugData.orderQty),
                    const SizedBox(height: 4),
                    const Text(
                      'Harga',
                      style: TextStyle(color: Color.fromRGBO(22, 133, 129, 1)),
                    ),
                    Text('Rp${historyDrugData.drugPrice}')
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bonus',
                      style: TextStyle(color: Color.fromRGBO(22, 133, 129, 1)),
                    ),
                    Text(historyDrugData.bonus),
                    const SizedBox(height: 4),
                    const Text(
                      'Diskon',
                      style: TextStyle(color: Color.fromRGBO(22, 133, 129, 1)),
                    ),
                    Text(
                        '${historyController.formatDiscountString(historyDrugData.discount)}%')
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Jumlah Harga',
                      style: TextStyle(color: Color.fromRGBO(22, 133, 129, 1)),
                    ),
                    Text('Rp${historyDrugData.drugPriceTotal}')
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget historyItemUIListView(HistoryData historyData) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: historyData.drugData.length,
      itemBuilder: (BuildContext context, int index) {
        return historyItemUICardView(historyData.drugData[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 8,
      ),
    );
  }

  Widget historyUICardView(HistoryData historyData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusManager.textfieldRadius,
      ),
      margin: PaddingMarginManager.horizontallySuperView,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusManager.textfieldRadius,
            ),
            padding: PaddingMarginManager.allMiniSuperView,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_rounded,
                            color: ColorManager.primary,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            historyData.orderDate,
                            style: const TextStyle(
                              color: ColorManager.subheadFootnote,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 126,
                    decoration: BoxDecoration(
                      gradient: historyData.orderStatus != ''
                          ? const LinearGradient(
                              colors: [
                                Color.fromRGBO(22, 133, 129, 1),
                                Color.fromRGBO(104, 209, 162, 1),
                              ],
                            )
                          : const LinearGradient(
                              colors: [
                                Color.fromRGBO(199, 134, 8, 1),
                                Color.fromRGBO(253, 186, 106, 1),
                              ],
                            ),
                      borderRadius: BorderRadiusManager.textfieldRadius * 4,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            historyData.orderStatus != ''
                                ? Icons.check_circle_outline_rounded
                                : Icons.schedule,
                            color: ColorManager.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            historyData.orderStatus != ''
                                ? 'Disetujui'
                                : 'Menunggu',
                            style: const TextStyle(
                                color: ColorManager.white,
                                fontWeight: FontWeight.bold,
                                ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: PaddingMarginManager.miniHorizontallySuperView,
            child: IntrinsicHeight(
              child: Row(
                children: [
                  const Text(
                    'Nomor Order',
                    style: TextStyle(
                        color: Color.fromRGBO(22, 133, 129, 1),
                        fontSize: FontSizeManager.subheadFootnote),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: ColorManager.subheadFootnote,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '#${historyData.orderNo}',
                    style: const TextStyle(
                        color: ColorManager.subheadFootnote,
                        fontSize: FontSizeManager.subheadFootnote),
                  ),
                ],
              ),
            ),
          ),
          historyItemUIListView(historyData),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadiusManager.textfieldRadius,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.payments_outlined,
                        size: 16,
                        color: ColorManager.white,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Total Harga',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.white,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Rp${historyData.orderTotal}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.white,
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
    );
  }

  Widget historyUIListView() {
    return RefreshIndicator(
      backgroundColor: Colors.white,
      displacement: 0,
      onRefresh: refreshData,
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: 16),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: historyController.historyDataList!.length,
        itemBuilder: (BuildContext context, int index) {
          return historyUICardView(historyController.historyDataList![index]);
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
      future: futureView,
      builder: (context, snapshot) {
        Widget historyViewBody;

        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading state
          historyViewBody = const LoadingContainer();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (historyController.historyError != null &&
              historyController.historyError!.isNotEmpty) {
            // Show the error state if there's an error message
            historyViewBody = Container(
              margin: PaddingMarginManager.allSuperView,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FailureContainer(
                      failureMessage:
                          'Terjadi kesalahan teknis, silahkan coba beberapa saat lagi.',
                      failureErrorCode: historyController.historyError!,
                    ),
                    const SizedBox(height: 16),
                    muatUlangUIButton()
                  ],
                ),
              ),
            );
          } else if (historyController.historyDataList != null &&
              historyController.historyDataList!.isNotEmpty) {
            // Show the success state
            historyViewBody = historyUIListView();
          } else {
            // Show the empty state
            historyViewBody = const Center(
              child: EmptyContainer(
                emptyMessage: 'Tidak ada data riwayat',
              ),
            );
          }
        } else {
          // Show the error state
          historyViewBody = Column(
            children: [
              FailureContainer(
                failureMessage:
                    'Terjadi kesalahan teknis, silahkan coba beberapa saat lagi.',
                failureErrorCode: historyController.historyError!,
              ),
            ],
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Riwayat Order Pesanan'),
          ),
          body: SafeArea(child: historyViewBody),
        );
      },
    );
  }
}
