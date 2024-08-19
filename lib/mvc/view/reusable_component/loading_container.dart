import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 72,
        width: 72,
        child: CircularProgressIndicator(
          strokeWidth: 6,
          color: ColorManager.primary,
        ),
      ),
    );
  }
}
