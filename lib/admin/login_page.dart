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

  List _listname = [
    {
      "user": ""
    }
  ];
  int contadorNext = 1;
  int contadorPreviuw = 0;

  @override
  void initState() {    
    readData("nomec").then((dynamic data) {
      _listname = json.decode(data);
      _nameController.text = _listname[0]["user"];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      backgroundColor: AppColors.darkGreyBlack,
      body: 
      SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2.5,
                decoration: BoxDecoration(
                  gradient: AppGradients.linear,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(97)
                  )
                ),
                child: Center(
                  child: Image.asset(
                    AppImages.logo02,
                    scale: 10
                  )        
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 80, left: 32, right: 32),
                child:
                  Column(
                    children: [
                      Container(                        
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Digite seu usuario!",
                            style: AppTextStyles.title,
                          ),
                        )
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          TextFieldWidget(
                            label: "Nome ou Apelido",
                            nameController: _nameController,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: ConfirmedButtonWidget.green(
                              label: "Entrar", 
                              onTap: (){
                                _listname[0]["user"] = _nameController.text != "" ? _nameController.text : "user";                    
                                saveData(_listname, "nomec");
                                Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context) => Home())
                                );
                              }
                            )
                          ),
                        ],
                      ),
                    ],)
                ),            
            ],
          ),
        ),
      )      
    );
  }
}
