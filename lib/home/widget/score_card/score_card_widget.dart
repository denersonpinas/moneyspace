import 'package:moneyspace/core/app_colors.dart';
import 'package:moneyspace/core/app_text_styles.dart';
import 'package:flutter/material.dart';

class ScoreCardWidget extends StatelessWidget {
  final double percent;
  const ScoreCardWidget({
    Key? key,
    required this.percent
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        height: 136,
        decoration: BoxDecoration(
          color: AppColors.greyBlack,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Expanded(
              //   flex: 1,
              //   child: ChartWidget(
              //     percent: percent,
              //   )),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Saldo",
                        style: AppTextStyles.title,  
                      ),
                      Text("4.500",
                        style: AppTextStyles.valueSaldo,
                      )
                    ],
                  ),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}