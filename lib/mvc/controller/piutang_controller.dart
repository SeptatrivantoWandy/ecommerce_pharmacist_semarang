import 'package:ecommerce_pharmacist_semarang/mvc/model/piutang/piutang_response.dart';
import 'package:ecommerce_pharmacist_semarang/service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PiutangController {
  final Future<SharedPreferences> futurePrefs = SharedPreferences.getInstance();
  String? userCode;
  List<PiutangData>? piutangDataList;
  String? piutangError;
  String totalSaldo = '';

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await futurePrefs;
    userCode = prefs.getString('userCode');
  }

  Future<void> viewDidLoad() async {
    // Wait for user data to be loaded first
    await loadUserData();

    // Then fetch Piutang data after user data is loaded
    if (userCode != null && userCode!.isNotEmpty) {
      await fetchPiutang();
    } else {
      print('User code not found');
    }
  }

  // Helper function to format date
  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }

  // Helper function to format balance
  String formatBalance(String balance) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    );
    double parsedBalance = double.parse(balance);
    return currencyFormat.format(parsedBalance);
  }

  Future<void> fetchPiutang() async {
    PiutangService piutangService = PiutangService();
    PiutangResponse? response = await piutangService.getPiutang(userCode!);

    // Simulate empty list
    // PiutangResponse response = PiutangResponse(
    //   status: true,
    //   message: 'Success',
    //   piutangData: [], // Empty list
    // );

    // Mocked error response
    // PiutangResponse response = PiutangResponse(
    //   status: false,
    //   message: 'Error fetching data',
    //   piutangData: [],
    // );

    // Simulate a network delay
    // await Future.delayed(const Duration(seconds: 2));

    if (response != null && response.status) {
      
      piutangError = null;
      // response.printPiutangResponse();

      // Initialize a list to store formatted PiutangData
      List<PiutangData> formattedPiutangDataList = [];

      double totalBalance = 0.0;

      // Iterate through the response data and format the dates and balances
      for (var piutang in response.piutangData) {
        // Format date from "2024-09-03" to "03/09/2024"
        String formattedInvoiceDate = formatDate(piutang.invoiceDate);
        String formattedInvoiceDueDate = formatDate(piutang.invoiceDueDate);

        // Format balance from "100000.00" to "100.000"
        String formattedBalance = formatBalance(piutang.balance);

        // Convert the formatted balance back to a double value
        double balanceValue = double.parse(piutang.balance);

        // Add the balance to the total
        totalBalance += balanceValue;

        // Create a new PiutangData with the formatted values
        PiutangData formattedPiutangData = PiutangData(
          userCode: piutang.userCode,
          invoiceNo: piutang.invoiceNo,
          invoiceDate: formattedInvoiceDate,
          invoiceDueDate: formattedInvoiceDueDate,
          balance: formattedBalance,
        );

        // Add the formatted PiutangData to the list
        formattedPiutangDataList.add(formattedPiutangData);
      }

      // Store the formatted Piutang data
      piutangDataList = formattedPiutangDataList;
      totalSaldo = formatBalance(totalBalance.toString());
    } else {
      piutangError = response?.message ?? 'Failed to fetch piutang data';
    }
  }
}
