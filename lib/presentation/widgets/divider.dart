import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/managers/managers.dart';

Divider buildDivider({Color? color, double thickness = 1}) => Divider(
      color: color ?? ColorManager.primaryColor4,
      height: 0,
      thickness: thickness,
    );

Widget buildDividerWithLeftPadding([double padding=SizeManager.horizontalPadding]) => Padding(
      padding: EdgeInsets.only(left: padding),
      child: buildDivider(),
    );
