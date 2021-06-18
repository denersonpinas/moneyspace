import 'package:moneyspace/core/app_colors.dart';
import 'package:moneyspace/core/app_text_styles.dart';
import 'package:moneyspace/shared/widgets/comfirmed_button/confirmed_button_widget.dart';
import 'package:moneyspace/shared/widgets/text_field/text_field_widget.dart';
import 'package:flutter/material.dart';

class PercentualWidget extends StatelessWidget {

  final _typeOneController = TextEditingController();
  final _typeTwoController = TextEditingController();
  final _typeThreeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        title: Text( "Editar Porcentagens"),
        centerTitle: true,
      ),
      backgroundColor: AppColors.darkGreyBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 34),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Column(
                  children: [
                    // SizedBox(
                    //   height: 10,
                    // ),
                    TextFieldWidget(
                      label: "Gastos Essenciais(%)",
                      nameController: _typeOneController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      label: "Gastos Não Essenciais(%)",
                      nameController: _typeTwoController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      label: "Investimentos(%)",
                      nameController: _typeThreeController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: ConfirmedButtonWidget.green(label: "Adicionar", onTap: () {

                        })),
                      ],
                    ),
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
}