import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog(
      {super.key, required this.successDialogText, required this.isPopAgain});
  final String successDialogText;
  final bool isPopAgain;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorManager.backgroundPage,
      title: const Text(
        'Sukses',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: FontSizeManager.title3),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            color: ColorManager.primary,
            size: 124,
          ),
          const SizedBox(height: 6),
          Text(
            successDialogText,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (isPopAgain) {
              Navigator.pop(context, true);
            }
          },
          child: const Text('OK'),
        )
      ],
    );
  }
}
