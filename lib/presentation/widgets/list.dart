import 'package:flutter/material.dart';
import 'package:letterboxd/app/utils/functions.dart';
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

Widget buildFilmListCollection(
    {required String title,
      required VoidCallback onPressed,
      required Map<String, VoidCallback> items}) {
  return Builder(builder: (context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1,color: ColorManager.primaryColor5))
          ),
          child: buildButton(

            onPressed: onPressed,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: SpacingManager.md),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left:SpacingManager.md,
                            right: SpacingManager.md,
                            bottom: SpacingManager.xlg),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(title.toUpperCase(),
                                style: Theme.of(context).textTheme.labelSmall),
                            buildArrowIcon()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100 / 0.7)
              ],
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: SpacingManager.xlg),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: SpacingManager.md) ,
                child: Row(
                  children: items.entries.map((item) => Padding(
                    padding:
                    const EdgeInsets.only(right: SpacingManager.md),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: item.value,
                      child: buildPosterImage(width: 100,posterPath: item.key),
                    ),
                  )).toList(),
                ),
              ),
            ),
          ),
        )
      ],
    );
  });
}
