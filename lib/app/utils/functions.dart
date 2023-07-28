import 'dart:async';

import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:letterboxd/domain/models/form_element/form_element.dart';
import 'package:letterboxd/presentation/managers/managers.dart';

void showSnackBar(BuildContext context, String message) {
  context.showFlash<bool>(
      duration: const Duration(seconds: 4),
      builder: (context, controller) => FlashBar(
            controller: controller,
            backgroundColor: ColorManager.errorColor,
            position: FlashPosition.top,
            elevation: 0,
            content: Text(message, textAlign: TextAlign.center),
          ));
}

Container borderedContainer({required Widget child,Color? borderColor}) {
  return Container(
    padding: const EdgeInsets.all(0),
    decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color:borderColor ?? ColorManager.errorColor, width: 3)),
    child: child,
  );
}

int regulateLoopCounter(int currentCount, int maxCount) =>
    currentCount % maxCount;

class Debounce {
  final int milliseconds;
  Timer? _timer;
  Debounce({this.milliseconds = 1000});
  run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
