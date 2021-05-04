import 'package:moneyspace/core/app_colors.dart';
import 'package:flutter/material.dart';

class SelectionButtonWidget extends StatefulWidget {  
  final int selectedValue;
  final String title;
  SelectionButtonWidget({
    Key? key,
    required this.selectedValue,
    required this.title,
  }) : assert([1, 2].contains(selectedValue)), super(key: key);

  final config = {
    1 : {
      "color" : AppColors.green,
    },
    2 : {
      "color" : AppColors.red,
    },
  };

  Color get color => config[selectedValue]!['color']!;

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
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: widget.selectedValue,
                  groupValue: selectedRadio,
                  activeColor: widget.color,
                  onChanged: (int? value) {
                    print("Radio : $value");
                    setSelectedRadio(value);
                  },
                )
              ],
            ),
            Text(
              widget.title,
              style: TextStyle(
                color: AppColors.white,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}