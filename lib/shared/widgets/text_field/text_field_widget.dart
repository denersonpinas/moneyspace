import 'package:moneyspace/core/app_colors.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;

  TextFieldWidget({
    Key? key, 
    required  this.label, 
  }) : assert(["E-mail", "Senha", "Nome ou Apelido", "Repita a Senha", "3,75", "Cafézinho",].contains(label)), super(key: key);

  final config = {
    "Nome ou Apelido" : {
      "icon" : Icons.supervised_user_circle
    },
    "E-mail" : {
      "icon" : Icons.alternate_email
    },
    "Senha" : {
      "icon" : Icons.lock_outline
    },    
    "Repita a Senha" : {
      "icon" : Icons.lock_outline
    },
    "3,75" : {
      "icon" : Icons.attach_money
    },
    "Cafézinho" : {
      "icon" : Icons.comment
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