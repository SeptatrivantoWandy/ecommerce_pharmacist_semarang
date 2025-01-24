import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/banner/banner_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/customer_screen/customer_view.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/login_screen/login_view.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/menu_screen/main_menu_dialog.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/order_screen/order_view.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/piutang_screen/piutang_view.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/point_screen/point_view.dart';
import 'package:ecommerce_pharmacist_semarang/service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenuController {
  final Future<SharedPreferences> futurePrefs = SharedPreferences.getInstance();
  final List<String> imgList = [];

  String? username;
  String? name;
  String? userId;
  String? userCode;
  String? isSales;

  bool isBanner = false;
  bool isLogout = false;

  int current = 0;
  final CarouselSliderController carouselSliderController =
      CarouselSliderController();

  Future<void> viewDidLoad(
    StateSetter setState,
    BuildContext context,
    MainMenuDialog mainMenuDialog,
  ) async {
    isLogout = await shouldLogout();
    if (isLogout) {
      if (context.mounted) {
        mainMenuDialog.logoutAlertDialog(context, this, mainMenuDialog); 
      }
    }

    await fetchBanner();
    await loadUserData();
    setState(() {
      isBanner = imgList.isNotEmpty;
    });
  }

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await futurePrefs;
    username = prefs.getString('username');
    name = prefs.getString('name');
    userId = prefs.getString('userId');
    userCode = prefs.getString('userCode');
    isSales = prefs.getString('isSales');
  }

  Future<bool> shouldLogout() async {
    final prefs = await SharedPreferences.getInstance();
    final lastSessionDate = prefs.getString('lastSessionDate');

    if (lastSessionDate != null) {
      final lastDate = DateTime.parse(lastSessionDate);
      final now = DateTime.now();

      // Check if the stored date is not today
      if (lastDate.year != now.year ||
          lastDate.month != now.month ||
          lastDate.day != now.day) {
        return true; // It's a different day
      }
    } else {
      return true; // No stored date, log out
    }
    return false; // Same day, no need to log out
  }

  Future<void> logoutAccount(BuildContext context, MainMenuDialog mainMenuDialog) async {
    final SharedPreferences prefs = await futurePrefs;
    bool success;
    if (context.mounted) {
      mainMenuDialog.loadingAlertDialog(context);
    }
    
    success = await prefs.clear();
    if (success) {
      if (context.mounted) {
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => const LoginView(),
          ),
        );
      }
    }
  }

  Future<void> fetchBanner() async {
    BannerService bannerService = BannerService();
    BannerResponse? response = await bannerService.getBanners();

    if (response != null && response.status) {
      // Iterate through the response data and format the dates and balances
      // response.printBannerResponse();

      for (var imageData in response.imageData) {
        imgList.add(imageData.imageUrl!);
      }
    }
  }

  void orderPesananFeaturePressed(BuildContext context) {
    if (isSales == 'X') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const CustomerView(),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => OrderView(
            customerName: name ?? 'Unknown',
          ),
        ),
      );
    }
  }

  void piutangFeaturePressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const PiutangView(),
      ),
    );
  }

  void pointFeaturePressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const PointView(),
      ),
    );
  }
}
