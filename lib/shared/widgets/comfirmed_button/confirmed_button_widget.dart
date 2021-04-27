import 'package:MoneySpace/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmedButtonWidget extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color fontColor;
  final Color boderColor;
  // final VoidCallback onTap;
  ConfirmedButtonWidget({
    Key? key, 
    required this.label, 
    required this.backgroundColor, 
    required this.fontColor,
    required this.boderColor, 
    // required this.onTap,
  }) : super(key: key);

  ConfirmedButtonWidget.green({ required String label})
    : this.backgroundColor = AppColors.darkGreen,
      this.fontColor = AppColors.white,
      this.boderColor = AppColors.green,
      // this.onTap = onTap,
      this.label = label;
  
  ConfirmedButtonWidget.transparent({ required String label})
    : this.backgroundColor = Colors.transparent,
      this.fontColor = AppColors.lightGrey,
      this.boderColor = Colors.transparent,
      // this.onTap = onTap,
      this.label = label;
  
  ConfirmedButtonWidget.grey({ required String label})
    : this.backgroundColor = AppColors.grey,
      this.fontColor = AppColors.lightGrey,
      this.boderColor = AppColors.border,
      // this.onTap = onTap,
      this.label = label;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            backgroundColor
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: 
              BorderRadius.circular(10)
            )
          ),
          side: MaterialStateProperty.all(
            BorderSide(color: boderColor)
          ),
        ),
        onPressed: (){},//onTap, 
        child: Text(label,
        style: GoogleFonts.notoSans(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: fontColor,
        ),
        )
      ),
    );
  }
}