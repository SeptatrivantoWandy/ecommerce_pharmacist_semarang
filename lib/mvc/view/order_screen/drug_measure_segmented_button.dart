import 'package:ecommerce_pharmacist_semarang/mvc/controller/order_controller.dart';
import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class DrugMeasureSegmentedButton extends StatefulWidget {
  final String drugMeasure;
  final String drugMeasure2;
  final OrderController orderController;

  const DrugMeasureSegmentedButton({
    required this.drugMeasure,
    required this.drugMeasure2,
    required this.orderController,
    super.key,
  });

  @override
  State<DrugMeasureSegmentedButton> createState() =>
      _DrugMeasureSegmentedButtonState();
}

class _DrugMeasureSegmentedButtonState
    extends State<DrugMeasureSegmentedButton> {
  
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.orderController.drugMeasure = widget.drugMeasure;
  }

  @override
  Widget build(BuildContext context) {
    // Create a list of measures
    List<String> measures = [widget.drugMeasure];
    if (widget.drugMeasure2.isNotEmpty) {
      measures.add(widget.drugMeasure2);
    }

    return SizedBox(
      width: 124,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(measures.length, (index) {
          return Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? ColorManager.primary
                    : ColorManager
                        .greyPrimaryBackground, // Change color based on selection
                borderRadius: measures.length == 1
                    ? BorderRadiusManager.textfieldRadius
                    : index == 0
                        ? BorderRadius.only(
                            topLeft: BorderRadiusManager.dottedTextFieldRadius,
                            bottomLeft:
                                BorderRadiusManager.dottedTextFieldRadius,
                          )
                        : BorderRadius.only(
                            topRight: BorderRadiusManager.dottedTextFieldRadius,
                            bottomRight:
                                BorderRadiusManager.dottedTextFieldRadius,
                          ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: measures.length == 1
                        ? BorderRadiusManager.textfieldRadius
                        : index == 0
                            ? BorderRadius.only(
                                topLeft:
                                    BorderRadiusManager.dottedTextFieldRadius,
                                bottomLeft:
                                    BorderRadiusManager.dottedTextFieldRadius,
                              )
                            : BorderRadius.only(
                                topRight:
                                    BorderRadiusManager.dottedTextFieldRadius,
                                bottomRight:
                                    BorderRadiusManager.dottedTextFieldRadius,
                              ),
                  ),
                  onTap: () {
                    widget.orderController.drugMeasure = measures[index];
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: const BoxDecoration(
                      color:
                          Colors.transparent, // Change color based on selection
                    ),
                    child: Text(
                      measures[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selectedIndex == index
                            ? Colors.white
                            : Colors
                                .black, // Change text color based on selection
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
