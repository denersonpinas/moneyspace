import 'package:moneyspace/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:moneyspace/core/app_text_styles.dart';

class SelectionButtonWidget extends StatefulWidget {

  @override
  _SelectionButtonWidgetState createState() => _SelectionButtonWidgetState();
}

class _SelectionButtonWidgetState extends State<SelectionButtonWidget> {
  //
  int? selectedRadio;

  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int? val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
        Expanded(
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: selectedRadio,
                        activeColor: AppColors.green,
                        onChanged: (int? value) {
                          print("Radio : $value");
                          setSelectedRadio(value);
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Receita",
                        style: AppTextStyles.heading15,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Text(
                    "OU",
                    style: AppTextStyles.heading40                                        
                  ),
                  Column(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: selectedRadio,
                        activeColor: AppColors.red,
                        onChanged: (int? value) {
                          print("Radio : $value");
                          setSelectedRadio(value);
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                       "Despesa",
                        style: AppTextStyles.heading15,
                        textAlign: TextAlign.center,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}