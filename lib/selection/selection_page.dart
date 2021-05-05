import 'package:moneyspace/core/core.dart';
import 'package:moneyspace/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:moneyspace/selection/widgets/selection_button/selection_button_widget.dart';
import 'package:moneyspace/shared/widgets/comfirmed_button/confirmed_button_widget.dart';
import 'package:moneyspace/shared/widgets/text_field/text_field_widget.dart';

class SelectionPage extends StatefulWidget {
  
  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {  

  late DateTime? _dateTime;
  late String? dropdownValue;
  dynamic circleColor;
  int contadorColor = 1;

  setColor() {
    if(contadorColor == 1){
      contadorColor++;
      return circleColor = AppColors.darkGreen;      
    } else if(contadorColor == 2){
      contadorColor++;
      return circleColor = AppColors.yellow;      
    }  else {
      contadorColor = 1;
      return circleColor = AppColors.red;      
    }
  }

  @override
  void initState() {
    super.initState();
    _dateTime = null;
    dropdownValue = null;
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
            "05/05/1990",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        title: Text("Adicionar"),
        centerTitle: true,
      ),
      backgroundColor: AppColors.darkGreyBlack,
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 100, right: 100, top: 100),
          child: Column(
            children: [
              Row(children: [SelectionButtonWidget()]),
              SizedBox(
                height: 50,
              ),
              Container(
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
              ),
              SizedBox(
                height: 10,
              ),
              TextFieldWidget(label: "Cafézinho"),
              SizedBox(
                height: 10,
              ),
              TextFieldWidget(label: "3,75"),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(AppColors.greyBlack),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: 
                            BorderRadius.circular(10)
                          )
                        ),
                      ),
                      child: 
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child:
                        setText()
                      ),
                      onPressed: () {
                        showDatePicker(
                          context: context, 
                          initialDate: DateTime.now(), 
                          firstDate: DateTime(2020), 
                          lastDate: DateTime(2222),
                          locale: Locale("pt", "BR")
                        ).then((date) => {
                          setState((){
                            _dateTime = date;
                          })                        
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: ConfirmedButtonWidget.green(label: "Adicionar")),
                ],
              ),
            ]
          ),
        ),
      ),
    );
  }
}