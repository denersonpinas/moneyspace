import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moneyspace/splash/splash_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("pt","BR")
      ],

      title: "MoneySpace",
      home: SplashPage()
    );
  }
}