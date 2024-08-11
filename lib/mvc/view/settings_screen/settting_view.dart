import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetttingView extends StatefulWidget {
  const SetttingView({super.key});

  @override
  State<SetttingView> createState() => _SetttingViewState();
}

class _SetttingViewState extends State<SetttingView> {
  final Future<SharedPreferences> futurePrefs = SharedPreferences.getInstance();
  String? username;
  String? userId;
  String? userCode;

  String? appName;
  String? packageName;
  String? version;
  String? buildNumber;

  void loadPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }

  void loadUserData() async {
    final SharedPreferences prefs = await futurePrefs;
    setState(() {
      username = prefs.getString('username');
      userId = prefs.getString('userId');
      userCode = prefs.getString('userCode');
    });
  }

  @override
  Widget build(BuildContext context) {
    loadUserData();
    loadPackageInfo();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                username ?? '-',
                style: const TextStyle(fontSize: FontSizeManager.headlineBody),
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
                userId ?? 'No user',
                style: const TextStyle(fontSize: FontSizeManager.headlineBody),
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
                userCode ?? 'No user',
                style: const TextStyle(fontSize: FontSizeManager.headlineBody),
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
                '$appName',
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
                '$packageName',
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
                '$version',
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
                '$buildNumber',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
