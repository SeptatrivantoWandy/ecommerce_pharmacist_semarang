import 'package:ecommerce_pharmacist_semarang/mvc/controller/piutang_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/piutang/piutang_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/empty_container.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/failure_container.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/loading_container.dart';
import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class PiutangView extends StatefulWidget {
  const PiutangView({super.key});

  @override
  State<PiutangView> createState() => _PiutangViewState();
}

class _PiutangViewState extends State<PiutangView> {
  PiutangController piutangController = PiutangController();

  late Future<void> futureView;

  @override
  void initState() {
    super.initState();
    futureView = piutangController.viewDidLoad();
  }

  Future<void> refreshData() async {
    setState(() {
      futureView = piutangController.viewDidLoad();
    });
  }

  Widget piutangUICardView(PiutangData piutangData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusManager.textfieldRadius,
      ),
      margin: PaddingMarginManager.horizontallySuperView,
      padding: PaddingMarginManager.allMiniSuperView,
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                const Icon(
                  Symbols.calendar_clock_rounded,
                  color: ColorManager.negative,
                ),
                const SizedBox(width: 4),
                Text(
                  piutangData.invoiceDueDate,
                  style: const TextStyle(color: ColorManager.negative),
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
                      Text(
                        piutangData.invoiceDate,
                        style: const TextStyle(
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
                      Text(
                        '#${piutangData.invoiceNo}',
                        style: const TextStyle(
                          color: ColorManager.subheadFootnote,
                          fontSize: FontSizeManager.subheadFootnote,
                        ),
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
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
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
                        'Rp${piutangData.balance}',
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
    );
  }

  Widget piutangUIListView() {
    return RefreshIndicator(
      backgroundColor: Colors.white,
      displacement: 0,
      onRefresh: refreshData,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: piutangController.piutangDataList!.length,
        itemBuilder: (BuildContext context, int index) {
          return piutangUICardView(piutangController.piutangDataList![index]);
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: 16,
        ),
      ),
    );
  }

  Widget bottomNavigationUIContainer() {
    return BottomAppBar(
      color: ColorManager.backgroundPage,
      height: 62,
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'TOTAL SALDO',
                  style: TextStyle(
                      fontSize: FontSizeManager.title2,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp${piutangController.totalSaldo}',
                  style: const TextStyle(
                    fontSize: FontSizeManager.title2,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
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
      future: futureView,
      builder: (context, snapshot) {
        // Declare variables for body content and bottom navigation bar
        Widget piutangViewBody;
        Widget? bottomNavigationBar;

        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading state
          piutangViewBody = const LoadingContainer();
          bottomNavigationBar = null; // Hide bottom navigation bar
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (piutangController.piutangError != null &&
              piutangController.piutangError!.isNotEmpty) {
            // Show the error state if there's an error message
            piutangViewBody = Container(
              margin: PaddingMarginManager.allSuperView,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FailureContainer(
                      failureMessage:
                          'Terjadi kesalahan teknis, silahkan coba beberapa saat lagi.',
                      failureErrorCode: piutangController.piutangError!,
                    ),
                    const SizedBox(height: 16),
                    muatUlangUIButton()
                  ],
                ),
              ),
            );
            bottomNavigationBar = null; // Hide bottom navigation bar
          } else if (piutangController.piutangDataList != null &&
              piutangController.piutangDataList!.isNotEmpty) {
            // Show the success state
            piutangViewBody = piutangUIListView();
            bottomNavigationBar =
                bottomNavigationUIContainer(); // Show bottom navigation bar
          } else {
            // Show the empty state
            piutangViewBody = const Center(
              child: EmptyContainer(
                emptyMessage: 'Tidak ada data piutang',
              ),
            );
            bottomNavigationBar = null; // Hide bottom navigation bar
          }
        } else {
          // Show the error state
          piutangViewBody = Column(
            children: [
              FailureContainer(
                failureMessage:
                    'Terjadi kesalahan teknis, silahkan coba beberapa saat lagi.',
                failureErrorCode: piutangController.piutangError!,
              ),
            ],
          );
          bottomNavigationBar = null; // Hide bottom navigation bar
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Saldo Piutang'),
          ),
          body: piutangViewBody,
          bottomNavigationBar: bottomNavigationBar,
        );
      },
    );
  }
}
