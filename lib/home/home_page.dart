import 'package:MoneySpace/core/app_colors.dart';
import 'package:MoneySpace/core/app_text_styles.dart';
import 'package:MoneySpace/home/widget/app_bar/app_bar_widget.dart';
import 'package:MoneySpace/home/widget/porcentagem_indicator/porcentagem_indicator_widget.dart';
import 'package:MoneySpace/home/widget/visor_dados/visor_dados_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGreyBlack,
      appBar: AppBarWidget(),
      body: Column(
        children: [
          Center(
            child: FloatingActionButton(
              
              onPressed: (){},
              tooltip: 'Adicionar',
              child: Icon(Icons.add), 
              backgroundColor: AppColors.darkGreen,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 25),
            height: 225,
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  VisorDadosWidgets(),
                  VisorDadosWidgets(),
                  VisorDadosWidgets(),
                  VisorDadosWidgets(),
                ]
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.center,
              height: 200,
              width: double.maxFinite,
              child: Expanded(
                child: Row(
                  children: [
                    PorcentagemIndicatorWidget(
                      colorprogress: AppColors.red, 
                      value: 0.7, 
                      valueP: "75%"
                    ),
                    PorcentagemIndicatorWidget(
                      colorprogress: AppColors.yellow, 
                      value: 0.3, 
                      valueP: "30%"
                    ),
                    PorcentagemIndicatorWidget(
                      colorprogress: AppColors.darkGreen, 
                      value: 1, 
                      valueP: "100%"
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}