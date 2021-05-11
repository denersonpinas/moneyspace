import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_text_styles.dart';
import '../../../core/app_text_styles.dart';

class DateWidget extends StatefulWidget {
  @override
  _DateWidgetState createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {

  late DateTime? _dateTime;
  late String? dropDownValue;

  @override
  void initState(){
    super.initState();
    _dateTime = null;
    dropDownValue = null;
  }

  setText() {
    if(_dateTime == null) {
      return Row(
        children: [
          Text(
            "Maio/2021",
            style: AppTextStyles.titleData
          )
        ]);
    } else {
      return Row(
        children: [
          Text(
            _dateTime.toString(),
            style: TextStyle(
              color: AppColors.black,
              fontSize: 18,
            ),
          )
        ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Padding(
        padding: const EdgeInsets.all(1),
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
    );
  }
}