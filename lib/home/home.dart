import 'dart:convert';
import 'dart:core';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:moneyspace/admin/login_page.dart';
import 'package:moneyspace/core/app_text_styles.dart';
import 'package:moneyspace/home/widget/chart/chart_widget.dart';
import 'package:moneyspace/metas/percentual_widget.dart';
import 'package:moneyspace/shared/database/database_page.dart';
import 'package:moneyspace/core/app_colors.dart';
import 'package:moneyspace/core/app_images.dart';
import 'package:moneyspace/selection/selection_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  String _iforText = "";
  late double percent;

  String _dateTime = "";
  dynamic ano;
  dynamic mes;
  dynamic l;

  List _convertMes = [
    {
      "Janeiro" : 1,
      "Fevereiro" : 2,
      "Março" : 3,
      "Abril" : 4,
      "Maio" : 5,
      "Junho" : 6,
      "Julho" : 7,
      "Agosto" : 8,
      "Setembro" : 9,
      "Outubro" : 10,
      "Novembro" : 11,
      "Dezembro" : 12
    }
  ];
  List _mes = [
    {
      1: "Janeiro",
      2: "Fevereiro",
      3: "Março",
      4: "Abril",
      5: "Maio",
      6: "Junho",
      7: "Julho",
      8: "Agosto",
      9: "Setembro",
      10: "Outubro",
      11: "Novembro",
      12: "Dezembro",
    }
  ];
  List _listfinance = [
    {"carteira": []}
  ];
  List _listname = [
    {"user": "user"}
  ];
  List _listmetas = [
    {
      "gastos essenciais": 0.6,
      "gastos não essenciais": 0.3,
      "investimentos": 0.1
    }
  ];
  late Map<String, dynamic> _lastRemoved;
  late int _lastRemovedPos;
  late int indiceAno;
  late int indiceMes;

  _setCount() {
    int countList = _listfinance[0]["carteira"].length;
    int countMesList;

    try {
      if (countList == 0) {
        return 0;
      } else if (_listfinance[0]["carteira"][_setIndiceAno()]["$ano"] != null && _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"] != null) {
        countMesList = _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"].length;
        return countMesList;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  _setIndiceAno(){
    indiceAno = ano - 2021;
    return indiceAno;
  }

  _setSaldo() {
    NumberFormat formatter = NumberFormat("0.00");
    final resultado = _setSaldoReceita() - _setSaldoTotGastos();
    print("$resultado = ${_setSaldoReceita()} - ${_setSaldoTotGastos()}");
    return formatter.format(resultado);
  }

  _setSaldoTotGastos() {  
    double calcgastos = 0;
    int contAno;
    int contMes;

    for(contAno = 0; contAno < _listfinance[0]["carteira"].length;contAno++){

      for(contMes = 0; contMes < 12; contMes++){
        
        for(l = 0; l < _listfinance[0]["carteira"][0 + contAno]["${2021 + contAno}"][_mes[0][1 + contMes]].length;l++){

          if (_listfinance[0]["carteira"][0 + contAno]["${2021 + contAno}"][_mes[0][1 + contMes]][l]["gastos valor"] != null) {
            print(_mes[0][1 + contMes]);
            calcgastos = UtilBrasilFields.converterMoedaParaDouble(_listfinance[0]["carteira"][0 + contAno]["${2021 + contAno}"][_mes[0][1 + contMes]][l]["gastos valor"] != null ? _listfinance[0]["carteira"][0 + contAno]["${2021 + contAno}"][_mes[0][1 + contMes]][l]["gastos valor"] : 0.0) + calcgastos;
            print(calcgastos);
          }
        }
      }
    }

    return calcgastos;
  }

  _setSaldoReceita() {
    double calcsaldoReceita = 0;
    int contAno;
    int contMes;

    for(contAno = 0; contAno < _listfinance[0]["carteira"].length;contAno++){

      for(contMes = 0; contMes < 12; contMes++){
        
        for(l = 0; l < _listfinance[0]["carteira"][0 + contAno]["${2021 + contAno}"][_mes[0][1 + contMes]].length;l++){

          if (_listfinance[0]["carteira"][0 + contAno]["${2021 + contAno}"][_mes[0][1 + contMes]][l]["receita valor"] != null) {
            print(_mes[0][1 + contMes]);
            calcsaldoReceita = UtilBrasilFields.converterMoedaParaDouble(_listfinance[0]["carteira"][0 + contAno]["${2021 + contAno}"][_mes[0][1 + contMes]][l]["receita valor"] != null ? _listfinance[0]["carteira"][0 + contAno]["${2021 + contAno}"][_mes[0][1 + contMes]][l]["receita valor"] : 0.0) + calcsaldoReceita;
            print(calcsaldoReceita);
          }
        }
      }
    }
    
    return calcsaldoReceita;
  }

  // Função adiciona 'Receitas' e 'Despesas' 
  // recebendo do selection_page pelo recContact e passando para o _listfinance
  _addList(recContact) {
    print(_listfinance);
    print("--------------");
    setState(() {
      if(_listfinance[0]["carteira"].length > 0){

        if(_listfinance[0]["carteira"][_setIndiceAno()]["$ano"] != null){

          if (recContact["receita valor"] != null) { 
            _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"].add(recContact);            
            setState(() {
              _iforText = "";
            });

          } else {
            List convertList = [{1:"gastos essenciais", 2:"gastos não essenciais", 3:"investimentos"}];
            double percent = _setSaldoReceita() * _listmetas[0][convertList[0][recContact["tipo de gastos"]]];
            double gastoTot = _setGastoTotal(recContact["tipo de gastos"]) + UtilBrasilFields.converterMoedaParaDouble(recContact["gastos valor"]);            
            // IF: A variavel 'percent' recebe o valor maximo suportado pelo tipo do gasto
            // Se o 'percente' for menor que o valor imputado ele não deixa salvar
            // Se false ele salva 
            if (percent >= gastoTot) {
              _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"].add(recContact);

              setState(() {
                _iforText = "";
              }); 
            } else {           
              setState(() {
                _iforText = "Aumente sua receita, sinal lotado!";
              });
            }
          }

        } else {
          setState(() {
            _listfinance[0]["carteira"].add({"$ano" : {"Janeiro" : [], "Fevereiro" : [], "Março" : [], "Abril" : [], "Maio" : [], "Junho" : [], "Julho" : [], "Agosto" : [], "Setembro" : [], "Outubro" : [], "Novembro" : [], "Dezembro" : []}});
          });
          
          if (recContact["receita valor"] != null) { 
            _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"].add(recContact);        
            setState(() {
              _iforText = "";
            });

          } else {
            List convertList = [{1:"gastos essenciais", 2:"gastos não essenciais", 3:"investimentos"}];
            double percent = _setSaldoReceita() * _listmetas[0][convertList[0][recContact["tipo de gastos"]]];
            double gastoTot = _setGastoTotal(recContact["tipo de gastos"]) + UtilBrasilFields.converterMoedaParaDouble(recContact["gastos valor"]);            
            // IF: A variavel 'percent' recebe o valor maximo suportado pelo tipo do gasto
            // Se o 'percente' for menor que o valor imputado ele não deixa salvar
            // Se false ele salva 
            if (percent >= gastoTot) {
              _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"].add(recContact);

              setState(() {
                _iforText = "";
              }); 
            } else {           
              setState(() {
                _iforText = "Aumente sua receita, sinal lotado!";
              });
            }
          }
        }
      } else {
        setState(() {
          _listfinance[0]["carteira"].add({"$ano" : {"Janeiro" : [], "Fevereiro" : [], "Março" : [], "Abril" : [], "Maio" : [], "Junho" : [], "Julho" : [], "Agosto" : [], "Setembro" : [], "Outubro" : [], "Novembro" : [], "Dezembro" : []}});
        });        
        if (recContact["receita valor"] != null) {

          _listfinance[0]["carteira"][0]["$ano"]["$mes"].add(recContact);     

          setState(() {
            _iforText = "";
          });

        } else {
          List convertList = [{1:"gastos essenciais", 2:"gastos não essenciais", 3:"investimentos"}];
          double percent = _setSaldoReceita() * _listmetas[0][convertList[0][recContact["tipo de gastos"]]];
          double gastoTot = _setGastoTotal(recContact["tipo de gastos"]) + UtilBrasilFields.converterMoedaParaDouble(recContact["gastos valor"]);            
          // IF: A variavel 'percent' recebe o valor maximo suportado pelo tipo do gasto
          // Se o 'percente' for menor que o valor imputado ele não deixa salvar
          // Se false ele salva 
          if (percent >= gastoTot) {
            _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"].add(recContact);

            setState(() {
              _iforText = "";
            }); 
          } else {           
            setState(() {
              _iforText = "Aumente sua receita, sinal lotado!";
            });
          }
        }
      }
      saveData(_listfinance[0]["carteira"], "testdb1");
    });      
  }

  setData() {
    if (_dateTime == "") {
      ano = DateTime
          .now()
          .year;
      final mesN = DateTime
          .now()
          .month;
      mes = _mes[0][mesN];
      _dateTime = "$mes / $ano";
      return _dateTime;
    } else {
      return _dateTime;
    }
  }

  double _setPercent(tipo) {
    if (_setCount() == 0) {
      setState(() {
        percent = 0.0;
      });
    } else if (_setCount() > 0) {
      double calcgastostipo = 0;
      double result = 0;

      if(_listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"] != null){
        for (l = 0; l < _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"].length; l++) {
          if (_listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"][l]["gastos valor"] !=
              null &&
              _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"][l]["tipo de gastos"] ==
                  tipo) {
            calcgastostipo = UtilBrasilFields.converterMoedaParaDouble(
                _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"][l]["gastos valor"] !=
                    null
                    ? _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"][l]["gastos valor"]
                    : "0") + calcgastostipo;
          }
        }

        setState(() {
          if (tipo == 1) {
            result = calcgastostipo /
                (_setSaldoReceita() * _listmetas[0]["gastos essenciais"]);
          } else if (tipo == 2) {
            result = calcgastostipo /
                (_setSaldoReceita() * _listmetas[0]["gastos não essenciais"]);
          } else {
            result = calcgastostipo /
                (_setSaldoReceita() * _listmetas[0]["investimentos"]);
          }
          percent = double.parse(result.toStringAsPrecision(2));
        });
      } else {
        percent = 0.0;
      }
    } else {
      percent = 0.0;
    }
    return percent;
  }

  _setGastoTotal(tipo){
    double calcgastostipo = 0;

    for (l = 0; l < _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"].length;l++) {
      if (_listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"][l]["gastos valor"] != null && _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"][l]["tipo de gastos"] == tipo) {
        calcgastostipo = UtilBrasilFields.converterMoedaParaDouble( _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"][l]["gastos valor"] != null ? _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"][l]["gastos valor"]: "0") + calcgastostipo;
      }
    }
    return calcgastostipo;
  }

  @override
  void initState() {
    super.initState();
    readData("testdb1").then((dynamic data) {
      setState(() {
        _listfinance[0]["carteira"] = json.decode(data);
      });
    });
    readData("nomed").then((dynamic data) {
      setState(() {
        _listname = json.decode(data);
      });
    });
    readData("metas").then((dynamic data) {
      setState(() {
        _listmetas[0] = json.decode(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGreyBlack,
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: AppColors.darkGreyBlack),
                currentAccountPicture: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      AppImages.logo,
                      scale: 25,
                    )),
                accountName: Text(_listname[0]["user"]),
                accountEmail: Text('Vamos investir!')),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Editar Nome'),
              subtitle: Text('Edite seu nome ou apelido'),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Editar Metas'),
              subtitle: Text('Definir % das metas'),
              onTap: () {
                if(_setSaldoTotGastos() > 0 || mes != _mes[0][DateTime.now().month]){
                  setState(() {
                    _iforText = "Para mudar as porcentagens das metas remova os gastos!";
                  });
                }else{
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PercentualWidget()));
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair'),
              subtitle: Text('Finalizar sessão'),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: GestureDetector(
          child: Text(setData()),
          onTap: () {
            showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2222),
                locale: Locale("pt", "BR"))
                .then((date) =>
            {
              setState(() {
                ano = date?.year != null ? date?.year : DateTime.now().year;
                final mesN = date?.month != null ? date?.month : DateTime.now().month;
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
            child: Text("SALDO", style: AppTextStyles.titleSaldo),
          ),
          Text(
            "R\$ " + _setSaldo().replaceAll('.', ','),
            style: AppTextStyles.valueSaldo,
          ),
          Center(
            child: FloatingActionButton(
              onPressed: () {
                _showSelectionPage();
              },
              tooltip: 'Adicionar',
              child: Icon(Icons.add),
              backgroundColor: AppColors.green,
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
                itemBuilder: (context, index) {
                  return _gastosCard(context, (_setCount()-1)-index);
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
                      percent: _setPercent(1),
                      varPercent:
                      (_listmetas[0]["gastos essenciais"] * 100).ceil(),
                      label: "vermelho",
                    )),
                Expanded(
                    flex: 2,
                    child: ChartWidget(
                      percent: _setPercent(2),
                      varPercent:
                      (_listmetas[0]["gastos não essenciais"] * 100).ceil(),
                      label: "amarelo",
                    )),
                Expanded(
                    flex: 2,
                    child: ChartWidget(
                      percent: _setPercent(3),
                      varPercent: (_listmetas[0]["investimentos"] * 100).ceil(),
                      label: "verde",
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _gastosCard(BuildContext context, int index) {
    return Dismissible(
      key: Key(DateTime
          .now()
          .millisecondsSinceEpoch
          .toString()),
      background: Container(
        color: AppColors.red,
        child: Align(
            alignment: Alignment(-0.9, 0.0),
            child: Icon(Icons.delete, color: Colors.white)),
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
                        child: Row(children: [
                          selectImage(index),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"]
                                  [index]["gastos descrição"] !=
                                      null
                                      ? _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"][index]["gastos descrição"]
                                      .toString()
                                      : _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"][index]
                                  ["receita descrição"] !=
                                      null
                                      ? _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"][index]
                                  ["receita descrição"]
                                      .toString()
                                      : "",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"]
                                  [index]["gastos data"] !=
                                      null
                                      ? _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"][index]["gastos data"]
                                      .toString()
                                      : _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"][index]["receita data"] !=
                                      null
                                      ? _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"][index]["receita data"]
                                      .toString()
                                      : "",
                                  style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                                ),
                              ],
                            ),
                          )
                        ])),
                    Container(
                      child: Text(
                        _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"][index]
                        ["gastos valor"] !=
                            null
                            ? _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"]
                        [index]["gastos valor"]
                            .toString()
                            : _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"]
                        [index]["receita valor"] !=
                            null
                            ? _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"][index]["receita valor"]
                            .toString()
                            : "",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    )
                  ]),
            )),
      ),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(_listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"][index]);
          _lastRemovedPos = index;          
          if(_lastRemoved["receita valor"] != null) {
            final rec =  _setSaldoReceita();
            final receitaTotal =  (rec) - (UtilBrasilFields.converterMoedaParaDouble(_lastRemoved["receita valor"]) != null ? UtilBrasilFields.converterMoedaParaDouble(_lastRemoved["receita valor"]) : UtilBrasilFields.converterMoedaParaDouble(_lastRemoved["gastos valor"]) != null ? UtilBrasilFields.converterMoedaParaDouble(_lastRemoved["gastos valor"]) : 0);
            final resp = (receitaTotal >= ((rec) * (_percentualpre())));         
            final result =  receitaTotal - _setSaldoTotGastos();
            
            if(result >= 0 && resp == true){
              setState(() {
                _iforText = "";
              });
               _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"].removeAt(index);

                saveData(_listfinance[0]["carteira"], "testdb1");

                final snack = SnackBar(
                  content: Text("Aplicação removida!"),
                  action: SnackBarAction(
                    label: "Desfazer",
                    onPressed: () {
                      setState(() {
                        _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"]
                            .insert(_lastRemovedPos, _lastRemoved);
                        saveData(_listfinance[0]["carteira"], "testdb1");
                      });
                    },
                  ),
                  duration: Duration(seconds: 5),
                );

                ScaffoldMessenger.of(context).showSnackBar(snack);        
            } else {
              setState(() {
                _iforText = "Ação não realizada, por favor exclua um gasto antes";
              });
            }
          } else {
            setState(() {
              _iforText = "";
            });

            _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"].removeAt(index);

            saveData(_listfinance[0]["carteira"], "testdb1");

            final snack = SnackBar(
              content: Text("Aplicação removida!"),
              action: SnackBarAction(
                label: "Desfazer",
                onPressed: () {
                  setState(() {
                    _listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"]
                        .insert(_lastRemovedPos, _lastRemoved);
                    saveData(_listfinance[0]["carteira"], "testdb1");
                  });
                },
              ),
              duration: Duration(seconds: 2),
            );

            ScaffoldMessenger.of(context).showSnackBar(snack);                     
          }
        });
      },
    );
  } 

  _percentualpre(){
    return (_setPercent(1) + _setPercent(2) + _setPercent(3) / 3); 
  }

  void _showSelectionPage() async {
    final recContact = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SelectionPage()));
    if (recContact != null) {
      _addList(recContact);
    }
  }

  Image selectImage(int index) {
    if (_listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"][index]
    ["receita descrição"] !=
        null) {
      return Image.asset(AppImages.arrow);
    } else if (_listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"][index]
    ["tipo de gastos"] ==
        1) {
      return Image.asset(AppImages.red);
    } else if (_listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"][index]
    ["tipo de gastos"] ==
        2) {
      return Image.asset(AppImages.yellow);
    } else if (_listfinance[0]["carteira"][_setIndiceAno()]["$ano"]["$mes"][index]
    ["tipo de gastos"] ==
        3) {
      return Image.asset(AppImages.green);
    }
    return Image.asset(AppImages.lock);
  }
}
