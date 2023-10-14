import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';

Widget buildTitledListTiles(
    {required String title,
    required Map<String, VoidCallback?> items,
    bool isClickable = true}) {
  return Builder(builder: (context) {
    print("building");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(
                left: SpacingManager.md,
                bottom: SpacingManager.md,
                top: SpacingManager.xlg),
            child: Text(
              title.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall,
            )),
        buildDividerWithLeftPadding(),
        ...items.entries.map((item) =>
            buildButtonWithDivider(title: item.key, onPressed: item.value))
      ],
    );
  });
}
