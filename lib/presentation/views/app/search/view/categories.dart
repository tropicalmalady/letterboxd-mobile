import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letterboxd/domain/models/_models.dart';
import 'package:letterboxd/presentation/managers/color_manager.dart';
import 'package:letterboxd/presentation/views/onboarding/view/onboarding.dart';
import 'package:letterboxd/presentation/widgets/button.dart';
import 'package:sticky_headers/sticky_headers.dart';

List<String> headings = ["Browse by", "Letterboxd.com"];

Map<String, List<ButtonModel>> headingsToButtons = {
  headings[0]: browseByButtons,
  headings[1]: siteButtons
};

List<ButtonModel> browseByButtons = [
  ButtonModel("Release date", () => const OnBoardingView()),
  ButtonModel("Genre, country or language", () => const OnBoardingView()),
  ButtonModel("Service", () => const OnBoardingView()),
  ButtonModel("Most popular", () => const OnBoardingView()),
  ButtonModel("Highest rated", () => const OnBoardingView()),
  ButtonModel("Most anticipated", () => const OnBoardingView()),
  ButtonModel("Top 250 narrative features", () => const OnBoardingView()),
  ButtonModel("List topic", () => const OnBoardingView()),
];

List<ButtonModel> siteButtons = [
  ButtonModel("Journal", () => Container()),
  ButtonModel("Podcast", () => Container()),
  ButtonModel("Showdown", () => Container()),
  ButtonModel("Year in Review", () => Container()),
  ButtonModel("About", () => Container()),
  ButtonModel("Social", () => Container()),
  ButtonModel("Gift Guide", () => Container()),
  ButtonModel("Merch", () => Container()),
  ButtonModel("Contact", () => Container())
];


@immutable
class BuildSearchCategories extends StatelessWidget {
  const BuildSearchCategories({
    Key? key,
    this.controller,
  }) : super(key: key);

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      primary: controller == null,
      controller: controller,
      itemCount: headings.length,
      itemBuilder: (context, outerIndex) {
        return StickyHeaderBuilder(
            overlapHeaders: true,
            controller: controller, // Optional
            builder: (BuildContext context, double stuckAmount) {
              return Container(
                  padding: const EdgeInsets.only(top: 40, left: 12),
                  color: ColorManager.primaryColor,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    headings[outerIndex],
                    style: Theme.of(context).textTheme.headlineLarge,
                  ));
            },
            content: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: headingsToButtons[headings[outerIndex]]?.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildArrowAnnexedButtonWithDivider(
                      title: headingsToButtons[headings[outerIndex]]![index]
                          .title, onPressed: () {
                        // Navigator.of(context).push(CupertinoPageRoute(
                        //     builder: (context) => Scaffold(body: browseByButtons[index].to())));
                      });
                },
              ),
            ));
      },
    );
  }
}
