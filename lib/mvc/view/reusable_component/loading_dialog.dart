import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      backgroundColor: ColorManager.backgroundPage,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12),
          SizedBox(
            height: 72,
            width: 72,
            child: CircularProgressIndicator(
              strokeWidth: 6,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Loading',
          )
        ],
      ),
    );
  }
}
