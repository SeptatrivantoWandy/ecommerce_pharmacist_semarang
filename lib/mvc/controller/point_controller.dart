import 'package:ecommerce_pharmacist_semarang/mvc/view/claim_point_screen/claim_point_view.dart';
import 'package:flutter/material.dart';

class PointController {
  void klaimPointPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const ClaimPointView(),
      ),
    );
  }
}