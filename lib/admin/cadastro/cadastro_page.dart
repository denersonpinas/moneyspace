import 'package:MoneySpace/core/app_colors.dart';
import 'package:MoneySpace/core/app_text_styles.dart';
import 'package:MoneySpace/shared/widgets/comfirmed_button/confirmed_button_widget.dart';
import 'package:MoneySpace/shared/widgets/text_field/text_field_widget.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGreyBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 34),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(            
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Crie Sua Conta",
                      style: 
                      AppTextStyles.title, 
                      textAlign: TextAlign.center,
                    )
                  ),
                ]
              )
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                children: [
                  TextFieldWidget(
                    label: "Nome ou Apelido",
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFieldWidget(
                    label: "E-mail",
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFieldWidget(
                    label: "Senha",
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFieldWidget(
                    label: "Repita a Senha",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [                
                Expanded(child: ConfirmedButtonWidget.green(label: "Cadastrar!")),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: ConfirmedButtonWidget.transparent(label: "Já tenho uma conta!")),
              ],
            )
          ],
        ),
      ),
    );
  }
}