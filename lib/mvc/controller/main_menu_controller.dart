import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/model/banner/banner_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/order_screen/order_view.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/piutang_screen/piutang_view.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/point_screen/point_view.dart';
import 'package:ecommerce_pharmacist_semarang/service.dart';
import 'package:flutter/material.dart';

class MainMenuController {
  final List<String> imgList1 = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  final List<String> imgList = [];

  bool isBanner = false;
  int current = 0;
  final CarouselSliderController carouselSliderController =
      CarouselSliderController();

  Future<void> viewDidLoad(StateSetter setState) async {
    await fetchBanner();
    setState(() {
      isBanner = imgList.isNotEmpty;
    });
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
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const OrderView(),
      ),
    );
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
