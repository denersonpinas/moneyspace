import 'package:flutter/material.dart';
import 'package:moneyspace/core/app_text_styles.dart';

class AlertWidget extends StatelessWidget {
  String inforText;
  String typeInforText;
  AlertWidget({
    Key? key,
    required this.inforText,
    required this.typeInforText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(
      seconds:  5
    )).then((_) {
      inforText = "";
      typeInforText = "";
      return Text.rich(TextSpan(text: "", children: [TextSpan(text: "",)]));});
    
    return Padding(
      padding: inforText != "" ? EdgeInsets.all(8.0) : EdgeInsets.all(0),
      child: Text.rich(
        TextSpan(
          text: typeInforText,
          children: [
            TextSpan(
              text: inforText,
            )
          ],
          style: AppTextStyles.bodyBold
        )
      ),
    );      
  }
}
