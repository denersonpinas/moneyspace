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

class _ChartWidgetState extends State<ChartWidget> 
  with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  late Animation<double> _animation;

  void _initAnimation() {   
    setState(() {
      _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 3)
      );
      _animation = Tween<double>(begin: 0.0, end: widget.percent).animate(_controller);
      _controller.forward();
    });     
  }

  @override
  void initState() {
    setState(() {
      _initAnimation();
    });    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 80,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, _)=> Stack(
              children: [
                Center(
                  child: Container(
                    height: 80,
                    width: 80,
                    child: CircularProgressIndicator(
                      strokeWidth: 10,
                      value: _animation.value,
                      backgroundColor: widget.bgCor,
                      valueColor: AlwaysStoppedAnimation<Color>(widget.cor),
                    ),
                  ),
                ),
                Center(
                  child: Text("${(_animation.value * 100).toInt()}%",
                    style: AppTextStyles.heading,
                  ),
                )
              ],
            ),
          ),
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