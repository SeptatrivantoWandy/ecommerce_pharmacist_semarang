import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class EmptyContainer extends StatelessWidget {
  const EmptyContainer({super.key, required this.emptyMessage});
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 124,
              color: ColorManager.primary,
            ),
            Text(
              emptyMessage,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
