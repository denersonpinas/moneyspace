import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AppGradients {
  static final linear = LinearGradient(colors: [
    Color(0xFF2DCE8A),
    Color.fromRGBO(48, 219, 148, 86),
  ], stops: [
    0.0,
    0.695
  ], transform: GradientRotation(2.13959913 * pi));
}
