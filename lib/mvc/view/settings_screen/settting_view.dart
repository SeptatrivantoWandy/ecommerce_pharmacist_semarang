import 'package:ecommerce_pharmacist_semarang/mvc/controller/settings_controller.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/reusable_component/loading_container.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/settings_screen/settings_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class SetttingView extends StatefulWidget {
  const SetttingView({super.key});

  @override
  State<SetttingView> createState() => _SetttingViewState();
}

class _SetttingViewState extends State<SetttingView> {
  SettingsController settingsController = SettingsController();
  SettingsDialog settingsDialog = SettingsDialog();


  late Future<void> futureView;

  @override
  void initState() {
    super.initState();
    futureView = settingsController.viewDidLoad();
  }

  Widget logoutUIButton() {
    return SizedBox(
      height: 34,
      width: double.infinity,
      child: FilledButton(
        onPressed: () {
          settingsDialog.logoutAlertDialog(context, settingsController);
        },
        style: FilledButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: const Text(
          'Logout Akun',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget changePasswordUIButton() {
    return SizedBox(
      height: 34,
      width: double.infinity,
      child: FilledButton(
        onPressed: () {
          settingsController.changePasswordUIButtonPressed(context);
        },
        style: FilledButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: const Text(
          'Ganti Password',
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
          Widget settingsViewBody = const LoadingContainer();

          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading state
            settingsViewBody = const LoadingContainer();
          } else if (snapshot.connectionState == ConnectionState.done) {
            settingsViewBody = SingleChildScrollView(
              child: Container(
                margin: PaddingMarginManager.horizontallySuperView,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nama',
                      style: TextStyle(
                        fontSize: FontSizeManager.subheadFootnote,
                        color: ColorManager.subheadFootnote,
                      ),
                    ),
                    Text(
                      settingsController.name ?? '-',
                      style: const TextStyle(
                          fontSize: FontSizeManager.headlineBody),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'User Name',
                      style: TextStyle(
                        fontSize: FontSizeManager.subheadFootnote,
                        color: ColorManager.subheadFootnote,
                      ),
                    ),
                    Text(
                      settingsController.username ?? '-',
                      style: const TextStyle(
                          fontSize: FontSizeManager.headlineBody),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'User ID',
                      style: TextStyle(
                        fontSize: FontSizeManager.subheadFootnote,
                        color: ColorManager.subheadFootnote,
                      ),
                    ),
                    Text(
                      settingsController.userId ?? 'No user',
                      style: const TextStyle(
                          fontSize: FontSizeManager.headlineBody),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'User Code',
                      style: TextStyle(
                        fontSize: FontSizeManager.subheadFootnote,
                        color: ColorManager.subheadFootnote,
                      ),
                    ),
                    Text(
                      settingsController.userCode ?? 'No user',
                      style: const TextStyle(
                          fontSize: FontSizeManager.headlineBody),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Is Sales',
                      style: TextStyle(
                        fontSize: FontSizeManager.subheadFootnote,
                        color: ColorManager.subheadFootnote,
                      ),
                    ),
                    Text(
                      settingsController.isSales != null &&
                              settingsController.isSales!.isNotEmpty
                          ? 'True'
                          : 'False',
                      style: const TextStyle(
                          fontSize: FontSizeManager.headlineBody),
                    ),
                    const SizedBox(height: 48),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'App Info',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: FontSizeManager.title3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'App Name',
                      style: TextStyle(
                        fontSize: FontSizeManager.subheadFootnote,
                        color: ColorManager.subheadFootnote,
                      ),
                    ),
                    Text(
                      settingsController.appName ?? '-',
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Package Name',
                      style: TextStyle(
                        fontSize: FontSizeManager.subheadFootnote,
                        color: ColorManager.subheadFootnote,
                      ),
                    ),
                    Text(
                      settingsController.packageName ?? '-',
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Version',
                      style: TextStyle(
                        fontSize: FontSizeManager.subheadFootnote,
                        color: ColorManager.subheadFootnote,
                      ),
                    ),
                    Text(
                      settingsController.version ?? '-',
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Build Number',
                      style: TextStyle(
                        fontSize: FontSizeManager.subheadFootnote,
                        color: ColorManager.subheadFootnote,
                      ),
                    ),
                    Text(
                      settingsController.buildNumber ?? '-',
                    ),
                  ],
                ),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Settings',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: SafeArea(
              child: settingsViewBody,
            ),
            bottomNavigationBar: BottomAppBar(
              color: ColorManager.backgroundPage,
              height: BottomAppBarManager.regular + 52,
              child: Column(
                children: [
                  changePasswordUIButton(),
                  const SizedBox(height: 16),
                  logoutUIButton(),
                ],
              ),
            ),
          );
        });
  }
}
