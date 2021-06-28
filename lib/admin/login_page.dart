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
  final int acesso;

  const LoginPage({
    Key? key, 
    required this.acesso
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController();

  List _listname = [];
  int contadorNext = 1;
  int contadorPreviuw = 0;

  @override
  void initState() {
    readData("nomec").then((dynamic data) {
      setState(() {
        _listname = json.decode(data);
        contadorNext = 2;        
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try{
      contadorPreviuw++;
      if(_listname.length > 0 && _listname[0]["contador"] != null){
        if(_listname[0]["contador"] == 1 || widget.acesso == 1) {        
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
                            saveData(_listname, "nomec");
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
        } else {
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
        }      
      } else if(contadorNext >= 1 && _listname.length == 1){
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
                          Map<String, dynamic> newname = Map();
                          newname["user"] = _nameController.text != "" ? _nameController.text : "user";
                          newname["contador"] = 2;
                          _listname.add(newname) ;       
                          saveData(_listname, "nomec");
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
      }
    } catch(e) {
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