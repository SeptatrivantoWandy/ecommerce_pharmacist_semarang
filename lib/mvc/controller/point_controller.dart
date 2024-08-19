import 'package:ecommerce_pharmacist_semarang/mvc/model/point/point_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/claim_point_screen/claim_point_view.dart';
import 'package:ecommerce_pharmacist_semarang/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PointController {
  DateTime endDate = DateTime.now();
  DateTime startDate = DateTime.now().subtract(const Duration(days: 30));

  final Future<SharedPreferences> futurePrefs = SharedPreferences.getInstance();
  String? userCode;
  List<SaldoPointData>? pointDataList;
  String? pointError;

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await futurePrefs;
    userCode = prefs.getString('userCode');
  }

  Future<void> viewDidLoad() async {
    // Wait for user data to be loaded first
    await loadUserData();

    // Then fetch Piutang data after user data is loaded
    if (userCode != null && userCode!.isNotEmpty) {
      await fetchPoint();
    } else {
      print('User code not found');
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String formatStringDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }

  String formatBalance(String balance) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    );
    double parsedBalance = double.parse(balance);
    return currencyFormat.format(parsedBalance);
  }

  String toCapitalCase(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  Future<void> selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(start: startDate, end: endDate),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      startDate = picked.start;
      endDate = picked.end;
    }
  }

  Future<void> fetchPoint() async {
    PointService pointService = PointService();
    PointResponse? response = await pointService.getSaldoPoint(
        userCode!, startDate.toString(), endDate.toString());

    // Simulate empty list
    // PointResponse response = PointResponse(
    //   status: true,
    //   message: 'Success',
    //   saldoPointData: [], // Empty list
    // );

    // Mocked error response
    // PointResponse response = PointResponse(
    //   status: false,
    //   message: 'Error fetching data',
    //   saldoPointData: [],
    // );

    // Simulate a network delay
    // await Future.delayed(const Duration(seconds: 2));

    if (response != null && response.status) {
      pointError = null;
      List<SaldoPointData> formattedPointDataList = [];

      // Iterate through the response data and format the dates and balances
      for (var point in response.saldoPointData) {
        SaldoPointData formattedPointData = SaldoPointData(
          userCode: point.userCode,
          pointDate: formatStringDate(point.pointDate),
          notes: toCapitalCase(point.notes),
          pointIn: formatBalance(point.pointIn),
          pointOut: formatBalance(point.pointOut),
          totalPoint: formatBalance(
            point.totalPoint,
          ),
        );

        formattedPointDataList.add(formattedPointData);
      }

      pointDataList = formattedPointDataList;
    } else {
      pointError = response?.message ?? 'Failed to fetch piutang data';
    }
  }

  void klaimPointPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const ClaimPointView(),
      ),
    );
  }
}
