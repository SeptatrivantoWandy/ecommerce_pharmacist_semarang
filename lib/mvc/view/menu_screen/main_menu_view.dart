import 'package:carousel_slider/carousel_slider.dart';
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
  final MainMenuController mainMenuController = MainMenuController();
  final MainMenuDialog mainMenuDialog = MainMenuDialog();

  @override
  void initState() {
    super.initState();
    mainMenuController.viewDidLoad(setState, context, mainMenuDialog);
  }

  Widget logoUIImage() {
    return Container(
      margin: PaddingMarginManager.horizontallySuperView,
      child: Image.asset(
        'assets/semesta_megah_sentosa_logo.png',
      ),
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
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ColorManager.greyPrimaryBackground,
                          borderRadius: BorderRadiusManager.textfieldRadius * 2,
                        ),
                        child: Image.asset(
                          'assets/order_pesanan_logo.png',
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
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: ColorManager.greyPrimaryBackground,
                          borderRadius: BorderRadiusManager.textfieldRadius * 2,
                        ),
                        child: Image.asset(
                          'assets/piutang_logo.png',
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
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: ColorManager.greyPrimaryBackground,
                          borderRadius: BorderRadiusManager.textfieldRadius * 2,
                        ),
                        child: Image.asset(
                          'assets/point_logo.png',
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

  List<Widget> get imageSliders => mainMenuController.imgList
      .map((item) => Container(
            margin: PaddingMarginManager.miniHorizontallySuperView,
            child: AspectRatio(
              aspectRatio: 1.0,
              child: ClipRRect(
                borderRadius: BorderRadiusManager.textfieldRadius * 4,
                child: Image.network(
                  item,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Container(
                        color: ColorManager.greyPrimaryBackground,
                        child: Center(
                          child: SizedBox(
                            height: 72,
                            width: 72,
                            child: CircularProgressIndicator(
                              strokeWidth: 6,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null, // Shows a progress indicator.
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Container(
                      padding: PaddingMarginManager.allSuperView,
                      color: ColorManager.greyPrimaryBackground,
                      child: Center(
                        child: Image.asset(
                          'assets/semesta_megah_sentosa_icon.png',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ))
      .toList();

  Widget carouselBanner() {
    return mainMenuController.isBanner
        ? Stack(
            children: [
              CarouselSlider(
                items: imageSliders,
                carouselController: mainMenuController.carouselSliderController,
                options: CarouselOptions(
                    height: 296, // Adjust height if needed
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 10),
                    enlargeCenterPage: true,
                    enlargeFactor: 0.4,
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                    onPageChanged: (index, reason) {
                      setState(() {
                        mainMenuController.current = index;
                      });
                    }),
              ),
              Positioned(
                bottom: 12,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      mainMenuController.imgList.asMap().entries.map((entry) {
                    return InkWell(
                      onTap: () {
                        mainMenuController.carouselSliderController
                            .animateToPage(entry.key,
                                duration: const Duration(milliseconds: 800),
                                curve: Curves.fastEaseInToSlowEaseOut);
                      },
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 4.0,
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: mainMenuController.current == entry.key
                                ? ColorManager.primary
                                : ColorManager.white),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          )
        : const SizedBox();
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
            child: mainMenuController.isBanner
                ? null
                : Image.asset(
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
            height: 86,
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

  Widget settingsUIButton() {
    return Container(
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              settingsUIButton(),
              logoUIImage(),
              const SizedBox(
                height: 16,
              ),
              const Center(
                child: Text(
                  'Pilih Menu',
                  style: TextStyle(
                      fontSize: FontSizeManager.title3,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              mainFeature(),
              const SizedBox(
                height: 16,
              ),
              carouselBanner(),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomMenuUIImage(),
    );
  }
}
