import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/healthicons.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Container(
        margin: const EdgeInsets.all(16),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Iconify(
                Healthicons.pharmacy,
                size: 124,
                color: ColorManager.white,
              ),
              SizedBox(height: 36),
              SizedBox(
                height: 72,
                width: 72,
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
