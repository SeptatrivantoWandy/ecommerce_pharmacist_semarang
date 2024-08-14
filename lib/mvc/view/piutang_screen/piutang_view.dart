import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class PiutangView extends StatelessWidget {
  const PiutangView({super.key});

  Widget piutangUICardView() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusManager.textfieldRadius,
      ),
      margin: PaddingMarginManager.horizontallySuperView,
      padding: PaddingMarginManager.allMiniSuperView,
      child: Column(
        children: [
          const IntrinsicHeight(
            child: Row(
              children: [
                Icon(
                  Symbols.calendar_clock_rounded,
                  color: ColorManager.negative,
                ),
                SizedBox(width: 4),
                Text(
                  '06/08/2024',
                  style: TextStyle(color: ColorManager.negative),
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      const Text(
                        'Tanggal Nota',
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
                        '03/08/2024',
                        style: TextStyle(
                            color: ColorManager.subheadFootnote,
                            fontSize: FontSizeManager.subheadFootnote),
                      ),
                    ],
                  ),
                ),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      const Text(
                        'Nomor Nota',
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
          )
        ],
      ),
    );
  }

  Widget piutangUIListView() {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return piutangUICardView();
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 16,
      ),
    );
  }

  Widget bottomNavigationUIContainer() {
    return const BottomAppBar(
      color: ColorManager.backgroundPage,
      height: 60,
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TOTAL SALDO',
                  style: TextStyle(
                      fontSize: FontSizeManager.title2,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp600.000',
                  style: TextStyle(
                    fontSize: FontSizeManager.title2,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.primary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget piutangViewBody = piutangUIListView();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saldo Piutang'),
      ),
      body: piutangViewBody,
      bottomNavigationBar: bottomNavigationUIContainer(),
    );
  }
}
