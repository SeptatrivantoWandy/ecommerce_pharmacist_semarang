import 'package:ecommerce_pharmacist_semarang/mvc/controller/point_controller.dart';
import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class PointView extends StatefulWidget {
  const PointView({super.key});

  @override
  State<PointView> createState() => _PointViewState();
}

class _PointViewState extends State<PointView> {
  PointController pointController = PointController();

  Widget klaimPointUIButton() {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      height: 34,
      width: 84,
      child: FilledButton(
        onPressed: () {
          pointController.klaimPointPressed(context);
        },
        style: FilledButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: const Text(
          'Klaim Point',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: FontSizeManager.subheadFootnote),
        ),
      ),
    );
  }

  dateRangeUILabel() {
    return const IntrinsicHeight(
      child: Row(
        children: [
          IntrinsicHeight(
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
          SizedBox(width: 16),
          Text('s/d'),
          SizedBox(width: 16),
          IntrinsicHeight(
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
        ],
      ),
    );
  }

  Widget pointUICardView() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusManager.textfieldRadius,
      ),
      padding: PaddingMarginManager.allMiniSuperView,
      child: Column(
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
          const Text(
            'Point Masuk',
            style: TextStyle(color: ColorManager.subheadFootnote),
          ),
          const SizedBox(height: 8),
          separatorWidget(0),
          const SizedBox(height: 8),
          const IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Masuk',
                      style: TextStyle(
                          color: Color.fromRGBO(22, 133, 129, 1),
                          fontSize: FontSizeManager.subheadFootnote),
                    ),
                    Text(
                      'Rp10.000',
                      style: TextStyle(color: ColorManager.subheadFootnote),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Keluar',
                      style: TextStyle(
                          color: Color.fromRGBO(22, 133, 129, 1),
                          fontSize: FontSizeManager.subheadFootnote),
                    ),
                    Text(
                      'Rp0',
                      style: TextStyle(color: ColorManager.subheadFootnote),
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
            child: const IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.payments_outlined,
                        size: 20,
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
                        'Rp2.000.000',
                        style: TextStyle(
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
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return pointUICardView();
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget pointViewBody = Container(
      margin: PaddingMarginManager.horizontallySuperView,
      child: Column(
        children: [
          dateRangeUILabel(),
          const SizedBox(height: 16),
          Expanded(
            child: pointUIListView(),
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saldo Point'),
        actions: [klaimPointUIButton()],
      ),
      body: pointViewBody,
    );
  }
}
