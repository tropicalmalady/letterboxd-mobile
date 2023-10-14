import 'package:flutter/material.dart';
import "package:letterboxd/presentation/widgets/_widgets.dart";
import 'package:letterboxd/presentation/managers/_managers.dart';
import 'package:letterboxd/presentation/managers/strings.dart';


List<Widget> pages = [
  _TourWidget(
      title: TourTitleStringManager.log, imageUrl: TourImageManager.log),
  _TourWidget(
      title: TourTitleStringManager.diary, imageUrl: TourImageManager.diary),
  _TourWidget(
      title: TourTitleStringManager.review, imageUrl: TourImageManager.review),
  _TourWidget(
      title: TourTitleStringManager.activity,
      imageUrl: TourImageManager.activity),
  _TourWidget(
      title: TourTitleStringManager.list, imageUrl: TourImageManager.list),
 const _TourEndWidget()
];

class OnBoardingTour extends StatefulWidget {
  const OnBoardingTour({Key? key}) : super(key: key);

  @override
  State<OnBoardingTour> createState() => _OnBoardingTourState();
}

class _OnBoardingTourState extends State<OnBoardingTour> {
  final PageController _pageController = PageController(initialPage: 0);
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, index) => pages[index],
        controller: _pageController,
        itemCount: pages.length,
        onPageChanged: (index) {
          setState(() {
            _activeIndex = index;
          });
        },
      ),
    );
  }
}

void _tourImageWidget(String imageUrl) =>
    Image.asset(imageUrl, fit: BoxFit.fitWidth);

class _TourWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  const _TourWidget({Key? key, required this.title, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    ColorManager.primaryColor7,
                    ColorManager.primaryColor
                  ],
                      stops: const [
                    0,
                    0.55
                  ])),
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.08, horizontal: size.width * 0.05),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 22, color: ColorManager.onPrimaryColor4),
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset(imageUrl, fit: BoxFit.fitWidth),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: size.height * 0.3,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.transparent,
                  ColorManager.primaryColor.withOpacity(0.7),
                  ColorManager.primaryColor
                ],
                    stops: const [
                  0,
                  0.6,
                  0.8
                ])),
          ),
        )
      ],
    );
  }
}

class _TourEndWidget extends StatelessWidget {
  const _TourEndWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SpacingManager.xlg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buildLetterboxdLogo(appWidth: size.width),
            const Text("The social network for film lovers"),
            const SizedBox(height: 32),
            buildTourButton(
                text: "Sign in", onPressed: () {}, hasBottomBorderRadius: false),
            buildDivider(color: ColorManager.primaryColor, thickness: 0.1),
            buildTourButton(
                text: "Create account",
                onPressed: () {},
                hasTopBorderRadius: false),
            const SizedBox(height: 16),
            buildTourButton(text: "Skip this step", onPressed: () {}),
            const SizedBox(
              height: 8,
            ),
            Text(
              "An account is not required to browse content, but you must have one to track films and participate",
              style:Theme.of(context).textTheme.bodySmall,textAlign: TextAlign.center,),
            const SizedBox(height: 40,)
          ],
        ),
      ),
    );
  }
}
