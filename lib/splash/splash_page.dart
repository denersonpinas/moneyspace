import 'package:MoneySpace/admin/cadastro/cadastro_page.dart';
import 'package:flutter/material.dart';
import 'package:MoneySpace/core/app_gradients.dart';
import 'package:MoneySpace/core/app_images.dart';

class SplashPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(
      seconds:  2
    )).then((_)=> Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => CadastroPage())
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
}