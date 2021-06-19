import 'package:moneyspace/core/app_colors.dart';
import 'package:moneyspace/core/app_text_styles.dart';
import 'package:flutter/material.dart';

class ChartWidget extends StatefulWidget {
  final String label;
  final double percent;
  final int varPercent;

  ChartWidget({
    Key? key,
    required this.label,
    required this.percent,
    required this.varPercent
  }) : assert(["vermelho", "verde", "amarelo",].contains(label)), super(key: key);

  final config = {
    "vermelho" : {
      "cor" : AppColors.red,
      "bgCor" : AppColors.lightRed,
    },
    "verde" : {
      "cor" : AppColors.green,
      "bgCor" : AppColors.lightGreen,
    },
    "amarelo" : {
      "cor" : AppColors.yellow,
      "bgCor" : AppColors.lightYellow,
    }
  };

  Color get cor => config[label]!['cor']!;
  Color get bgCor => config[label]!['bgCor']!;

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}
const two_PI = 3.14 * 2;
class _ChartWidgetState extends State<ChartWidget> 
  with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }
  final size = 100.0;
  @override
  Widget build(BuildContext context) {    
    return Column(
      children: [
        Center(
          child: TweenAnimationBuilder(
            tween: Tween(begin: 0.0,end: widget.percent),
            duration: Duration(seconds: 4),
            builder: (context,double value,child){
              int percentage = (value*100).ceil();
              return Container(
                width: size,
                height: size,
                child: Stack(
                  children: [
                    ShaderMask(
                      shaderCallback: (rect){
                        return SweepGradient(
                            startAngle: 0.0,
                            endAngle: two_PI,
                            stops: [value,value],
                            center: Alignment.center,
                            colors: [widget.cor,widget.bgCor]
                        ).createShader(rect);
                      },
                      child: Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white
                            // image: DecorationImage(image: Image.asset("assets/images/radial_scale.png").image)
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: size-20,
                        height: size-20,
                        decoration: BoxDecoration(
                            color: AppColors.darkGreyBlack,
                            shape: BoxShape.circle
                        ),
                        child: Center(
                          child: 
                            Text(
                              "$percentage %",
                              style: AppTextStyles.body20,
                            )
                        ),
                      )
                    )
                  ],
                ),
              );
            },
          )
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: 53,
            decoration: BoxDecoration(
              color: widget.bgCor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
              child: Text(
                "${widget.varPercent}%",
                style: AppTextStyles.valuePorcent
              ),
            ),
          ),
        )
      ],
    );
  }
}