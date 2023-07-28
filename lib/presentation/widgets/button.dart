import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/managers/managers.dart';
import 'package:letterboxd/presentation/widgets/divider.dart';

Widget buildButton({required String title, required VoidCallback onPressed, Widget? annex}) {
  return Builder(
    builder: (context) {
      return Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: MaterialButton(
              onPressed: () {
                onPressed();
              },
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Align(alignment: Alignment.centerRight, child: annex),
          )
        ],
      );
    }
  );
}

Widget buildArrowAnnexedButtonWithDivider({required String title, required VoidCallback onPressed}) {
  return Column(
    children: [
      buildButton(title: title,
          annex: Icon(
            Icons.arrow_forward_ios,
            color: ColorManager.primaryColor7,
            size: 16,
          ),
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

Widget outlinedButtonWidget(
    {required String text,
    required VoidCallback onPressed,
    bool isVariant = false}) {
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
    child: Text(text),
  );
}

Widget passwordVisibilityToggleButtonWidget(
    {required bool isTextObscured, required VoidCallback onPressed}) {
  return outlinedButtonWidget(
      text: isTextObscured ? "SHOW" : "HIDE", onPressed: onPressed);
}

Widget signInActionButtonWidget(
    {required String text,
    required VoidCallback onPressed,
    bool isVariant = false}) {
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
      style: TextStyle(
          fontWeight:
              isVariant ? FontWeightManager.bold : FontWeightManager.regular),
    ),
  );
}

Widget tourButtonWidget(
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
