import 'package:ecommerce_pharmacist_semarang/mvc/controller/claim_point_controller.dart';
import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class ClaimPointView extends StatefulWidget {
  const ClaimPointView({super.key});

  @override
  State<ClaimPointView> createState() => _ClaimPointViewState();
}

class _ClaimPointViewState extends State<ClaimPointView> {
  ClaimPointController claimPointController = ClaimPointController();

  Widget totalSaldoPointUIContainer() {
    return Container(
      margin: PaddingMarginManager.horizontallySuperView,
      decoration: BoxDecoration(
        color: ColorManager.greyPrimaryBackground,
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
                  'Total Saldo Poin',
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
    );
  }

  Widget jumlahKlaimUITextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorManager.backgroundPage,
            borderRadius: BorderRadiusManager.textfieldRadius,
          ),
          padding: PaddingMarginManager.onlyRight6,
          height: SizeManager.textFieldContainerHeight,
          margin: PaddingMarginManager.miniHorizontallySuperView,
          child: TextField(
            keyboardType: TextInputType.number,
            style: const TextStyle(
                fontSize: FontSizeManager.headlineBody,
                color: ColorManager.primary,
                fontWeight: FontWeight.bold),
            controller: claimPointController.jumlahKlaimUIController,
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
              prefixStyle: TextStyle(color: ColorManager.blackText),
              prefixText: 'Rp',
              prefixIcon: Icon(
                Icons.payments_outlined,
                size: 26,
                color: ColorManager.primary,
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 36,
                minHeight: 34,
              ),
            ),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          margin: const EdgeInsets.only(right: 8, left: 8),
          child: Text(
            claimPointController.jumlahKlaimError,
            style: const TextStyle(
              fontSize: FontSizeManager.subheadFootnote,
              color: ColorManager.negative,
            ),
          ),
        )
      ],
    );
  }

  Widget penukaranSaldoUIContainer() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadiusManager.textfieldRadius,
          color: ColorManager.white),
      margin: PaddingMarginManager.horizontallySuperView,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 248, 230, 1),
              borderRadius: BorderRadiusManager.textfieldRadius,
            ),
            child: const IntrinsicHeight(
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 18,
                    color: Color.fromRGBO(247, 180, 25, 1),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Jumlah penukaran harus lebih kecil dari saldo',
                      style: TextStyle(
                          color: Color.fromRGBO(247, 180, 25, 1),
                          fontSize: FontSizeManager.subheadFootnote),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            margin: PaddingMarginManager.miniHorizontallySuperView,
            child: const Text(
              'Jumlah Klaim',
              style: TextStyle(
                  fontSize: FontSizeManager.title3,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: const Text(
              'Masukkan jumlah klaim poin dalam rupiah',
              style: TextStyle(
                  fontSize: FontSizeManager.subheadFootnote,
                  color: ColorManager.subheadFootnote),
            ),
          ),
          const SizedBox(height: 8),
          jumlahKlaimUITextField(),
          const SizedBox(height: 8),
          SizedBox(
            height: 42,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 18,
                  left: 0,
                  right: 0,
                  child: separatorWidget(0),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusManager.textfieldRadius * 4,
                      color: ColorManager.primary,
                    ),
                    child: const Icon(
                      Icons.import_export_rounded,
                      color: ColorManager.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: PaddingMarginManager.miniHorizontallySuperView,
            child: const Text(
              'Sisa Saldo',
              style: TextStyle(
                  fontSize: FontSizeManager.title3,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: const Text(
              'Jumlah sisa saldo poin setelah penukaran',
              style: TextStyle(
                  fontSize: FontSizeManager.subheadFootnote,
                  color: ColorManager.subheadFootnote),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            margin: PaddingMarginManager.miniHorizontallySuperView,
            child: const Text(
              'Rp900.000',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorManager.primary,
                  fontSize: FontSizeManager.title3),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget namaBankUITextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: PaddingMarginManager.labelTextField,
          child: const Text(
            'Nama Bank',
            style: TextStyle(
                fontSize: FontSizeManager.subheadFootnote,
                color: ColorManager.subheadFootnote),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadiusManager.textfieldRadius,
          ),
          padding: PaddingMarginManager.onlyRight6,
          height: SizeManager.textFieldContainerHeight,
          margin: PaddingMarginManager.textField,
          child: TextField(
            keyboardType: TextInputType.name,
            style: const TextStyle(fontSize: FontSizeManager.headlineBody),
            controller: claimPointController.namaBankUIController,
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
              hintText: "Masukkan nama bank",
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                size: 26,
                color: ColorManager.primary,
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 36,
                minHeight: 34,
              ),
            ),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          margin: PaddingMarginManager.labelTextField,
          child: Text(
            claimPointController.namaBankError,
            style: const TextStyle(
              fontSize: FontSizeManager.subheadFootnote,
              color: ColorManager.negative,
            ),
          ),
        )
      ],
    );
  }

  Widget noRekeningUITextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: PaddingMarginManager.labelTextField,
          child: const Text(
            'Nomor Rekening',
            style: TextStyle(
                fontSize: FontSizeManager.subheadFootnote,
                color: ColorManager.subheadFootnote),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadiusManager.textfieldRadius,
          ),
          padding: PaddingMarginManager.onlyRight6,
          height: SizeManager.textFieldContainerHeight,
          margin: PaddingMarginManager.textField,
          child: TextField(
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: FontSizeManager.headlineBody),
            controller: claimPointController.nomorRekeningUIController,
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
              hintText: "Masukkan nomor rekening",
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                size: 26,
                color: ColorManager.primary,
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 36,
                minHeight: 34,
              ),
            ),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          margin: PaddingMarginManager.labelTextField,
          child: Text(
            claimPointController.nomorRekeningError,
            style: const TextStyle(
              fontSize: FontSizeManager.subheadFootnote,
              color: ColorManager.negative,
            ),
          ),
        )
      ],
    );
  }

  Widget atasNamaUITextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: PaddingMarginManager.labelTextField,
          child: const Text(
            'Atas Nama',
            style: TextStyle(
                fontSize: FontSizeManager.subheadFootnote,
                color: ColorManager.subheadFootnote),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadiusManager.textfieldRadius,
          ),
          padding: PaddingMarginManager.onlyRight6,
          height: SizeManager.textFieldContainerHeight,
          margin: PaddingMarginManager.textField,
          child: TextField(
            keyboardType: TextInputType.name,
            style: const TextStyle(fontSize: FontSizeManager.headlineBody),
            controller: claimPointController.atasNamaUIController,
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
              hintText: "Masukkan atas nama",
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                size: 26,
                color: ColorManager.primary,
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 36,
                minHeight: 34,
              ),
            ),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          margin: PaddingMarginManager.labelTextField,
          child: Text(
            claimPointController.atasNamaError,
            style: const TextStyle(
              fontSize: FontSizeManager.subheadFootnote,
              color: ColorManager.negative,
            ),
          ),
        )
      ],
    );
  }

  Widget konfirmasiKlaimPoinUIButton() {
    return SizedBox(
      height: 34,
      width: double.infinity,
      child: FilledButton(
        onPressed: () {
          setState(() {
            final bool isSatisfied =
                claimPointController.konfirmasiKlaimPointButtonPressed();
            if (isSatisfied) {
              // registerDialog.registerAlertDialog(context, registerController);
            } else {
              // registerDialog.isNotSatisfied(context);
            }
          });
        },
        style: FilledButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: const Text(
          'Konfirmasi Klaim Point',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget batalUIButton() {
    return SizedBox(
      height: 34,
      width: double.infinity,
      child: FilledButton(
        onPressed: () {
          // registerDialog.cancelAlertDialog(context);
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: ColorManager.backgroundPage,
          foregroundColor: ColorManager.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: const BorderSide(color: ColorManager.negative)),
        ),
        child: const Text(
          'Batal',
          style: TextStyle(
            color: ColorManager.negative,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget claimPointViewBody = SingleChildScrollView(
      child: Column(
        children: [
          totalSaldoPointUIContainer(),
          const SizedBox(height: 16),
          penukaranSaldoUIContainer(),
          const SizedBox(height: 16),
          namaBankUITextField(),
          const SizedBox(height: 16),
          noRekeningUITextField(),
          const SizedBox(height: 16),
          atasNamaUITextField(),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Klaim Point'),
      ),
      body: claimPointViewBody,
      bottomNavigationBar: BottomAppBar(
        height: 124,
        child: Column(
          children: [
            konfirmasiKlaimPoinUIButton(),
            const SizedBox(height: 16),
            batalUIButton(),
            const SizedBox(height: 16)
          ],
        ),
      ),
    );
  }
}
