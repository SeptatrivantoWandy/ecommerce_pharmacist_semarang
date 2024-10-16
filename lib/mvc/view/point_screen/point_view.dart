import 'package:ecommerce_pharmacist_semarang/mvc/controller/point_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/point/point_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/empty_container.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/failure_container.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/loading_container.dart';
import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class PointView extends StatefulWidget {
  const PointView({super.key});

  @override
  State<PointView> createState() => _PointViewState();
}

class _PointViewState extends State<PointView> {
  PointController pointController = PointController();

  late Future<void> futureView;

  @override
  void initState() {
    super.initState();
    futureView = pointController.viewDidLoad();
  }

  Future<void> refreshData() async {
    setState(() {
      futureView = pointController.viewDidLoad();
    });
  }

  Widget klaimPointUIButton() {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      height: 34,
      child: FilledButton(
        onPressed: () async {
          final result = await pointController.klaimPointPressed(context);
          if (result) {
            refreshData();
          }
        },
        style: FilledButton.styleFrom(
          padding: PaddingMarginManager.miniHorizontallySuperView,
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: const Text(
          textAlign: TextAlign.center,
          'Klaim Point',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: FontSizeManager.subheadFootnote),
        ),
      ),
    );
  }

  Widget dateRangeUIPicker() {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.textfieldRadius,
      ),
      onTap: () async {
        await pointController.selectDateRange(context);
        refreshData();
      },
      child: IntrinsicHeight(
        child: Row(
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_month_rounded,
                    size: 16,
                    color: ColorManager.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    pointController.formatDate(pointController.startDate),
                    style: const TextStyle(
                      color: ColorManager.subheadFootnote,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 16),
            const Text('s/d'),
            const SizedBox(width: 16),
            IntrinsicHeight(
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_month_rounded,
                    size: 16,
                    color: ColorManager.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    pointController.formatDate(pointController.endDate),
                    style: const TextStyle(
                      color: ColorManager.subheadFootnote,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pointUICardView(SaldoPointData pointData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusManager.textfieldRadius,
      ),
      padding: PaddingMarginManager.allMiniSuperView,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_month_rounded,
                  size: 16,
                  color: ColorManager.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  pointData.pointDate,
                  style: const TextStyle(
                    color: ColorManager.primary,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Keterangan',
            style: TextStyle(
                color: Color.fromRGBO(22, 133, 129, 1),
                fontSize: FontSizeManager.subheadFootnote),
          ),
          Text(
            pointData.notes,
            style: const TextStyle(color: ColorManager.subheadFootnote),
          ),
          const SizedBox(height: 8),
          separatorWidget(0),
          const SizedBox(height: 8),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Masuk',
                      style: TextStyle(
                          color: Color.fromRGBO(22, 133, 129, 1),
                          fontSize: FontSizeManager.subheadFootnote),
                    ),
                    Text(
                      '+Rp${pointData.pointIn}',
                      style: TextStyle(
                        color: pointData.pointIn != '0'
                            ? ColorManager.primary
                            : ColorManager.subheadFootnote,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Keluar',
                      style: TextStyle(
                          color: Color.fromRGBO(22, 133, 129, 1),
                          fontSize: FontSizeManager.subheadFootnote),
                    ),
                    Text(
                      '-Rp${pointData.pointOut}',
                      style: TextStyle(
                        color: pointData.pointOut != '0'
                            ? ColorManager.negative
                            : ColorManager.subheadFootnote,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: ColorManager.whitePrimaryBackground,
              borderRadius: BorderRadiusManager.textfieldRadius * 4,
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
                        color: ColorManager.primary,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'SALDO',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Rp${pointData.totalPoint}',
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
          ),
        ],
      ),
    );
  }

  Widget pointUIListView() {
    return RefreshIndicator(
      backgroundColor: Colors.white,
      displacement: 0,
      onRefresh: refreshData,
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: 16),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: pointController.pointDataList!.length,
        itemBuilder: (BuildContext context, int index) {
          return pointUICardView(pointController.pointDataList![index]);
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
        Widget pointViewBody;

        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading state
          pointViewBody = const LoadingContainer();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (pointController.pointError != null &&
              pointController.pointError!.isNotEmpty) {
            // Show the error state if there's an error message
            pointViewBody = Container(
              margin: PaddingMarginManager.allSuperView,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FailureContainer(
                      failureMessage:
                          'Terjadi kesalahan teknis, silahkan coba beberapa saat lagi.',
                      failureErrorCode: pointController.pointError!,
                    ),
                    const SizedBox(height: 16),
                    muatUlangUIButton()
                  ],
                ),
              ),
            );
          } else if (pointController.pointDataList != null &&
              pointController.pointDataList!.isNotEmpty) {
            // Show the success state
            pointViewBody = Container(
              margin: PaddingMarginManager.horizontallySuperView,
              child: Column(
                children: [
                  dateRangeUIPicker(),
                  const SizedBox(height: 16),
                  Expanded(
                    child: pointUIListView(),
                  )
                ],
              ),
            );
          } else {
            // Show the empty state
            pointViewBody = Container(
              margin: PaddingMarginManager.horizontallySuperView,
              child: Column(
                children: [
                  dateRangeUIPicker(),
                  const SizedBox(height: 16),
                  const Expanded(
                    child: Center(
                      child: EmptyContainer(
                        emptyMessage: 'Tidak ada data saldo point',
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        } else {
          // Show the error state
          pointViewBody = Column(
            children: [
              FailureContainer(
                failureMessage:
                    'Terjadi kesalahan teknis, silahkan coba beberapa saat lagi.',
                failureErrorCode: pointController.pointError!,
              ),
            ],
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Saldo Point'),
            actions: [klaimPointUIButton()],
          ),
          body: pointViewBody,
        );
      },
    );
  }
}
