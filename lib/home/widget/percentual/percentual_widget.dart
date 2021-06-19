import 'package:moneyspace/core/app_colors.dart';
import 'package:moneyspace/core/app_text_styles.dart';
import 'package:moneyspace/shared/widgets/comfirmed_button/confirmed_button_widget.dart';
import 'package:moneyspace/shared/widgets/text_field/text_field_widget.dart';
import 'package:flutter/material.dart';

class PercentualWidget extends StatefulWidget {

  @override
  _PercentualWidgetState createState() => _PercentualWidgetState();
}

class _PercentualWidgetState extends State<PercentualWidget> {
  final _typeOneController = TextEditingController();

  final _typeTwoController = TextEditingController();

  final _typeThreeController = TextEditingController();

  List _listpercentual = [];
  late String _inforText;

  _addTopercent() {
    Map<String, dynamic> newpercentual = Map();

    newpercentual["gastos essenciais"] = _typeOneController.text;
    newpercentual["gastos não essenciais"] = _typeTwoController.text;
    newpercentual["investimentos"] = _typeThreeController.text;

    _listpercentual.add(newpercentual);
    print(_listpercentual);
    // Navigator.pop(context, newfinance);
  }

  _virifPercent(){
    final soma = int.parse(_typeOneController.text) + int.parse(_typeTwoController.text) + int.parse(_typeThreeController.text);
    print("Essa é a soma $soma");      
    if(soma == 100){
      if(int.parse(_typeOneController.text) > 0 && int.parse(_typeTwoController.text) > 0 && int.parse(_typeThreeController.text) > 0){
        _addTopercent();
      } else {
        setState(() {
          _inforText = "Não é permitido valor negativo";
        });  
      }        
    } else {
      setState(() {
        _inforText = "Soma de todas as porcentagens tem que ser 100";
      });        
    }
  }

  @override
  void initState() {
    _inforText = "";
    super.initState();       
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        title: Text( "Editar Porcentagens"),
        centerTitle: true,
      ),
      backgroundColor: AppColors.darkGreyBlack,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 34),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Column(
                  children: [
                    // SizedBox(
                    //   height: 10,
                    // ),
                    TextFieldWidget(
                      label: "Gastos Essenciais(%)",
                      nameController: _typeOneController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      label: "Gastos Não Essenciais(%)",
                      nameController: _typeTwoController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      label: "Investimentos(%)",
                      nameController: _typeThreeController,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(_inforText, style: AppTextStyles.body20,),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: ConfirmedButtonWidget.green(label: "Alterar", onTap: _virifPercent)),
                      ],
                    ),
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
}