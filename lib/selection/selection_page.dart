import 'package:flutter/material.dart';

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

  void _addTodo() {
    setState(() {
      Map<String, dynamic> newfinance = Map();
      if(iconRed == true){      
        newfinance["gastos descrição"] = _decricaoGastosController.text;
        newfinance["gastos valor"] = _valorController.text;
        final ano = DateTime.now().year;
        final mes = DateTime.now().month;
        newfinance["ano"] = ano.toString();
        newfinance["mes"] = mes.toString();
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
        newfinance["ano"] = ano.toString();
        newfinance["mes"] = mes.toString();
      }
      Navigator.pop(context, newfinance);
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
    super.initState();
    _dateTime = null;
    dropdownValue = null;
    iconRed = false;
    iconGreen = false;
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
    } if(iconGreen == false) { 
      return AppImages.circlered;
    }
  }

  setIconGreen() {
      if(iconGreen == false) {
        return AppImages.circle;
      } if(iconRed == false) { 
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
                  items: <String>['Gastos Essenciais', 'Gastos Não Essenciais', 'Investimentos']
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
                TextFieldWidget(
                  label: "10000.00",
                  nameController: _valorController,
                ),
                SizedBox(
                  height: 10,
                ),
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
    );
  }
}