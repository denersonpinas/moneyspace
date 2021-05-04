import 'package:moneyspace/core/core.dart';
import 'package:moneyspace/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:moneyspace/selection/widgets/selection_button/selection_button_widget.dart';

class SelectionPage extends StatefulWidget {
  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        title: Text("Adicionar"),
        centerTitle: true,
      ),
      backgroundColor: AppColors.darkGreyBlack,
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34),
              child: Row(     
                mainAxisAlignment: MainAxisAlignment.spaceBetween,          
                children: [
                  SelectionButtonWidget(selectedValue: 1, title: 'Receita',),
                  Text(
                    "OU",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white
                    ),
                  ),
                  SelectionButtonWidget(selectedValue: 2, title: 'Despesa',),              
                ],
              ),
            )
          ]
        ),
      ),
    );
  }
}