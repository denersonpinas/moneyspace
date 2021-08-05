import 'dart:convert';
import 'dart:core';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:moneyspace/admin/login_page.dart';
import 'package:moneyspace/core/app_text_styles.dart';
import 'package:moneyspace/home/widget/chart/chart_widget.dart';
import 'package:moneyspace/home/widget/print/alert_widget.dart';
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
  String _typeIforText = "";
  late double percent;

  String _dateTime = "";
  dynamic ano;
  dynamic mes;
  dynamic l;

  dynamic d = {};

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
  dynamic _listfinance = {"carteira":{}};
  List _listname = [
    {"user": "user"}
  ];
  List _listmetas = [
    {
      "metas mes" : {
        "Janeiro" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Fevereiro" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Março" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Abril" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Maio" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Junho" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Julho" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Agosto" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Setembro" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Outubro" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Novembro" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ], 
        "Dezembro" : [
          {
            "gastos essenciais": 0.6,
            "gastos não essenciais": 0.3,
            "investimentos": 0.1
          }
        ]
      }
    }    
  ];
  late Map<String, dynamic> _lastRemoved;
  late int _lastRemovedPos;
  late int indiceAno;
  late int indiceMes;

  _setCount() {
    int countList = _listfinance["carteira"].length;
    int countMesList;

    try {
      if (countList == 0) {
        return 0;
      } else if (_listfinance["carteira"]["$ano"] != null) {
        countMesList = _listfinance["carteira"]["$ano"]["$mes"].length;
        return countMesList;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }


  _setSaldo() {
    double calcgastosatual = 0.0;

    if(_listfinance["carteira"].length > 0){

      if(_listfinance["carteira"].length == 1 && _listfinance["carteira"]["$ano"] != null) {
        for (l = 0; l < _listfinance["carteira"]["$ano"]["$mes"].length;l++) {
          if (_listfinance["carteira"]["$ano"]["$mes"][l]["gastos valor"] != null) {
            calcgastosatual = UtilBrasilFields.converterMoedaParaDouble( _listfinance["carteira"]["$ano"]["$mes"][l]["gastos valor"] != null ? _listfinance["carteira"]["$ano"]["$mes"][l]["gastos valor"]: 0.0) + calcgastosatual;
          }
        }
      } else if(_listfinance["carteira"]["$ano"] != null) {
        for (l = 0; l < _listfinance["carteira"]["$ano"]["$mes"].length;l++) {
          if (_listfinance["carteira"]["$ano"]["$mes"][l]["gastos valor"] != null) {
            calcgastosatual = UtilBrasilFields.converterMoedaParaDouble( _listfinance["carteira"]["$ano"]["$mes"][l]["gastos valor"] != null ? _listfinance["carteira"]["$ano"]["$mes"][l]["gastos valor"]: 0.0) + calcgastosatual;
          }
        }
      }
      
    }

    NumberFormat formatter = NumberFormat("0.00");
    final resultado = _setSaldoReceita() - calcgastosatual;
    return formatter.format(resultado);
  }

  _setSaldoTotGastos() {
    double calcgastos = 0;

    if(_listfinance["carteira"].length > 0){
      for(l = 0; l < _listfinance["carteira"]["$ano"]["$mes"].length;l++){
        if (_listfinance["carteira"]["$ano"]["$mes"][l]["gastos valor"] != null) {
          calcgastos = UtilBrasilFields.converterMoedaParaDouble(_listfinance["carteira"]["$ano"]["$mes"][l]["gastos valor"] != null ? _listfinance["carteira"]["$ano"]["$mes"][l]["gastos valor"] : 0.0) + calcgastos;
        }
      }
    }

    return calcgastos;
  }

  _setSaldoReceita() {
    double calcgastospassado = 0.0;
    double calcreceitaspassado = 0.0;
    double calcreceitasatual = 0.0;       

    // Verificações:
    int qtdAno = _listfinance["carteira"].length;
    int initAno = 2021;
    int initMes = 1;
    if(qtdAno > 0) {
      int menosMes = _convertMes[0][mes] - 1 != 0 ? _convertMes[0][mes] - 1 : 12;
      bool verificAno = false;
      bool verificMes = false;
      while (verificAno == false || verificMes == false) {
        if(_listfinance["carteira"]["$initAno"] != null) {
          for (l = 0; l < _listfinance["carteira"]["$initAno"][_mes[0][initMes]].length;l++) {
            if (_listfinance["carteira"]["$initAno"][_mes[0][initMes]][l]["gastos valor"] != null) {
              calcgastospassado = UtilBrasilFields.converterMoedaParaDouble( _listfinance["carteira"]["$initAno"][_mes[0][initMes]][l]["gastos valor"] != null ? _listfinance["carteira"]["$initAno"][_mes[0][initMes]][l]["gastos valor"]: 0.0) + calcgastospassado;
              //print("Esse é o gasto do Mês $initMes do Ano $initAno:  $calcgastospassado");
            } else {
              calcreceitaspassado = UtilBrasilFields.converterMoedaParaDouble( _listfinance["carteira"]["$initAno"][_mes[0][initMes]][l]["receita valor"] != null ? _listfinance["carteira"]["$initAno"][_mes[0][initMes]][l]["receita valor"]: 0.0) + calcreceitaspassado; 
              //print("Esse é o receita do Mês $initMes do Ano $initAno:  $calcreceitaspassado");
            }
          }
        }
        //print("Estamos no ano $initAno no mês $initMes");
        //print("Meta é $initMes == $menosMes");  

        verificMes = false;
        verificAno = false;
        if (initMes == menosMes) {
          verificMes = true;
        } 
        if (initAno == ano) {
          verificAno = true;
        } 
        
        if(initMes != 12){
          initMes++;          
        } else {
          initMes = 1;
          initAno = initAno + 1;
        }        
      }

    }
    
    int idCarteira = _listfinance["carteira"].length;

    if(idCarteira == 1 && _listfinance["carteira"]["$ano"] != null){
      for (l = 0; l < _listfinance["carteira"]["$ano"]["$mes"].length;l++) {
        if (_listfinance["carteira"]["$ano"]["$mes"][l]["receita valor"] != null) {
          calcreceitasatual = UtilBrasilFields.converterMoedaParaDouble( _listfinance["carteira"]["$ano"]["$mes"][l]["receita valor"] != null ? _listfinance["carteira"]["$ano"]["$mes"][l]["receita valor"]: 0.0) + calcreceitasatual;
        }
      }
    } else if(_listfinance["carteira"]["$ano"] != null) {
      for (l = 0; l < _listfinance["carteira"]["$ano"]["$mes"].length;l++) {
        if (_listfinance["carteira"]["$ano"]["$mes"][l]["receita valor"] != null) {
          calcreceitasatual = UtilBrasilFields.converterMoedaParaDouble( _listfinance["carteira"]["$ano"]["$mes"][l]["receita valor"] != null ? _listfinance["carteira"]["$ano"]["$mes"][l]["receita valor"]: 0.0) + calcreceitasatual;
        }
      }
    }
    final totpassado = calcreceitaspassado - calcgastospassado;
    return totpassado + calcreceitasatual;
  }

  // Função adiciona 'Receitas' e 'Despesas' 
  // recebendo do selection_page pelo recContact e passando para o _listfinance
  _addList(recContact) {
    setState(() {
      if("$mes" == _mes[0][int.parse(recContact["mes"])]){
        if(_listfinance["carteira"].length > 0){
          if(_listfinance["carteira"]["$ano"] != null){
            print(_listfinance["carteira"]);
            if (recContact["receita valor"] != null) {
              _listfinance["carteira"]["$ano"]["$mes"].add(recContact);            
              setState(() {
                _iforText = "";
                _typeIforText = "";
              });

            } else {
              List convertList = [{1:"gastos essenciais", 2:"gastos não essenciais", 3:"investimentos"}];
              double percent = _setSaldoReceita() * _listmetas[0]["metas mes"]["$mes"][0][convertList[0][recContact["tipo de gastos"]]];
              double gastoTot = _setGastoTotal(recContact["tipo de gastos"]) + UtilBrasilFields.converterMoedaParaDouble(recContact["gastos valor"]);            
              // IF: A variavel 'percent' recebe o valor maximo suportado pelo tipo do gasto
              // Se o 'percente' for menor que o valor imputado ele não deixa salvar
              // Se false ele salva               
              if (percent >= gastoTot) {
                double a = percent - gastoTot;
                double limitPercent = double.parse((a / percent).toStringAsPrecision(2));
                if(limitPercent <= 0.2) {
                  setState(() {
                    _iforText = "Seu sinal atingiu 80%, fique atento e adiciono mais receitas.";
                    _typeIforText  = "!ATENÇÃO!\n";                 
                  });
                } else {
                  setState(() {
                    _iforText = "";
                    _typeIforText  = "";
                  }); 
                }
                _listfinance["carteira"]["$ano"]["$mes"].add(recContact);                
              } else {           
                setState(() {
                  _iforText = "Aumente sua receita, sinal lotado!";
                  _typeIforText = "!ALERT!\n";
                });
              }
            }

          } else {
            setState(() {
             _listfinance["carteira"]["${recContact["ano"]}"] = {"Janeiro" : [], "Fevereiro" : [], "Março" : [], "Abril" : [], "Maio" : [], "Junho" : [], "Julho" : [], "Agosto" : [], "Setembro" : [], "Outubro" : [], "Novembro" : [], "Dezembro" : []};
            });    

            if (recContact["receita valor"] != null) { 
              _listfinance["carteira"]["$ano"]["$mes"].add(recContact);        
              setState(() {
                _iforText = "";
                _typeIforText = "";
              });

            } else {
              List convertList = [{1:"gastos essenciais", 2:"gastos não essenciais", 3:"investimentos"}];
              double percent = _setSaldoReceita() * _listmetas[0]["metas mes"]["$mes"][convertList[0][recContact["tipo de gastos"]]];
              double gastoTot = _setGastoTotal(recContact["tipo de gastos"]) + UtilBrasilFields.converterMoedaParaDouble(recContact["gastos valor"]);            
              // IF: A variavel 'percent' recebe o valor maximo suportado pelo tipo do gasto
              // Se o 'percente' for menor que o valor imputado ele não deixa salvar
              // Se false ele salva 
              if (percent >= gastoTot) {
                double a = percent - gastoTot;
                double limitPercent = double.parse((a / percent).toStringAsPrecision(2));
                if(limitPercent <= 0.2) {
                  setState(() {
                    _iforText = "Seu sinal atingiu 80%, fique atento e adiciono mais receitas.";
                    _typeIforText  = "!ATENÇÃO!\n";                 
                  });
                } else {
                  setState(() {
                    _iforText = "";
                    _typeIforText  = "";
                  }); 
                }
                _listfinance["carteira"]["$ano"]["$mes"].add(recContact);
              } else {           
                setState(() {
                  _iforText = "Aumente sua receita, sinal lotado!";
                  _typeIforText = "!ALERT!\n";
                });
              }
            }
          }
        } else {
          setState(() {
            _listfinance["carteira"]["${recContact["ano"]}"] = {"Janeiro" : [], "Fevereiro" : [], "Março" : [], "Abril" : [], "Maio" : [], "Junho" : [], "Julho" : [], "Agosto" : [], "Setembro" : [], "Outubro" : [], "Novembro" : [], "Dezembro" : []};
          });      
          print(_listfinance["carteira"]);
          if (recContact["receita valor"] != null) {

            _listfinance["carteira"]["$ano"]["$mes"].add(recContact);     
            setState(() {
              _iforText = "";
              _typeIforText = "";
            });
          } else {
            setState(() {
              _iforText = "Por favor, insira uma receita!";
              _typeIforText = "!ALERT!\n";
            });
          }
        }
        saveData(_listfinance["carteira"], "testdb1");
      } else {
       setState(() {
         _iforText = "Ação não realizada, volte para o mês atual";
         _typeIforText = "!ALERT!\n";
       });
      }      
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

      if(_listfinance["carteira"]["$ano"]["$mes"] != null){
        for (l = 0; l < _listfinance["carteira"]["$ano"]["$mes"].length; l++) {
          if (_listfinance["carteira"]["$ano"]["$mes"][l]["gastos valor"] !=
              null &&
              _listfinance["carteira"]["$ano"]["$mes"][l]["tipo de gastos"] ==
                  tipo) {
            calcgastostipo = UtilBrasilFields.converterMoedaParaDouble(
                _listfinance["carteira"]["$ano"]["$mes"][l]["gastos valor"] !=
                    null
                    ? _listfinance["carteira"]["$ano"]["$mes"][l]["gastos valor"]
                    : "0") + calcgastostipo;
          }
        }

        setState(() {
          if (tipo == 1) {
            result = calcgastostipo /
                (_setSaldoReceita() * _listmetas[0]["metas mes"]["$mes"][0]["gastos essenciais"]);
          } else if (tipo == 2) {
            result = calcgastostipo /
                (_setSaldoReceita() * _listmetas[0]["metas mes"]["$mes"][0]["gastos não essenciais"]);
          } else {
            result = calcgastostipo /
                (_setSaldoReceita() * _listmetas[0]["metas mes"]["$mes"][0]["investimentos"]);
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

    for (l = 0; l < _listfinance["carteira"]["$ano"]["$mes"].length;l++) {
      if (_listfinance["carteira"]["$ano"]["$mes"][l]["gastos valor"] != null && _listfinance["carteira"]["$ano"]["$mes"][l]["tipo de gastos"] == tipo) {
        calcgastostipo = UtilBrasilFields.converterMoedaParaDouble( _listfinance["carteira"]["$ano"]["$mes"][l]["gastos valor"] != null ? _listfinance["carteira"]["$ano"]["$mes"][l]["gastos valor"]: 0.0) + calcgastostipo;
      }
    }

    return calcgastostipo;
  }

  @override
  void initState() {
    super.initState();
    readData("testdb1").then((dynamic data) {
      setState(() {
        _listfinance["carteira"] = json.decode(data);
      });
    });
    readData("nomed").then((dynamic data) {
      setState(() {
        _listname = json.decode(data);
      });
    });
    readData("metas1").then((dynamic data) {
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
                if(_setSaldoTotGastos() > 0  || mes != _mes[0][DateTime.now().month]){
                  setState(() {
                    _iforText = "Para mudar as porcentagens das metas remova os gastos!";
                    _typeIforText = "!ALERT!\n";
                  });
                }else{
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PercentualWidget(mes: mes,)));
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
                  return _gastosCard(context, index);
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(7)
            ),
            child: AlertWidget(inforText: _iforText, typeInforText: _typeIforText,)
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
                      (_listmetas[0]["metas mes"]["$mes"][0]["gastos essenciais"] * 100).ceil(),
                      label: "vermelho",
                    )),
                    Expanded(
                    flex: 2,
                    child: ChartWidget(
                      percent: _setPercent(2),
                      varPercent:
                      (_listmetas[0]["metas mes"]["$mes"][0]["gastos não essenciais"] * 100).ceil(),
                      label: "amarelo",
                    )),
                Expanded(
                    flex: 2,
                    child: ChartWidget(
                      percent: _setPercent(3),
                      varPercent: (_listmetas[0]["metas mes"]["$mes"][0]["investimentos"] * 100).ceil(),
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
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: AppColors.red,
        child: 
          Align(
            alignment: Alignment(-0.9, 0.0),
            child: Icon(Icons.delete, color: Colors.white)
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
                        child: Row(children: [
                          selectImage(index),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _listfinance["carteira"]["$ano"]["$mes"][index]["gastos descrição"] != null
                                    ? _listfinance["carteira"]["$ano"]["$mes"][index]["gastos descrição"].toString()
                                    : _listfinance["carteira"]["$ano"]["$mes"][index]["receita descrição"] != null
                                    ? _listfinance["carteira"]["$ano"]["$mes"][index]["receita descrição"].toString()
                                    : "",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  _listfinance["carteira"]["$ano"]["$mes"][index]["dia"] + "/"+ _listfinance["carteira"]["$ano"]["$mes"][index]["mes"] + "/" + _listfinance["carteira"]["$ano"]["$mes"][index]["ano"],
                                  style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                                ),
                              ],
                            ),
                          )
                        ])),
                    Container(
                      child: Text(
                        _listfinance["carteira"]["$ano"]["$mes"][index]["gastos valor"] != null
                          ? _listfinance["carteira"]["$ano"]["$mes"][index]["gastos valor"].toString()
                          : _listfinance["carteira"]["$ano"]["$mes"][index]["receita valor"] != null
                          ? _listfinance["carteira"]["$ano"]["$mes"][index]["receita valor"].toString()
                          : "",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    )
                  ]),
            )),
      ),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(_listfinance["carteira"]["$ano"]["$mes"][index]);
          _lastRemovedPos = index;
          dynamic anoOrigi = DateTime.now().year;
          dynamic mesOrigi = DateTime.now().month;

          final verific = ("$anoOrigi" == "$ano") && ("$mesOrigi" == _convertMes[0][mes].toString());
          print(verific);
          
          if(_lastRemoved["receita valor"] != null) {
            final rec =  _setSaldoReceita();
            final receitaTotal =  (rec) - (UtilBrasilFields.converterMoedaParaDouble(_lastRemoved["receita valor"]) != null ? UtilBrasilFields.converterMoedaParaDouble(_lastRemoved["receita valor"]) : UtilBrasilFields.converterMoedaParaDouble(_lastRemoved["gastos valor"]) != null ? UtilBrasilFields.converterMoedaParaDouble(_lastRemoved["gastos valor"]) : 0);
            final resp = (receitaTotal >= ((rec) * (_percentualpre())));         
            final result =  receitaTotal - _setSaldoTotGastos();
            
            if(result >= 0 && resp == true  && verific == true){
              setState(() {
                _iforText = "";
                _typeIforText = "";
              });
               _listfinance["carteira"]["$ano"]["$mes"].removeAt(index);

                saveData(_listfinance["carteira"], "testdb1");

                final snack = SnackBar(
                  content: Text("Aplicação removida!"),
                  action: SnackBarAction(
                    label: "Desfazer",
                    onPressed: () {
                      setState(() {
                        _listfinance["carteira"]["$ano"]["$mes"]
                            .insert(_lastRemovedPos, _lastRemoved);
                        saveData(_listfinance["carteira"], "testdb1");
                      });
                    },
                  ),
                  duration: Duration(seconds: 5),
                );

                ScaffoldMessenger.of(context).showSnackBar(snack);        
            } else {
              setState(() {
                _iforText = "Ação não realizada, por favor exclua um gasto antes";
                _typeIforText = "!ALERT!\n";
              });
            }
          } else if(verific == true){
            setState(() {
              _iforText = "";
              _typeIforText = "";
            });

            _listfinance["carteira"]["$ano"]["$mes"].removeAt(index);

            saveData(_listfinance["carteira"], "testdb1");

            final snack = SnackBar(
              content: Text("Aplicação removida!"),
              action: SnackBarAction(
                label: "Desfazer",
                onPressed: () {
                  setState(() {
                    _listfinance["carteira"]["$ano"]["$mes"]
                        .insert(_lastRemovedPos, _lastRemoved);
                    saveData(_listfinance["carteira"], "testdb1");
                  });
                },
              ),
              duration: Duration(seconds: 2),
            );

            ScaffoldMessenger.of(context).showSnackBar(snack);                     
          } else {
            setState(() {
              _iforText = "Por favor, volte para o mês atual.";
              _typeIforText = "!ALERT!\n";
            });
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
    if (_listfinance["carteira"]["$ano"]["$mes"][index]
    ["receita descrição"] !=
        null) {
      return Image.asset(AppImages.arrow);
    } else if (_listfinance["carteira"]["$ano"]["$mes"][index]
    ["tipo de gastos"] ==
        1) {
      return Image.asset(AppImages.red);
    } else if (_listfinance["carteira"]["$ano"]["$mes"][index]
    ["tipo de gastos"] ==
        2) {
      return Image.asset(AppImages.yellow);
    } else if (_listfinance["carteira"]["$ano"]["$mes"][index]
    ["tipo de gastos"] ==
        3) {
      return Image.asset(AppImages.green);
    }
    return Image.asset(AppImages.lock);
  }
}
