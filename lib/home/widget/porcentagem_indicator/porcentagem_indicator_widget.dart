import 'package:MoneySpace/core/app_colors.dart';
import 'package:MoneySpace/core/app_text_styles.dart';
import 'package:flutter/material.dart';

class PorcentagemIndicatorWidget extends StatelessWidget {
  final Color colorprogress;
  final double value;
  final String valueP;
  const PorcentagemIndicatorWidget({Key? key, required this.valueP, required this.colorprogress, required this.value}) 
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 70,
        width: 70,
        child: Stack(
          children: [
            Container(
              height: 70,
              width: 70,
              child: CircularProgressIndicator(
                strokeWidth: 11,
                value: value,
                backgroundColor: AppColors.greyBlack,
                valueColor: AlwaysStoppedAnimation<Color>(colorprogress)
              ),
            ),
            Center(
              child: Text(
                valueP, 
                style: AppTextStyles.valueList,
              ),
            )
          ],
        ),
      ),
    );
  }
}