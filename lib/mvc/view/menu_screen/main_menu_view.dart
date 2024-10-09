import 'package:ecommerce_pharmacist_semarang/mvc/controller/main_menu_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/menu_screen/main_menu_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/settings_screen/settting_view.dart';
import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';

class MainMenuView extends StatefulWidget {
  const MainMenuView({super.key});

  @override
  State<MainMenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MainMenuView> {
  final MainMenuDialog menuDialog = MainMenuDialog();
  final MainMenuController mainMenuController = MainMenuController();

  Widget logoutUIButton() {
    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: BorderRadiusManager.dottedTextFieldRadius * 4,
                bottomRight: BorderRadiusManager.dottedTextFieldRadius * 4,
              ),
            ),
            padding: const EdgeInsets.only(bottom: 64)),
        Container(
          margin: const EdgeInsets.only(top: 16, right: 16, left: 16),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadiusManager.textfieldRadius,
          ),
          child: Column(
            children: [
              Container(
                margin: PaddingMarginManager.allSuperView,
                child: const Text(
                  'Silahkan pilih menu yang tersedia pada aplikasi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              noMarginSeparatorWidget(),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadiusManager.textfieldRadius,
                  ),
                  onTap: () {
                    menuDialog.logoutAlertDialog(context, mainMenuController);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 12, right: 16, top: 4, bottom: 4),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.power_settings_new_rounded,
                          color: Colors.red,
                          size: 26,
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Ingin keluar dari akun aplikasi (logout)?',
                            style: TextStyle(
                                fontSize: FontSizeManager.subheadFootnote),
                          ),
                        ),
                        Text(
                          'Keluar',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizeManager.subheadFootnote),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget mainFeature() {
    return Container(
      margin: PaddingMarginManager.horizontallySuperView,
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadiusManager.textfieldRadius * 2,
                ),
                onTap: () {
                  mainMenuController.orderPesananFeaturePressed(context);
                },
                child: Container(
                  width: 76,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadiusManager.textfieldRadius * 2,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: ColorManager.greyPrimaryBackground,
                          borderRadius: BorderRadiusManager.textfieldRadius * 2,
                        ),
                        child: const Icon(
                          Icons.article_outlined,
                          size: 48,
                          color: Color.fromRGBO(49, 98, 191, 1),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Order Pesanan',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadiusManager.textfieldRadius * 2,
                ),
                onTap: () {
                  mainMenuController.piutangFeaturePressed(context);
                },
                child: SizedBox(
                  width: 76,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 223, 217),
                          borderRadius: BorderRadiusManager.textfieldRadius * 2,
                        ),
                        child: const Icon(
                          Icons.payments_outlined,
                          size: 48,
                          color: Color.fromRGBO(255, 14, 14, 1),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Piutang',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadiusManager.textfieldRadius * 2,
                ),
                onTap: () {
                  mainMenuController.pointFeaturePressed(context);
                },
                child: SizedBox(
                  width: 76,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(19),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 234, 192),
                          borderRadius: BorderRadiusManager.textfieldRadius * 2,
                        ),
                        child: const Iconify(
                          Fa6Solid.coins,
                          size: 38,
                          color: Color.fromRGBO(255, 179, 0, 1),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Point',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomMenuUIImage() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -224,
          left: 0,
          right: 0,
          child: Center(
            child: Image.asset(
              'assets/pana.png',
              height: 234,
              width: 234,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: BorderRadiusManager.dottedTextFieldRadius * 8,
            topRight: BorderRadiusManager.dottedTextFieldRadius * 8,
          ),
          child: const BottomAppBar(
            color: ColorManager.primary,
            height: 124,
            child: Center(
              child: Text(
                '''"Health is not just about what you're eating. It's also about what you're thinking and saying."''',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: const Text(
          'SMS Apps',
          style: TextStyle(
            color: ColorManager.white,
            fontSize: FontSizeManager.title1,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 2),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const SetttingView(),
                  ),
                );
              },
              icon: const Icon(
                Icons.settings_outlined,
                color: ColorManager.white,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          logoutUIButton(),
          const SizedBox(height: 64),
          mainFeature(),
        ],
      ),
      bottomNavigationBar: bottomMenuUIImage(),
    );
  }
}
