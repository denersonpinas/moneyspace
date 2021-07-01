import 'package:flutter/material.dart';
import 'package:moneyspace/admin/login_page.dart';
import 'package:moneyspace/core/app_images.dart';

class SplashPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(
      seconds:  2
    )).then((_)=> Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => LoginPage())
    ));
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Image.asset(AppImages.logo, scale: 5,)        
        ),
      ),
    );
  }
}