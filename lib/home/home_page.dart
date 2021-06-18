import 'dart:convert';

import 'dart:io';


import 'package:moneyspace/core/app_text_styles.dart';
import 'package:moneyspace/home/widget/chart/chart_widget.dart';
import 'package:moneyspace/shared/database/database_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:moneyspace/core/app_colors.dart';
import 'package:moneyspace/core/app_images.dart';
import 'package:moneyspace/selection/selection_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {  

  String _iforText = "";
  
  String _dateTime = "";
  dynamic ano;
  dynamic mes;
  dynamic l;
  int i = 0;
  List _mes = [{1:"Janeiro", 2:"Fevereiro", 3:"Março", 4:"Abril", 5:"Maio", 6:"Junho", 7:"Julho", 8:"Agosto", 9:"Setembro", 10:"Outubro", 11:"Novembro", 12:"Dezembro",}];
  List _listfinance = [
    {
      "carteira": []
    }    
  ];
  late Map<String, dynamic> _lastRemoved;
  late int _lastRemovedPos;

  _setCount(){
    try {
      if(_listfinance[0]["carteira"].length == 0){
        return 0;
      } else if(_listfinance[0]["carteira"][0]["$ano"].length > 0 && _listfinance[0]["carteira"][0]["$ano"][0]["$mes"].length > 0) {      
        return _listfinance[0]["carteira"][0]["$ano"][0]["$mes"].length;
      } else {
        return 0;
      }
    } catch(e) {
      return 0;
    }    
  }

  _setSaldo(){
    return (_setSaldoReceita() - _setSaldoTotGastos()).toString();
  }

  _setSaldoTotGastos(){
    if(_setCount() == 0){
        return 0.0;
    } else if(_setCount() > 0) {     
        double calcgastos = 0;
        for(l = 0; l<_listfinance[0]["carteira"][0]["$ano"][0]["$mes"].length;l++){
          if(_listfinance[0]["carteira"][0]["$ano"][0]["$mes"][l]["gastos valor"] != null){
            calcgastos = int.parse(_listfinance[0]["carteira"][0]["$ano"][0]["$mes"][l]["gastos valor"] != null ? _listfinance[0]["carteira"][0]["$ano"][0]["$mes"][l]["gastos valor"] : "0") + calcgastos;
          }    
        }       
        return calcgastos;
    } else {
        return 0.0;
    }
  }

  _setSaldoReceita(){
    if(_setCount() == 0){
        return 0.0;
    } else if(_setCount() > 0) {      
        double calcsaldoReceita = 0;  
        for(l = 0; l<_listfinance[0]["carteira"][0]["$ano"][0]["$mes"].length;l++){
          if(_listfinance[0]["carteira"][0]["$ano"][0]["$mes"][l]["receita valor"] != null){
            calcsaldoReceita = int.parse(_listfinance[0]["carteira"][0]["$ano"][0]["$mes"][l]["receita valor"] != null ? _listfinance[0]["carteira"][0]["$ano"][0]["$mes"][l]["receita valor"] : "0") + calcsaldoReceita;
          }     
        }
        return calcsaldoReceita;
    } else {
        return 0.0;
    }
  }  

  _addList(recContact) {
    setState(() {
      if(_listfinance[0]["carteira"].length == 0){
        _listfinance[0]["carteira"].add({"$ano":[{"$mes":[]}]});
        if("$ano" == recContact["ano"]){
          if(recContact["receita valor"] != null){
            _listfinance[0]["carteira"][0]["$ano"][0]["$mes"].add(recContact);
            setState(() {
                _iforText = "";
            });
          } else {
            double percent = _setSaldoReceita() * 0.33;
            if(percent < num.parse(recContact["gastos valor"])) {
              setState(() {
                _iforText = "Aumente sua receita, sinal lotado!";
              });
            } else {
              _listfinance[0]["carteira"][0]["$ano"][0]["$mes"].add(recContact);
              setState(() {
                _iforText = "";
              });
            }
          }           
        } else {
          _listfinance[0]["carteira"].add({recContact["ano"]:[{recContact["mes"]:[]}]});
          _listfinance[0]["carteira"][0][recContact["ano"]][0][recContact["mes"]].add(recContact); 
        }
      } else if("$ano" == recContact["ano"]){
          if(recContact["receita valor"] != null){
            _listfinance[0]["carteira"][0]["$ano"][0]["$mes"].add(recContact);
            setState(() {
              _iforText = "";
            });
          } else {
            double percent = _setSaldoReceita() * 0.33;
            if(percent < num.parse(recContact["gastos valor"])) {
              setState(() {
                _iforText = "Aumente sua receita, sinal lotado!";
              });
            } else {
              _listfinance[0]["carteira"][0]["$ano"][0]["$mes"].add(recContact);
              setState(() {
                _iforText = "";
              });
            }
          }
      } else{
        _listfinance[0]["carteira"].add({recContact["ano"]:[{recContact["mes"]:[]}]});
        _listfinance[0]["carteira"][0][recContact["ano"]][0][recContact["mes"]].add(recContact);  
      }
      saveData(_listfinance);
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

  _setPercent(tipo){
    if(_setCount() == 0){
        return 0.33;
    } else if(_setCount() > 0) {     
        double calcgastostipo = 0;
        double result = 0;
        
        for(l = 0; l<_listfinance[0]["carteira"][0]["$ano"][0]["$mes"].length;l++){
          if(_listfinance[0]["carteira"][0]["$ano"][0]["$mes"][l]["gastos valor"] != null && _listfinance[0]["carteira"][0]["$ano"][0]["$mes"][l]["tipo de gastos"] == tipo){
            calcgastostipo = int.parse(_listfinance[0]["carteira"][0]["$ano"][0]["$mes"][l]["gastos valor"] != null ? _listfinance[0]["carteira"][0]["$ano"][0]["$mes"][l]["gastos valor"] : "0") + calcgastostipo;
          }     
        }
        setState(() {
          result = calcgastostipo / (_setSaldoReceita() * 0.33);                     
        });
        return num.parse(result.toStringAsPrecision(2));               
    } else {
        return 0.0;
    }
  }
  
  @override
  void initState() {
    super.initState();
    readData().then((dynamic data){ 
      setState(() {                    
        _listfinance[0]["carteira"] = json.decode(data);
      });        
    });    
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                      "SALDO",
                      style: AppTextStyles.titleSaldo
                  ),
                ),
                Text(
                  "R\$ "+_setSaldo(),
                  style: AppTextStyles.valueSaldo,
                ),
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
                      itemCount: _setCount(),
                      itemBuilder: (context, index){
                        return _gastosCard(context, index);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  _iforText,
                  style: AppTextStyles.bodyBold,
                ),
                SizedBox(
                  height: 10,
                ),
                //Progress indicator
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ChartWidget(
                          percent: _setPercent(1), label: 'vermelho',
                        )),                        
                      Expanded(
                        flex: 2,
                        child: ChartWidget(
                          percent: _setPercent(2), label: 'amarelo',
                        )),                        
                      Expanded(
                        flex: 2,
                        child: ChartWidget(
                          percent: _setPercent(3), label: 'verde',
                        )),                        
                    ],
                  ),
                )
              ],
            ),
          );
      }

  Widget _gastosCard(BuildContext context, int index){
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: AppColors.red,
        child: Align(
          alignment: Alignment(-0.9,0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white
          )
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: GestureDetector(
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
                              _listfinance[0]["carteira"][0]["$ano"][0]["$mes"][index]["gastos descrição"] != null ?  _listfinance[0]["carteira"][0]["$ano"][0]["$mes"][index]["gastos descrição"].toString() : _listfinance[0]["carteira"][0]["$ano"][0]["$mes"][index]["receita descrição"] != null ?  _listfinance[0]["carteira"][0]["$ano"][0]["$mes"][index]["receita descrição"].toString() : "",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                            Text(
                              _listfinance[0]["carteira"][0]["$ano"][0]["$mes"][index]["gastos data"] != null ?  _listfinance[0]["carteira"][0]["$ano"][0]["$mes"][index]["gastos data"].toString() : _listfinance[0]["carteira"][0]["$ano"][0]["$mes"][index]["receita data"] != null ?  _listfinance[0]["carteira"][0]["$ano"][0]["$mes"][index]["receita data"].toString() : "",
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
                      _listfinance[0]["carteira"][0]["$ano"][0]["$mes"][index]["gastos valor"] != null ?  _listfinance[0]["carteira"][0]["$ano"][0]["$mes"][index]["gastos valor"].toString() : _listfinance[0]["carteira"][0]["$ano"][0]["$mes"][index]["receita valor"] != null ?  _listfinance[0]["carteira"][0]["$ano"][0]["$mes"][index]["receita valor"].toString() : "",
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
      ),
      onDismissed: (direction){
        setState(() {
          _lastRemoved = Map.from(_listfinance[0]["carteira"][0]["$ano"][0]["$mes"][index]);
          _lastRemovedPos = index;
          _listfinance[0]["carteira"][0]["$ano"][0]["$mes"].removeAt(index);

          saveData(_listfinance);

          final snack = SnackBar(
            content: Text("Aplicação removida!"),
            action: SnackBarAction(
              label: "Desfazer",
              onPressed: (){
                setState(() {
                  _listfinance[0]["carteira"][0]["$ano"][0]["$mes"].insert(_lastRemovedPos, _lastRemoved);
                  saveData(_listfinance);
                });                
              },
            ),
            duration: Duration(seconds: 2),
          );

          ScaffoldMessenger.of(context).showSnackBar(snack);
        });        
      },
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
    if( _listfinance[0]["carteira"][0]["$ano"][0]["$mes"][index]["receita descrição"] != null){
      return Image.asset(AppImages.arrow);
    } else if ( _listfinance[0]["carteira"][0]["$ano"][0]["$mes"][index]["tipo de gastos"] == 1) {
      return Image.asset(AppImages.red);
    } else if ( _listfinance[0]["carteira"][0]["$ano"][0]["$mes"][index]["tipo de gastos"] == 2) {
      return Image.asset(AppImages.yellow);
    } else if ( _listfinance[0]["carteira"][0]["$ano"][0]["$mes"][index]["tipo de gastos"] == 3){
      return Image.asset(AppImages.green);  
    }
    return Image.asset(AppImages.lock);
      
  }  
}