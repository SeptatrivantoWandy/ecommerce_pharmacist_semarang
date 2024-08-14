import 'package:ecommerce_pharmacist_semarang/mvc/controller/history_controller.dart';
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

  Widget historyItemUICardView() {
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
                const Iconify(
                  Ri.medicine_bottle_fill,
                  size: 20,
                  color: ColorManager.primary,
                ),
                const SizedBox(width: 6),
                const Expanded(
                  child: Text(
                    'Amlodipine 10 MG (MDK) 30S',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                        color: ColorManager.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 4),
          const IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jumlah',
                      style: TextStyle(color: Color.fromRGBO(22, 133, 129, 1)),
                    ),
                    Text('2'),
                    SizedBox(height: 4),
                    Text(
                      'Harga',
                      style: TextStyle(color: Color.fromRGBO(22, 133, 129, 1)),
                    ),
                    Text('Rp5.000')
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bonus',
                      style: TextStyle(color: Color.fromRGBO(22, 133, 129, 1)),
                    ),
                    Text('Rp2.000'),
                    SizedBox(height: 4),
                    Text(
                      'Diskon',
                      style: TextStyle(color: Color.fromRGBO(22, 133, 129, 1)),
                    ),
                    Text('Rp1.000')
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Jumlah Harga',
                      style: TextStyle(color: Color.fromRGBO(22, 133, 129, 1)),
                    ),
                    Text('Rp10.000')
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

  Widget historyItemUIListView() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return historyItemUICardView();
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 8,
      ),
    );
  }

  Widget historyUICardView() {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const IntrinsicHeight(
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month_rounded,
                              color: ColorManager.primary,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '01/08/2024',
                              style: TextStyle(
                                color: ColorManager.subheadFootnote,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      IntrinsicHeight(
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
                            const Text(
                              '#123456',
                              style: TextStyle(
                                  color: ColorManager.subheadFootnote,
                                  fontSize: FontSizeManager.subheadFootnote),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 118,
                    decoration: BoxDecoration(
                      gradient: historyController.isApprove
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
                            historyController.isApprove
                                ? Icons.check_circle_outline_rounded
                                : Icons.schedule,
                            color: ColorManager.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            historyController.isApprove
                                ? 'Disetujui'
                                : 'Menunggu',
                            style: const TextStyle(
                                color: ColorManager.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          historyItemUIListView(),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadiusManager.textfieldRadius,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: const IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.payments_outlined,
                        size: 20,
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
                        'Rp2.000.000',
                        style: TextStyle(
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
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return historyUICardView();
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget historyViewBody = historyUIListView();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Order Pesanan'),
      ),
      body: historyViewBody,
    );
  }
}
