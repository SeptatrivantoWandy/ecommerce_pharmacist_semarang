import 'package:ecommerce_pharmacist_semarang/mvc/model/customer/customer_response.dart';
import 'package:ecommerce_pharmacist_semarang/mvc/view/order_screen/order_view.dart';
import 'package:ecommerce_pharmacist_semarang/service.dart';
import 'package:flutter/material.dart';

class CustomerController {
  String customerError = '';
  List<CustomerData>? customerDataList;

  bool isNotEmptySearch = false;
  TextEditingController searchCustomerUIController = TextEditingController();
  List<CustomerData>? searchDataList;

  Future<void> viewDidLoad() async {
    await fetchCustomer();
  }

  void searchDrug(String query) {
    // If the search query is empty, show all data
    if (query.isEmpty) {
      searchDataList = customerDataList;
      return;
    }

    // Filter allDrugDataList based on the query
    List<CustomerData> filteredList = customerDataList!.where((customerData) {
      // Assuming DrugData has a name property
      return customerData.customerName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    searchDataList = filteredList;
  }

  void cancelSearchPressed() {
    searchCustomerUIController.clear();
    isNotEmptySearch = false;
    searchDataList = customerDataList;
  }

  Future<void> fetchCustomer() async {
    CustomerService customerService = CustomerService();
    CustomerResponse? response = await customerService.getCustomers();

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
      customerError = '';
      customerDataList = response.customerData;

      if (searchCustomerUIController.text.isNotEmpty) {
        searchDrug(searchCustomerUIController.text);
      } else {
        searchDataList = customerDataList;
      }

    } else {
      customerError = response?.message ?? 'Failed to fetch customer data';
    }
  }

  void customerUIListItemPressed(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => OrderView(customerName: searchDataList?[index].customerName ?? 'Unknown'),
      ),
    );
  }
}
