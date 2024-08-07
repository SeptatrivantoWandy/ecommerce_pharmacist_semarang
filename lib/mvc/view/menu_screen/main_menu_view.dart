import 'package:ecommerce_pharmacist_semarang/mvc/controller/main_menu_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/menu_screen/main_menu_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/settings_screen/settting_view.dart';
import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

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
              borderRadius: BorderRadiusManager.textfieldRadius),
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
                      left: 12,
                      right: 16,
                      top: 4,
                      bottom: 4
                    ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: const Text(
          'PBF Apps',
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
      body: SingleChildScrollView(
        child: Column(
          children: [logoutUIButton()],
        ),
      ),
    );
  }
}
