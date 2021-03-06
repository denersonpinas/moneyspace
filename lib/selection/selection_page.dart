import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:moneyspace/core/app_colors.dart';
import 'package:moneyspace/core/core.dart';
import 'package:moneyspace/shared/widgets/comfirmed_button/confirmed_button_widget.dart';
import 'package:moneyspace/shared/widgets/text_field/text_field_widget.dart';

class SelectionPage extends StatefulWidget {
  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {  

  final _decricaoGastosController = TextEditingController();
  final _valorController = TextEditingController();  

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "";

  void _addTodo() {
    setState(() {
      Map<String, dynamic> newfinance = Map();
      if(UtilBrasilFields.converterMoedaParaDouble(_valorController.text) > 0){
        if(iconRed == true){      
          newfinance["gastos descrição"] = _decricaoGastosController.text;
          newfinance["gastos valor"] = _valorController.text;
          final ano = DateTime.now().year;
          final mes = DateTime.now().month;
          final dia = DateTime.now().day;
          newfinance["ano"] = ano.toString();
          newfinance["mes"] = mes.toString();
          newfinance["dia"] = dia.toString();
          
          if(dropdownValue == "Gastos Essenciais") {
            newfinance["tipo de gastos"] = 1;
          } else if(dropdownValue == "Gastos Não Essenciais") {
            newfinance["tipo de gastos"] = 2;
          } else {
            newfinance["tipo de gastos"] = 3;
          }
        } else {
          newfinance["receita descrição"] = _decricaoGastosController.text;
          newfinance["receita valor"] = _valorController.text;
          final ano = DateTime.now().year;
          final mes = DateTime.now().month;
          final dia = DateTime.now().day;
          newfinance["ano"] = ano.toString();
          newfinance["mes"] = mes.toString();
          newfinance["dia"] = dia.toString();
        }
        // Navegação: Volta para a HOMEPAGE
        Navigator.pop(context, newfinance);
      } else {
        setState(() {
          _infoText = "Coloque um valor valido positivo";
        });
      }      
    });
  }

  _valid(){
    if(_formKey.currentState!.validate()){
      _addTodo();
    }
  }

  late DateTime? _dateTime;
  late String? dropdownValue;
  late bool iconRed;
  late bool iconGreen;
  dynamic circleColor;
  int contadorColor = 1;

  setColor() {
    if(contadorColor == 1){
      contadorColor++;
      return circleColor = AppColors.red;             
    } else if(contadorColor == 2){
      contadorColor++;
      return circleColor = AppColors.yellow;      
    }  else {
      contadorColor = 1;
      return circleColor = AppColors.darkGreen; 
    }
  }

  @override
  void initState() {
    _infoText = "";
    super.initState();
    _dateTime = null;
    dropdownValue = null;
    iconRed = false;
    iconGreen = true;
  }

  setText() {
    if(_dateTime == null) {
      return Row(
        children: [
          Icon(
            Icons.calendar_today,
            color: AppColors.green,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
           DateTime.now().toString(),
            style: TextStyle(
              color: AppColors.lightGrey,
              fontSize: 18,
            ),
          )
        ]);
    } else {
      return Row(
        children: [
          Icon(
            Icons.calendar_today,
            color: AppColors.green,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            _dateTime.toString(),
            style: TextStyle(
              color: AppColors.lightGrey,
              fontSize: 18,
            ),
          )
        ]);
    }
  }
 
  setIconRed() {
    if(iconRed == false) {
      return AppImages.circle;
    } else if(iconGreen == false) { 
      return AppImages.circlered;
    }
  }

  setIconGreen() {
      if(iconGreen == false) {
        return AppImages.circle;
      } else if(iconRed == false) { 
        return AppImages.circlegreen;
      }
  }

  setFarol() {
    if(iconRed == true) {
      return Container(
                padding: EdgeInsets.only(left: 12, right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.greyBlack
                ),
                child: 
                DropdownButton<String>(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.green,
                  ),
                  hint: Row(children: [
                    Image.asset(
                      AppImages.farol,
                      scale: 1.5,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Selecione",
                      style: TextStyle(
                        color: AppColors.lightGrey,
                        fontSize: 18,
                      ),
                    ),
                  ],),
                  dropdownColor: AppColors.greyBlack,
                  value: dropdownValue,                
                  isExpanded: true,
                  iconSize: 36,
                  underline: SizedBox(),
                  style: AppTextStyles.body,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['Gastos Não Essenciais', 'Gastos Essenciais', 'Investimentos']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child:                      
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: setColor(),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            value,
                            style:TextStyle(
                              color: AppColors.lightGrey,
                              fontSize: 18
                            )
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),                
              );
              
    } if (iconRed == false) {
      return SizedBox(
                height: 10,
              );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        title: Text( "Adicionar"),
        centerTitle: true,
      ),
      backgroundColor: AppColors.darkGreyBlack,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(left: 31, right: 31, top: 100),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [                    
                      Column(
                        children: [
                          GestureDetector(
                            child: Image.asset(
                              setIconRed(),
                              scale: 1.5
                            ),
                            // Image: setIconRed(), 
                            onTap: () {
                              setState(() {
                                iconRed = true;
                                iconGreen = false;
                              });                    
                            }
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Despesa",
                            style: AppTextStyles.heading15,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                      Text(
                          "OU",
                          style: AppTextStyles.heading40                                        
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            child:
                              Image.asset(
                                setIconGreen(),
                                scale: 1.5
                              ), 
                              onTap: () {
                                setState(() {
                                  iconGreen = true;
                                  iconRed = false;
                                });                    
                              }
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Receita",
                            style: AppTextStyles.heading15,
                            textAlign: TextAlign.center,
                          )
                        ],
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  setFarol(),
                  SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    label: "Descrição",
                    nameController: _decricaoGastosController,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RealInputFormatter(centavos: true, moeda: true)
                    ],
                    controller: _valorController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.greyBlack,
                      hintText: "10000,00",
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
                        Icons.attach_money,
                        color: AppColors.green,
                      ),
                    ),
                    style: TextStyle(
                      color: AppColors.lightGreen,
                      fontSize: 18,
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    validator: (value){
                      if(value!.isEmpty){
                        return"Este campo é obrigatório!";
                      }
                    },
                  ),

                  // TextFieldWidget(
                  //   label: "10000,00",
                  //   nameController: _valorController,
                  // ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(_infoText, style: AppTextStyles.body20,),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(child: ConfirmedButtonWidget.green(label: "Adicionar", onTap: _valid)),
                    ],
                  ),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}