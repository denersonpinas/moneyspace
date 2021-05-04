import 'package:moneyspace/core/app_colors.dart';
import 'package:moneyspace/core/app_text_styles.dart';
import 'package:moneyspace/shared/widgets/comfirmed_button/confirmed_button_widget.dart';
import 'package:moneyspace/shared/widgets/text_field/text_field_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white,), 
                    onPressed: () {}
                  ),
                  Expanded(
                    child: Text(
                      "Acesse Sua Conta",
                      style: 
                      AppTextStyles.title,
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
                    label: "E-mail",
                  ),
                  SizedBox(
                    height: 8,
                  ),
                   TextFieldWidget(
                    label: "Senha",
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
                Expanded(child: ConfirmedButtonWidget.green(label: "Entrar")),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: ConfirmedButtonWidget.grey(label: "Criar uma Conta!")),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: ConfirmedButtonWidget.transparent(label: "Esqueci Minha Senha!")),
              ],
            )
          ],
        ),
      ),
    );
  }
}