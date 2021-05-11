import 'package:moneyspace/core/app_colors.dart';
import 'package:moneyspace/core/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:moneyspace/shared/widgets/date/date_widget.dart';

class AppBarWidget extends PreferredSize {
  
  AppBarWidget({Key? key}) : super(
    preferredSize: Size.fromHeight(230),
    child: Container(
      height: 230,
      child: Stack (
        children: [
          Container(
            height: 121,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            width: double.maxFinite,
            decoration: BoxDecoration(color: AppColors.darkGreen),
            child: SafeArea(
              child: Row(
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.menu,
                          color: AppColors.black,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 2),
                    child: Column(
                      children: [
                        DateWidget()
                      ]
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12, top: 70),
            child: Container(
              width: 350,
              height: 125,
              decoration: BoxDecoration(
                color: AppColors.greyBlack,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "SALDO",
                      style: AppTextStyles.titleSaldo
                    ),
                    Text(
                      "R\$ 40,00",
                      style: AppTextStyles.valueSaldo,
                    )
                  ]
                ),
              ),
            ),
          )
        ],
      ),
    )
  );
  
}