// import 'package:moneyspace/core/app_colors.dart';
// import 'package:moneyspace/core/app_text_styles.dart';
// import 'package:moneyspace/shared/widgets/comfirmed_button/confirmed_button_widget.dart';
// import 'package:moneyspace/shared/widgets/text_field/text_field_widget.dart';
// import 'package:flutter/material.dart';

// class LoginPage extends StatelessWidget {

//   final _nameController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.darkGreyBlack,
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 34),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(            
//               child: Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: Text(
//                       "Digite seu(a) usuario!",
//                       style: 
//                       AppTextStyles.title,
//                     )
//                   ),
//                 ]
//               )
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               child: Column(
//                 children: [
//                   TextFieldWidget(
//                     label: "Nome ou Apelido",
//                     nameController: _nameController,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [                
//                 Expanded(child: ConfirmedButtonWidget.green(label: "Entrar")),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }