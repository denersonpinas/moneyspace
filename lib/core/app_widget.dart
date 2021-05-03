import 'package:MoneySpace/home/home_page.dart';
import 'package:MoneySpace/splash/splash_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MoneySpace",
      home: HomePage()
    );
  }
}