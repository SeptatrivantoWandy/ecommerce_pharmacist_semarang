import 'package:ecommerce_pharmacist_semarang/mvc/model/history/history_response.dart';
import 'package:ecommerce_pharmacist_semarang/service.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryController {
  final Future<SharedPreferences> futurePrefs = SharedPreferences.getInstance();
  String userCode = '';
  String customerCode = '';
  List<HistoryData>? historyDataList;
  String? historyError;

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await futurePrefs;
    userCode = prefs.getString('userCode') ?? '';
    customerCode = prefs.getString('customerCode') ?? '';

    if (customerCode.isEmpty) {
      customerCode = userCode;
    }
  }

  Future<void> viewDidLoad() async {
    // Wait for user data to be loaded first
    await loadUserData();

    // Then fetch History data after user data is loaded
    if (userCode.isNotEmpty) {
      await fetchHistory();
    } else {
      if (kDebugMode) {
        print('User code not found');
      }
    }
  }

  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }

  String formatDiscountString(String numberStr) {
    // Parse the string to a double
    double number = double.parse(numberStr);

    // Check if the number is effectively an integer
    if (number == number.toInt()) {
      return number.toInt().toString(); // Convert to integer and then to string
    } else {
      return number
          .toString(); // Use the standard string representation for doubles
    }
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

  Future<void> fetchHistory() async {
    // Initialize the HistoryService
    HistoryService historyService = HistoryService();

    // Call the service to fetch history history data
    HistoryResponse? response = await historyService.getHistoryOrder(userCode, customerCode);

    // Simulate empty list
    // HistoryResponse response = HistoryResponse(
    //   status: true,
    //   message: 'Success',
    //   orderHistoryData: [], // Empty list
    // );

    // Mocked error response
    // HistoryResponse response = HistoryResponse(
    //   status: false,
    //   message: 'Error fetching data',
    //   orderHistoryData: [],
    // );

    // Simulate a network delay (Optional)
    // await Future.delayed(const Duration(seconds: 2));

    // Check if the response is successful
    if (response != null && response.status) {
      historyError = null;
      // response.printHistoryResponse();

      // Initialize a list to store formatted OrderHistoryData
      List<HistoryData> formattedHistoryDataList = [];

      // Iterate through the response data and format the values
      for (var history in response.orderHistoryData) {
        // Format the history total using the formatBalance function
        String formattedOrderTotal = formatBalance(history.orderTotal);

        // Initialize a list to store formatted DrugData
        List<HistoryDrugData> formattedDrugDataList = [];

        // Iterate through each drug in the history and format its values
        for (var drug in history.drugData) {
          String formattedDrugPrice = formatBalance(drug.drugPrice);
          String formattedDrugPriceTotal = formatBalance(drug.drugPriceTotal);

          // Create a new DrugData with the formatted values
          HistoryDrugData formattedDrugData = HistoryDrugData(
            drugName: drug.drugName,
            drugMeasure: drug.drugMeasure,
            orderQty: drug.orderQty,
            bonus: drug.bonus,
            drugPrice: formattedDrugPrice,
            discount: drug.discount,
            drugPriceTotal: formattedDrugPriceTotal,
          );

          // Add the formatted DrugData to the list
          formattedDrugDataList.add(formattedDrugData);
        }

        // Create a new OrderHistoryData with the formatted values
        HistoryData formattedHistoryData = HistoryData(
          orderNo: history.orderNo,
          orderDate: formatDate(history.orderDate),
          orderStatus: history.orderStatus,
          orderTotal:
              formattedOrderTotal, // Convert formatted total back to int
          drugData: formattedDrugDataList,
        );

        // Add the formatted OrderHistoryData to the list
        formattedHistoryDataList.add(formattedHistoryData);
      }

      // Store the formatted OrderHistory data
      historyDataList = formattedHistoryDataList;
    } else {
      historyError =
          response?.message ?? 'Failed to fetch history data';
    }
  }
}
