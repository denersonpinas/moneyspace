import 'package:flutter/services.dart';
import 'package:moneyspace/core/app_colors.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String label;
  final TextEditingController nameController;

  TextFieldWidget({
    Key? key, 
    required  this.label,
    required this.nameController, 
  }) : assert(["Nome ou Apelido", "10000.00", "Descrição", "Gastos Essenciais(%)", "Gastos Não Essenciais(%)", "Investimentos(%)"].contains(label)), super(key: key);

  final config = {
    "Nome ou Apelido" : {
      "icon" : Icons.supervised_user_circle,
      "inputType": TextInputType.text
    },
    "10000.00" : {
      "icon" : Icons.attach_money,
      "inputType": TextInputType.numberWithOptions(decimal: true)
    },
    "Descrição" : {
      "icon" : Icons.comment,
      "inputType": TextInputType.text
    },
    "Gastos Essenciais(%)" : {
      "icon" : Icons.account_balance_wallet_sharp
    },
    "Gastos Não Essenciais(%)" : {
      "icon" : Icons.local_airport_outlined
    },
    "Investimentos(%)" : {
      "icon" : Icons.attach_money
    },
  };

  get icon => config[label]!['icon']!;
  get inputType => config[label]!['inputType']!;

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.nameController,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.greyBlack,
        hintText: widget.label,
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
          widget.icon,
          color: AppColors.green,
        ),
      ),
      style: TextStyle(
        color: AppColors.lightGreen,
        fontSize: 18,
      ),
      keyboardType: widget.inputType,
      validator: (value){
        if(value!.isEmpty){
          return"Este campo é obrigatório!";
        }
      },
    );
  }            
}