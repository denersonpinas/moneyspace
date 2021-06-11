// import 'package:moneyspace/core/app_gradients.dart';
// import 'package:moneyspace/core/app_text_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:moneyspace/home/widget/score_card/score_card_widget.dart';

// class AppBarWidget extends PreferredSize {
  
//   AppBarWidget() : super(
//     preferredSize: Size.fromHeight(250),
//     child: Container(
//       height: 250,
//       child: Stack(
//         children: [
//           Container(
//             height: 161,
//             padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
//             width: double.maxFinite,
//             decoration: BoxDecoration(
//                 gradient: AppGradients.linear,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text.rich(TextSpan(
//                   text: "Olá, ",
//                   style: AppTextStyles.title,
//                   children: [
//                     TextSpan(
//                       text: "Denner",
//                       style: AppTextStyles.titleBold
//                     )
//                   ]
//                 )),
//               ],
//             ),
//           ),
//           Align(
//             alignment: Alignment(0.0, 1.0),
//             child: ScoreCardWidget(percent: 0.10/100,)
//           )
//         ],
//       ),
//     ),
//   );
  
// }