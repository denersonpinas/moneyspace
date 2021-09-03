import 'package:flutter/material.dart';
import 'package:moneyspace/core/app_colors.dart';
import 'package:moneyspace/core/app_images.dart';
import 'package:moneyspace/core/app_text_styles.dart';
import 'package:moneyspace/home/home.dart';
import 'package:moneyspace/sobre/text_span/text_span_widget.dart';

import 'image/image_widget.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGreyBlack,
      appBar: AppBar(
        title: Center(child: Text("Sobre")),
        backgroundColor: AppColors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home()
                  )
                );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text('Tutorial', style: AppTextStyles.titleSaldo),
            )),
            ImageWidget.img(image: AppImages.passo_01),
            TextSpanWidget.infor(title: 'Tela de Login \n', body: "Na tela que se abre, digite seu nome e aperte em 'ENTRAR'"),

            ImageWidget.img(image: AppImages.passo_02),
            TextSpanWidget.infor(title: 'Tela Inicial\n', body: "1) Nesta tela temos o 'MENU' situado no canto superior esquerdo, ao clicar nele temos quatro opções: a que você já conhece o sobre, editar perfil, editar orçamento e sair. Vamos destrinchar cada uma delas abaixo."),

            ImageWidget.img(image: AppImages.passo_06),
            TextSpanWidget.infor(title: '', body: "1) Ainda no menu, temos a primeira opção 'EDITAR PERFIL', ao clicar nela conseguirá alterar o nome de exibição.\n2) Logo abaixo temos o 'EDITAR ORÇAMENTO', aqui poderá alterar o orçamento dividido entre: essencial, não essencial e investimento."),

            ImageWidget.img(image: AppImages.passo_08),
            TextSpanWidget.infor(title: 'Tela Orçamento\n', body: "Como foi dito logo acima, aqui você poderá alterar a forma que sua receita será dividida, entre as opções de essencial, não essencial e investimento. *Uma observação importante, a soma entre as porcentagens sempre tem que ser 100*"),

            ImageWidget.img(image: AppImages.passo),
            TextSpanWidget.infor(title: 'Antes\n', body: ""),

            ImageWidget.img(image: AppImages.passo_05), 
            TextSpanWidget.infor(title: 'Depois\n', body: "Voltando na tela inicial é possível ver no centro inferior logo abaixo dos sinais os valores definidos na tela anterior."), 

            ImageWidget.img(image: AppImages.passo_03),
            TextSpanWidget.infor(title: 'Tela Inicial\n', body: "2) Aqui poderá clicar e navegar entre os meses e anos, consultar gastos e investimentos anteriores. Lembrando o app está em sua versão inicial, não podendo apagar valores anteriores, então aconselhamos que verifique sempre se algo está correto antes que troque de mês."),

            ImageWidget.img(image: AppImages.passo_04),
            TextSpanWidget.infor(title: 'Tela Inicial\n', body: "3) Botão de 'ADD'(Adicionar), nele é possível clicar e será redirecionado a tela para imputar os gastos e receitas do seu mês."),

            ImageWidget.img(image: AppImages.passo_12),
            TextSpanWidget.infor(title: "Tela de Input\n", body: "Aqui você tem dois botões 'RECEITA' e 'DESPESA', por default o botão receita já vem selecionado, é necessário selecionar um deles para poder imputar seus tipos correspondentes. Após preenchimento dos campos, basta clicar em 'ADICIONAR' e pronto!"),

            ImageWidget.img(image: AppImages.passo_10b),
            TextSpanWidget.infor(title: "Tela de Input\n", body: "Você irá observar que ao clicar em 'DESPESA', aparecerá um campo a mais, neste campo você pode selecionar o tipo de despesa que queira preencher, ou seja, essencial, não essencial e investimento."),

            ImageWidget.img(image: AppImages.passo_13),
            TextSpanWidget.infor(title: "Tela Inicial\n", body: "Pronto após imputar sua primeira receita, notará que na tela inicial, irá aparecer um histórico, de todos os seus inputs mensais."),

            ImageWidget.img(image: AppImages.passo_14),
            TextSpanWidget.infor(title: "Tela Inicial\n", body: "Pronto agora adicionamos também uma despesa. Note que ao adicionar uma despesa uma mensagem de aviso apareceu e que o sinal amarelo também mudou de 0% ele foi para 92%, isso ocorreu por que setamos que 50% da nossa receita iria para o sinal de gastos essenciais então R\$\700,00 equivale a 92% de R\$\1.500. A mensagem sempre irá aparecer quando 80% do sinal foi atingido, ela serve de um breve aviso."),

            ImageWidget.img(image: AppImages.passo_15),
            TextSpanWidget.infor(title: "Tela Inicial\n", body: "Para finalizar, quando quiser apagar algum input, basta arrastá-lo para a direita até o final. Caso faça sem querer ou desista da ação, irá aparecer uma mensagem na parte inferior da tela, basta clicar em 'DESFAZER' e seu input aparecerá novamente. OBS: caso queira editar algum input, mesmo sendo algum que tenha feito no início do mês e queira mudar no final do mês, basta excluir e imputar novamente."),            
          ],
        ),
      ),
    );
  }
}