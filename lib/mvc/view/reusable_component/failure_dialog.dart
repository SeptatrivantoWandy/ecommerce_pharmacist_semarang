import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class FailureDialog extends StatelessWidget {
  const FailureDialog({super.key, required this.failureDialogText});
  final String failureDialogText;

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
