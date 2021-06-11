import 'dart:convert';

import 'dart:io';


import 'package:path_provider/path_provider.dart';
import 'package:moneyspace/core/app_colors.dart';
import 'package:moneyspace/core/app_images.dart';
import 'package:moneyspace/selection/selection_page.dart';
import 'package:moneyspace/home/widget/porcentagem_indicator/porcentagem_indicator_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {  
  
  String _dateTime = "";
  dynamic ano;
  dynamic mes;
  int i = 0;
  List _mes = [{1:"Janeiro", 2:"Fevereiro", 3:"Março", 4:"Abril", 5:"Maio", 6:"Junho", 7:"Julho", 8:"Agosto", 9:"Setembro", 10:"Outubro", 11:"Novembro", 12:"Dezembro",}];
  // List convertMes = [{"Janeiro": 0, "Fevereiro": 1, "Março" : 2, "Abril":3, "Maio":4, "Junho":5, "Julho":6, "Agosto":7, "Setembro":8, "Outubro":9, "Novembro":10, "Dezembro":11,}];
  List _listfinance = [];
  //   {
  //   "Name": "+DinDin",
  //   "descricao": "",
  //   "tiposdegastos": [
  //       {
  //         "1" : "Gastos Essenciais",
  //         "2" : "Gastos Não Essenciais",
  //         "3" : "Investimento"
  //       }
  //     ],
  //   "carteira" : []
  //   }
  // ];

  @override
  void initState() {
    super.initState();
    readData().then((dynamic data){      
      setState(() { 
        _listfinance = json.decode(data);
        // print("Aqui");       
        // if(data != null){
        //   print("Aqui 1");
        //   _listfinance[0]["carteira"] = json.decode(data);
        // } else if(_listfinance[0]["carteira"] != null){
        //   print("Aqui 2");
        //   _listfinance[0]["carteira"] = {"$ano":[{"Janeiro":[], "Fevereiro":[], "Março":[], "Abril":[], "Maio":[], "Junho":[], "Julho":[], "Agosto":[], "Setembro":[], "Outubro":[], "Novembro":[], "Dezembro":[]}]};       
        // } else {
        //   print("Aqui 3");
        //   for(i=0; i < _listfinance[0]["carteira"].length; i++){
        //     if(_listfinance[0]["carteira"][i] != ano.toString()){
        //       if(i == _listfinance[0]["carteira"].length){
        //         _listfinance[0]["carteira"] = {"$ano":[{"Janeiro":[], "Fevereiro":[], "Março":[], "Abril":[], "Maio":[], "Junho":[], "Julho":[], "Agosto":[], "Setembro":[], "Outubro":[], "Novembro":[], "Dezembro":[]}]};
        //       }   
        //     }
        //   }
        // }
      });        
    });    
  }

  void _addList(recContact) {
    setState(() { 
      _listfinance.add(recContact);  
      saveData();
      print("Salvou!");    
    });
  }

  setData() {    
    if(_dateTime == "") {
      ano = DateTime.now().year;
      final mesN = DateTime.now().month;
      mes = _mes[0][mesN]; 
      _dateTime = "$mes / $ano";
      return _dateTime;
    } else {
      return _dateTime;
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: AppColors.darkGreyBlack,
            appBar: AppBar(
              leading: GestureDetector(
                child: Image.asset(
                  AppImages.bars,
                  scale: 1.8,
                ),
                onTap: (){},
              ),
              title: GestureDetector(
                child: Text(
                  setData()
                ),
                onTap:(){
                  showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(), 
                    firstDate: DateTime(2020), 
                    lastDate: DateTime(2222),
                    locale: Locale("pt", "BR")
                  ).then((date) => {
                    setState((){
                      ano = date?.year;
                      final mesN = date?.month;
                      mes = _mes[0][mesN];  
                      _dateTime = "$mes / $ano";
                    })           
                  });
                },
              ),              
              backgroundColor: AppColors.green,              
            ),
            body: Column(
              children: [
                Center(
                  child:
                  FloatingActionButton(
                    onPressed: (){
                      _showSelectionPage();
                    },
                    tooltip: 'Adicionar',
                    child: Icon(Icons.add),
                    backgroundColor: AppColors.darkGreen,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 25),
                    height: 225,
                    width: double.maxFinite,
                    child: ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: _listfinance.length,
                      itemBuilder: (context, index){
                        return _gastosCard(context, index);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.center,
                    height: 200,
                    width: double.maxFinite,
                    child: Expanded(
                      child: Row(
                        children: [
                          PorcentagemIndicatorWidget(
                            colorprogress: AppColors.red,
                            value: 0.7,
                            valueP: "75%"
                          ),
                          PorcentagemIndicatorWidget(
                            colorprogress: AppColors.yellow,
                            value: 0.3,
                            valueP: "30%"
                          ),
                          PorcentagemIndicatorWidget(
                            colorprogress: AppColors.darkGreen,
                            value: 1,
                            valueP: "100%"
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
      }

  Widget _gastosCard(BuildContext context, int index){
    return GestureDetector(
      child: Card(
        color: AppColors.darkGreyBlack,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child:
                Row(                  
                  children: [
                    selectImage(index),
                    Padding(
                      padding: EdgeInsets.only(left:10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _listfinance[index]["gastos descrição"] != null ?  _listfinance[index]["gastos descrição"].toString() : _listfinance[index]["receita descrição"] != null ?  _listfinance[index]["receita descrição"].toString() : "",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ),
                          Text(
                            _listfinance[index]["gastos data"] != null ?  _listfinance[index]["gastos data"].toString() : _listfinance[index]["receita data"] != null ?  _listfinance[index]["receita data"].toString() : "",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white
                            ),
                          ),
                        ],
                      ),
                    )
                  ]
                )                
              ),
              Container(
                child:
                  Text(
                    _listfinance[index]["gastos valor"] != null ?  _listfinance[index]["gastos valor"].toString() : _listfinance[index]["receita valor"] != null ?  _listfinance[index]["receita valor"].toString() : "",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white
                    ),
                  ),
              )             
            ]
          ),
        )
      ),
    );
  }

  void _showSelectionPage() async {
    final recContact = await Navigator.push(context,
      MaterialPageRoute(builder: (context) => SelectionPage())
    );
    if(recContact != null){
      _addList(recContact);
    }
  }  

  Image selectImage(int index) {
    if(_listfinance[index]["receita descrição"] != null){
      return Image.asset(AppImages.arrow);
    } else if (_listfinance[index]["tipo de gastos"] == 1) {
      return Image.asset(AppImages.red);
    } else if (_listfinance[index]["tipo de gastos"] == 2) {
      return Image.asset(AppImages.yellow);
    } else if (_listfinance[index]["tipo de gastos"] == 3){
      return Image.asset(AppImages.green);  
    }
    return Image.asset(AppImages.lock);
      
  }

  Future<File>_getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/test1.json");
  }

  Future<File> saveData() async {
    String data = json.encode(_listfinance);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String?> readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}