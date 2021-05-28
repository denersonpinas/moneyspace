import 'package:moneyspace/core/app_colors.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController nameController;

  TextFieldWidget({
    Key? key, 
    required  this.label,
    required this.nameController, 
  }) : assert(["Nome ou Apelido", "3,75", "Cafézinho",].contains(label)), super(key: key);

  final config = {
    "Nome ou Apelido" : {
      "icon" : Icons.supervised_user_circle
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
      controller: nameController,
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
        fontSize: 18,
      ),
    );
  }            
}