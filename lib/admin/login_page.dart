import 'dart:convert';

import 'package:moneyspace/core/app_colors.dart';
import 'package:moneyspace/core/app_gradients.dart';
import 'package:moneyspace/core/app_images.dart';
import 'package:moneyspace/core/app_text_styles.dart';
import 'package:moneyspace/home/home.dart';
import 'package:moneyspace/shared/database/database_page.dart';
import 'package:moneyspace/shared/widgets/comfirmed_button/confirmed_button_widget.dart';
import 'package:moneyspace/shared/widgets/text_field/text_field_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController();

  List _listname = [];

  @override
  void initState() {
    readData("admin").then((dynamic data) {
      setState(() {
        _listname = json.decode(data);
        print("ESSE ${_listname}");
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(_listname != null && _listname[0]["contador"] == 1){      
      return Scaffold(
        backgroundColor: AppColors.darkGreyBlack,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 34),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Digite seu usuario!",
                        style:
                        AppTextStyles.title,
                      )
                    ),
                  ]
                )
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  children: [
                    TextFieldWidget(
                      label: "Nome ou Apelido",
                      nameController: _nameController,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ConfirmedButtonWidget.green(
                      label: "Inserir", 
                      onTap: (){
                        _listname[0]["user"] = _nameController.text != "" ? _nameController.text : "user";
                        if(_listname[0]["contador"] == 1 || _listname[0]["contador"] < 2){
                          _listname[0]["contador"] = _listname[0]["contador"] + 1; 
                        }                      
                        saveData(_listname, "admin");
                        Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => Home())
                        );
                      }
                    )
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else if(_listname != null && _listname[0]["contador"] > 1) {
      Future.delayed(Duration(
          seconds:  0
      )).then((_)=> Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home())
      ));

      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: AppGradients.linear,
          ),
          child: Center(
            child: Image.asset(AppImages.logo)        
          ),
        ),
      );

    } else {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: AppGradients.linear,
          ),
          child: Center(
            child: Image.asset(AppImages.logo)        
          ),
        ),
      );
    }
    
  }
}