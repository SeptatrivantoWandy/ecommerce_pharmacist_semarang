import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class CancelBackDialog extends StatelessWidget {
  const CancelBackDialog(
      {super.key,
      required this.cancelDialogTitle,
      required this.cancelDialogText});
  final String cancelDialogTitle;
  final String cancelDialogText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorManager.backgroundPage,
      title: Text(
        cancelDialogTitle,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: FontSizeManager.title3,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 124,
          ),
          const SizedBox(height: 6),
          Text(
            cancelDialogText,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
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
            Navigator.pop(context);
            Navigator.pop(context, false);
          },
          child: Text(
            'Ya',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
