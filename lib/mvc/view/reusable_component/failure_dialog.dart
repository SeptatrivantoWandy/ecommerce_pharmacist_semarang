import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class FailureDialog extends StatelessWidget {
  const FailureDialog({super.key, required this.failureDialogText, required this.failureErrorCode});
  final String failureDialogText;
  final String failureErrorCode;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorManager.backgroundPage,
      title: const Text(
        'Gagal',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: FontSizeManager.title3),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.cancel_outlined,
            color: ColorManager.negative,
            size: 124,
          ),
          const SizedBox(height: 6),
          Text(
            failureDialogText,
          ),
          Text(
            failureErrorCode,
            style: const TextStyle(
              color: ColorManager.negative
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        )
      ],
    );
  }
}
