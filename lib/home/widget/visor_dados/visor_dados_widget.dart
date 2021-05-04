import 'package:moneyspace/core/app_colors.dart';
import 'package:moneyspace/core/app_text_styles.dart';
import 'package:flutter/material.dart';

class VisorDadosWidgets extends StatefulWidget {
  VisorDadosWidgets({Key? key}) : super(key: key);
  @override
  _VisorDadosWidgetsState createState() => _VisorDadosWidgetsState();
}

class _VisorDadosWidgetsState extends State<VisorDadosWidgets> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.trending_down, size: 35, color: AppColors.darkGreen,),
          ),
          Column(
            children: [
              Text(
                "Salário",
                style: AppTextStyles.titleList
              ),
              Text(
                "01/01/1999",
                style: AppTextStyles.dataList,
              )
            ]
          ),
          Expanded(
            child: Text(
              "R\$ 1000,00",
              style: AppTextStyles.valueList,
              textAlign: TextAlign.end,
            ),
          )
        ],
      ),
    );
  }
}