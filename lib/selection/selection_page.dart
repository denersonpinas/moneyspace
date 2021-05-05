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

  @override
  void initState() {
    super.initState();
    _dateTime = null;
  }

  setText() {
    if(_dateTime == null) {
      return Icon(
            Icons.calendar_today,
            color: AppColors.green,
          );
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
            style: AppTextStyles.body,
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
              TextFieldWidget(label: "E-mail"),
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