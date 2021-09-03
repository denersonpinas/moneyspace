import 'package:flutter/material.dart';
import 'package:moneyspace/core/app_text_styles.dart';

class TextSpanWidget extends StatelessWidget {
  final String title;
  final String body;
  TextSpanWidget({
    Key? key, 
    required this.title, 
    required this.body,
  }) : super(key: key);

  TextSpanWidget.infor({ required String title, required String body})
    : this.body = body,
      this.title = title;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text.rich(
        TextSpan(
          text: "Tela de Input\n",
          style: AppTextStyles.titleBold,
          children: [
            TextSpan(
              text: "Para finalizar, quando quiser apagar algum input, basta arrastalo para a direita até o final. Caso faça sem querer ou desista da ação, irá aparecer uma mensagem na parte inferior da tela, basta clicar em 'DESFAZER' e seu input aparecerá novamente. OBS: Caso queira editar algum input, mesmo sendo algum que tenha feito no inicio do mês e queira mudar no final do mês, basta excluir e inputar novamente.",
              style: AppTextStyles.bodyBold
            )
          ]
        )
      ),
    );
  }
}