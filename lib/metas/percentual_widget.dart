import 'package:moneyspace/core/app_colors.dart';
import 'package:moneyspace/core/app_text_styles.dart';
import 'package:moneyspace/home/home.dart';
import 'package:moneyspace/shared/database/database_page.dart';
import 'package:moneyspace/shared/widgets/comfirmed_button/confirmed_button_widget.dart';
import 'package:moneyspace/shared/widgets/text_field/text_field_widget.dart';
import 'package:flutter/material.dart';

class PercentualWidget extends StatefulWidget {

  final mes;

  const PercentualWidget({
    Key? key,
    required this.mes
  }) : super(key: key);

  @override
  _PercentualWidgetState createState() => _PercentualWidgetState();
}

class _PercentualWidgetState extends State<PercentualWidget> {
  
  final _typeOneController = TextEditingController();
  final _typeTwoController = TextEditingController();
  final _typeThreeController = TextEditingController();

  List _listmetas = [
    {
      "metas mes" : {
        "Janeiro" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Fevereiro" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Março" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Abril" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Maio" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Junho" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Julho" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Agosto" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Setembro" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Outubro" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Novembro" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Dezembro" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ]
      }
    }    
  ];
  late String _inforText;

  @override
  void initState() {
    _inforText = "";

    _typeOneController.text = "60";
    _typeTwoController.text =  "30";
    _typeThreeController.text = "10";
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
                    TextFieldWidget(
                      label: "Gastos Não Essenciais(%)",
                      nameController: _typeTwoController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      label: "Gastos Essenciais(%)",
                      nameController: _typeOneController,
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
                        Expanded(
                          child: ConfirmedButtonWidget.green(
                            label: "Alterar", 
                            onTap: (){
                              final soma = int.parse(_typeOneController.text) + int.parse(_typeTwoController.text) + int.parse(_typeThreeController.text);    
                              if(soma == 100){
                                if(int.parse(_typeOneController.text) > 0 && int.parse(_typeTwoController.text) > 0 && int.parse(_typeThreeController.text) > 0){
                                  _listmetas[0]["metas mes"]["${widget.mes}"][0]["gastos essenciais"] = (double.parse(_typeOneController.text) / 100);
                                  _listmetas[0]["metas mes"]["${widget.mes}"][0]["gastos não essenciais"] = (double.parse(_typeTwoController.text) / 100);
                                  _listmetas[0]["metas mes"]["${widget.mes}"][0]["investimentos"] = (double.parse(_typeThreeController.text) / 100); 
                                  _inforText = "";
                                  saveData(_listmetas[0], "metas1");

                                  Navigator.push(
                                    context, MaterialPageRoute(
                                      builder: (context) => Home()
                                  ));
                                } else {
                                  setState(() {
                                    _inforText = "Não é permitido valor menor ou igual a 0";
                                  });  
                                }        
                              } else {
                                setState(() {
                                  _inforText = "A soma de todas as porcentagens tem que ser 100";
                                });        
                              }                              
                            }
                          )
                        ),
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

  HomePage buildHomePage() => HomePage();
}

class HomePage {
}