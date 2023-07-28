import 'dart:ui';

import 'package:flutter/material.dart';

class ButtonModel{
  String title;
  Widget Function() to;
  ButtonModel(this.title, this.to);
}