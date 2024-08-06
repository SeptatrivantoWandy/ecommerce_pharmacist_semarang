import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog(
      {super.key,
      required this.confirmDialogTitle,
      required this.confirmDialogText});
  final String confirmDialogTitle;
  final String confirmDialogText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorManager.backgroundPage,
      title: Text(
        confirmDialogTitle,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizeManager.title3),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: ColorManager.primary,
            size: 124,
          ),
          const SizedBox(height: 6),
          Text(
            confirmDialogText,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text(
            'Tidak',
            style: TextStyle(
              color: ColorManager.negative,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text(
            'Ya',
          ),
        )
      ],
    );
  }
}
