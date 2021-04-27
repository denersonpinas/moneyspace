import 'package:MoneySpace/core/app_colors.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;

  TextFieldWidget({
    Key? key, 
    required  this.label, 
  }) : assert(["E-mail", "Senha", "Arroba", "User",].contains(label)), super(key: key);

  final config = {
    "E-mail" : {
      "icon" : Icons.supervised_user_circle,
    },
    "Senha" : {
      "icon" : Icons.lock_outline
    },
  };

  IconData get icon => config[label]!['icon']!;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.greyBlack,
        hintText: label,
        hintStyle: TextStyle(color: AppColors.lightGrey),
        focusedBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: AppColors.greyBlack),
          borderRadius: new BorderRadius.circular(10),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: new BorderSide(color: AppColors.greyBlack),
          borderRadius: new BorderRadius.circular(10),
        ),
        prefixIcon: Icon(
          icon,
          color: AppColors.green,
        ),
      ),
      style: TextStyle(
        color: AppColors.lightGreen,
        fontSize: 21,
      ),
    );
  }            
}