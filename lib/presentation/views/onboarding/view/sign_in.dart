import 'package:flutter/material.dart';
import 'package:letterboxd/app/utils/functions.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';

class SignInForm extends StatelessWidget {
  SignInForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameOrEmailController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                    buildHeadingLogo(context, text: "Sign in to Letterboxd"),
                    _signInFormFieldsWidget(),
                    _singInActionsWidget(context),
                    _footerDescriptionTextWidget(context,
                        text: "Guardians of the Galaxy")
                  ],
                ),
                stops: const [0.3, 0.4, 0.45]),
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
              showSnackBar(context, "CLICKED");
              Navigator.pop(context);
            }));
  }

  Widget _imageWidget(Size size) {
    return Image.asset(MovieBannerImageManger.swordOfDoom,
        fit: BoxFit.cover, height: size.height * 0.7);
  }

  Widget _footerDescriptionTextWidget(context, {required String text}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 40),
      child: buildArtworkDescriptionText(context, text: text),
    );
  }

  Widget _singInActionsWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: SpacingManager.lg),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        buildSignInActionButton(
            text: "JOIN",
            onPressed: () {
              showSnackBar(context, "CLICKED");
            }),
        const SizedBox(
          width: 16,
        ),
        buildSignInActionButton(text: "RESET PASSWORD", onPressed: () {}),
        const SizedBox(
          width: 32,
        ),
        buildSignInActionButton(text: "GO", onPressed: () {}, isVariant: true)
      ]),
    );
  }

  Widget _signInFormFieldsWidget() {
    return Builder(
      builder: (context) {
        return Container(
          color: ColorManager.alternateColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildDivider(color: ColorManager.onPrimaryColor),
              Padding(
                padding: const EdgeInsets.only(left: SpacingManager.lg),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameOrEmailController,
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration:
                          const InputDecoration(hintText: "Username or Email"),
                    ),
                    buildDivider(color: ColorManager.onPrimaryColor),
                    buildTextFormFieldWithAnnexedElement(
                        textFormField: TextFormField(
                          controller: _passwordController,
                          style: Theme.of(context).textTheme.bodyLarge,
                          decoration: const InputDecoration(hintText: "Password"),
                        ),
                        child: buildPasswordVisibilityToggleButton(
                            isTextObscured: true, onPressed: () {}))
                  ],
                ),
              ),
              buildDivider(color: ColorManager.onPrimaryColor),
            ],
          ),
        );
      }
    );
  }
}