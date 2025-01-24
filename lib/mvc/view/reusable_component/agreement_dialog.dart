import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class AgreementDialog extends StatelessWidget {
  const AgreementDialog(
      {super.key,
      required this.agreementTitleText,
      required this.agreementDialogText,
      required this.agreementButtonText});
  final String agreementTitleText;
  final String agreementDialogText;

  final String agreementButtonText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorManager.backgroundPage,
      title: Text(
        agreementTitleText,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: FontSizeManager.title3),
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
            agreementDialogText,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(agreementButtonText),
        )
      ],
    );
  }
}
