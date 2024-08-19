import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class FailureContainer extends StatelessWidget {
  const FailureContainer({super.key, required this.failureMessage, required this.failureErrorCode});
  final String failureMessage;
  final String failureErrorCode;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            failureMessage,
            textAlign: TextAlign.center,
          ),
          Text(
            failureErrorCode,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ColorManager.negative
            ),
          ),
        ],
      ),
    );
  }
}
