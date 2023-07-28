import 'package:flutter/material.dart';
import 'package:letterboxd/app/utils/functions.dart';
import 'package:letterboxd/presentation/managers/managers.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';

class ResetPasswordForm extends StatelessWidget {
  ResetPasswordForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        _imageWidget(size),
        _closeModelWidget(context),
        Align(
          alignment: Alignment.bottomCenter,
          child: Form(
            key: _formKey,
            child: buildGradientContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    headingLogoWidget(context, text: "Reset Password"),
                    _signInFormFieldsWidget(),
                    _singInActionsWidget(context),
                    _footerDescriptionTextWidget(context,
                        text: "Guardians of the Galaxy")
                  ],
                ),
                stops: const [0.2, 0.3, 0.45]),
          ),
        ),
      ],
    );
  }

  Widget _closeModelWidget(BuildContext context) {
    return Positioned(
        top: 10,
        right: 10,
        child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              print("dd");
              showSnackBar(context, "CLICKED");
              Navigator.pop(context);
            }));
  }

  Widget _imageWidget(Size size) {
    return Image.asset(MovieBannerImageManger.roma,
        fit: BoxFit.cover, height: size.height * 0.8);
  }

  Widget _footerDescriptionTextWidget(context, {required String text}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 40),
      child: artworkDescriptionTextWidget(context, text: text),
    );
  }

  Widget _singInActionsWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        outlinedButtonWidget(
            text: "SIGN IN",
            onPressed: () {
              showSnackBar(context, "CLICKED");
            }),
        const SizedBox(
          width: 16,
        ),
        outlinedButtonWidget(text: "JOIN", onPressed: () {}),
        const SizedBox(
          width: 32,
        ),
        outlinedButtonWidget(text: "GO", onPressed: () {}, isVariant: true)
      ]),
    );
  }

  Widget _signInFormFieldsWidget() {
    return Container(
      color: ColorManager.alternateColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildDivider(color: ColorManager.onPrimaryColor),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.phone,
              style: TextStyle(color: ColorManager.primaryColor5),
              decoration: const InputDecoration(hintText: "Email address"),
            ),
          ),
          buildDivider(color: ColorManager.onPrimaryColor),
        ],
      ),
    );
  }
}
