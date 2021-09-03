import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String image;
  ImageWidget({
    Key? key, 
    required this.image, 
  }) : super(key: key);

  ImageWidget.img({required String image})
    : this.image = image;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 120, bottom: 12, right: 12, left: 12),
      child: 
      Image.asset(
        image
      )
    );
  }
}