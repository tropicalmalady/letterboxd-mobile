import 'package:flutter/material.dart';
import 'package:letterboxd/app/utils/functions.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';

Widget buildButton({required VoidCallback onPressed, required Widget child}) {
  return SizedBox(
    width: double.infinity,
    child: OutlinedButton(
      style: getIntrinsicButtonStyle().copyWith(
        padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.zero),
        side: const MaterialStatePropertyAll<BorderSide>(BorderSide.none),
      ),
      onPressed: onPressed,
      child: Align(
        alignment: Alignment.centerLeft,
        child: child,
      ),
    ),
  );
}

Widget buildButtonWithTextChild(
    {required String title, required VoidCallback? onPressed, Widget? annex,Color? backgroundColor,Color? activeColor}) {
  return Builder(builder: (context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: getIntrinsicButtonStyle(backgroundColor: backgroundColor,activeColor: activeColor).copyWith(
                side:
                    const MaterialStatePropertyAll<BorderSide>(BorderSide.none),
                padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                  EdgeInsets.only(
                      top: SpacingManager.xxxs*18,
                      left: SpacingManager.md,
                      bottom: SpacingManager.xxxs*18,
                    right: annex==null ?SpacingManager.md : SpacingManager.xxxlg
                  ),
                ),
                textStyle: MaterialStatePropertyAll<TextStyle>(
                    Theme.of(context).textTheme.bodyMedium!)),
            onPressed: onPressed,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: SpacingManager.lg),
          child: Align(alignment: Alignment.centerRight, child: annex),
        )
      ],
    );
  });
}

Widget buildTileButton(
    {required String title,
    String? imagePath,
    required VoidCallback onPressed,
    required String subtitle}) {
  return Builder(builder: (context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: getIntrinsicButtonStyle().copyWith(
          side: const MaterialStatePropertyAll<BorderSide>(BorderSide.none),
          padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.only(left: SpacingManager.md),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: buildCreditsImage(imagePath: imagePath)),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, right: SpacingManager.md * 3),
                          child: Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4,
                              bottom: 8,
                              right: SpacingManager.md * 3),
                          child: Text(
                            subtitle,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: ColorManager.primaryColor6,
                                    fontSize: 15),
                          ),
                        ),
                        buildDivider()
                      ],
                    ),
                  ),
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(right: SpacingManager.md),
              child: Align(
                  alignment: Alignment.centerRight, child: buildArrowIcon()),
            )
          ],
        ));
  });
}

Widget buildButtonWithDivider(
    {required String title, VoidCallback? onPressed,Widget? annex}) {
  return Column(
    children: [
      buildButtonWithTextChild(
          title: title,
          annex: annex ?? (onPressed == null ? null : buildArrowIcon()),
          onPressed: onPressed),
      buildDividerWithLeftPadding(12)
    ],
  );
}

ButtonStyle getIntrinsicButtonStyle({
  Color? backgroundColor,
  Color? activeColor,
  Color? textColor,
}) {
  return ButtonStyle(
      visualDensity: VisualDensity.compact,
      backgroundColor: MaterialStateProperty.all<Color>(
          backgroundColor ?? ColorManager.primaryColor),
      foregroundColor: MaterialStateProperty.all<Color>(
          textColor ?? ColorManager.onPrimaryColor),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.pressed)) {
            return activeColor ?? ColorManager.primaryColor4;
          }
          return null; // Defer to the widget's default.
        },
      ));
}

Widget buildOutlinedButton(
    {required String text,
    required VoidCallback? onPressed,
    bool isVariant = false}) {
  return Builder(builder: (context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: getIntrinsicButtonStyle(
              activeColor: Colors.transparent,
              textColor: isVariant
                  ? ColorManager.onPrimaryColor4
                  : ColorManager.onPrimaryColor,
              backgroundColor:
                  isVariant ? ColorManager.accentColor : Colors.transparent)
          .copyWith(
              padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: 14, horizontal: 10)),
              visualDensity: VisualDensity.compact,
              side: MaterialStatePropertyAll<BorderSide>(isVariant
                  ? BorderSide.none
                  : BorderSide(
                      color: ColorManager.onPrimaryColor,
                      width: 1.0,
                    )),
              shape: MaterialStatePropertyAll<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              )),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isVariant
                ? ColorManager.onPrimaryColor5
                : ColorManager.onPrimaryColor),
      ),
    );
  });
}

Widget buildPasswordVisibilityToggleButton(
    {required bool isTextObscured, required VoidCallback onPressed}) {
  return buildOutlinedButton(
      text: isTextObscured ? "SHOW" : "HIDE", onPressed: onPressed);
}

Widget buildSignInActionButton(
    {required String text,
    required VoidCallback onPressed,
    bool isVariant = false}) {
  return Builder(builder: (context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: getIntrinsicButtonStyle(
              backgroundColor: isVariant
                  ? ColorManager.accentColor
                  : ColorManager.primaryColor6,
              textColor: isVariant
                  ? ColorManager.onPrimaryColor5
                  : ColorManager.onPrimaryColor3,
              activeColor: Colors.transparent)
          .copyWith(
        padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(vertical: 16, horizontal: 10)),
        shape: MaterialStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        side: const MaterialStatePropertyAll<BorderSide>(BorderSide.none),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isVariant
                ? ColorManager.onPrimaryColor5
                : ColorManager.onPrimaryColor2,
            fontWeight:
                isVariant ? FontWeightManager.bold : FontWeightManager.regular),
      ),
    );
  });
}

Widget buildTourButton(
    {required String text,
    required VoidCallback onPressed,
    hasTopBorderRadius = true,
    hasBottomBorderRadius = true}) {
  const radius = Radius.circular(5);
  const noRadius = Radius.zero;

  return OutlinedButton(
      onPressed: onPressed,
      style: getIntrinsicButtonStyle(
              backgroundColor: ColorManager.primaryColor5,
              textColor: ColorManager.onPrimaryColor3,
              activeColor: ColorManager.primaryColor7)
          .copyWith(
        padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(vertical: 24, horizontal: 10)),
        shape: MaterialStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: hasTopBorderRadius ? radius : noRadius,
                topLeft: hasTopBorderRadius ? radius : noRadius,
                bottomRight: hasBottomBorderRadius ? radius : noRadius,
                bottomLeft: hasBottomBorderRadius ? radius : noRadius),
          ),
        ),
        side: const MaterialStatePropertyAll<BorderSide>(BorderSide.none),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          text,
          style: TextStyle(fontSize: 18, color: ColorManager.onPrimaryColor4),
          textAlign: TextAlign.center,
        ),
      ));
}
