import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterboxd/app/utils/functions.dart';
import 'package:letterboxd/data/request/tmdb.dart';
import 'package:letterboxd/domain/repository/tmdb.dart';
import 'package:letterboxd/presentation/managers/color_manager.dart';
import 'package:letterboxd/presentation/managers/image_manager.dart';
import 'package:letterboxd/presentation/managers/managers.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';
import 'package:letterboxd/presentation/widgets/button.dart';
import 'package:letterboxd/presentation/widgets/divider.dart';
import 'package:letterboxd/presentation/widgets/image_poster.dart';
import 'package:sliver_tools/sliver_tools.dart';

class AppTest extends StatefulWidget {
  const AppTest({Key? key}) : super(key: key);

  @override
  State<AppTest> createState() => _AppTestState();
}

class _AppTestState extends State<AppTest> with SingleTickerProviderStateMixin {
  final GlobalKey _myWidgetKey = GlobalKey();
  late ScrollController _scrollController;
  final StreamController<double> _opacityController = StreamController();
  final StreamController<double> _heightController = StreamController();
  double _opacity = 0.0;
  double size=0;
  double value=0;

  void updateOpacity(double opacity) {
    if (_opacity != opacity) {
      _opacity = opacity;
      _opacityController.sink.add(opacity);
    }
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox renderBox =
      _myWidgetKey.currentContext!.findRenderObject() as RenderBox;
      setState(() {
        size = renderBox.size.height;
      });


      print('Widget size: $size');

      _heightController.sink.add(_scrollController.position.maxScrollExtent +
          MediaQuery.of(context).size.height * (1 - 0.68) -
          100);
    });
  }

  void _onScroll() {
    double animationStartPosition =
    (_scrollController.position.viewportDimension / 6.5);
    double animationEndPosition =
    (_scrollController.position.viewportDimension / 4.5);
    double scrollOffset = _scrollController.offset;

    double opacity = scrollOffset < animationStartPosition
        ? 0
        : scrollOffset > animationEndPosition
        ? 1
        : ((scrollOffset - animationStartPosition) /
        (animationEndPosition - animationStartPosition));

    updateOpacity(opacity);
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        slivers: [
          SliverStack(
            children: [
              SliverAppBar(
                centerTitle: true,
                pinned: true,
                stretch: true,
                automaticallyImplyLeading: false,
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    MovieBannerImageManger.apocalypseNow,
                    fit: BoxFit.cover,
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(-15),
                  child: Container(),
                ),
              ),
              SliverToBoxAdapter(
                  child: Container(
                      child: Container(
                        child: buildGradientContainer(
                          stops: [0.67, 0.72, 1],
                          child: SizedBox(height: MediaQuery.of(context).size.height),
                        ),
                      ))),
              SliverList(
                delegate: SliverChildListDelegate([
                  GestureDetector(
                    onTap: (){
                      print("fired");
                      setState(() {
                        value=value==0 ? size-30 :0;
                      });
                      // _accordionAnimationController.forward();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: (MediaQuery.of(context).size.height * 0.43)),
                      child: Container(child: detail()),
                    ),
                  )
                ]),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                    GestureDetector(
                        onTap: (){
                          print("fired");
                          setState(() {
                            value=value==0 ? size-30 :0;
                          });
                          // _accordionAnimationController.forward();
                        },
                        child: AnimatedPadding(
                            duration: Duration(milliseconds: 300),
                            padding: EdgeInsets.only(
                                top: (MediaQuery.of(context).size.height * 0.68) /(MediaQuery.of(context).size.width /400) + value),
                            child: buildSlidingContainer())
                    )

                  ])),
              SliverPersistentHeader(
                  pinned: true,
                  delegate: MyHeaderDelegate(_opacityController.stream)),
            ],
          )
        ],
      ),
    );
  }

  Widget buildSlidingContainer() {
    return Builder(builder: (context) {
      return Stack(
        children: [
          buildGradientContainer(
              stops: [0.6, 0.65, 1],
              child: Container(
                child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                        alignment: Alignment.center, child: buildDivider())),
              )),
          Container(
            child: Container(
              padding: EdgeInsets.only(top: 100),
              child: StreamBuilder<double>(
                  stream: _heightController.stream,
                  builder: (context, snapshot) {
                    return Container(
                      width: double.infinity,
                      color: ColorManager.primaryColor,
                      child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: snapshot.data ??
                                  MediaQuery.of(context).size.height *
                                      (1 - 0.68) -
                                      100),
                          child: Container(
                            child: Text("hey"),
                          )),
                    );
                  }),
            ),
          ),
        ],
      );
    });
  }

  Widget detail() {
    return Builder(builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
            left: SizeManager.horizontalPadding,
            right: SizeManager.horizontalPadding),
        child: Transform.translate(
          offset: const Offset(0, -90),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 4, right: SizeManager.horizontalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mission : Impossible - Dead Reckoning Part One",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(
                            height: SizeManager.horizontalPadding / 2,
                          ),
                          Text("Das Leben der Andersen",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontStyle: FontStyle.italic)),
                          const SizedBox(
                            height: SizeManager.horizontalPadding * 1.5,
                          ),
                          Text("2023 - DIRECTED BY",
                              style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(
                            height: SizeManager.horizontalPadding / 2,
                          ),
                          Text(
                            "Christopher McQuarrie",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeightManager.bold),
                          ),
                          const SizedBox(
                            height: SizeManager.horizontalPadding,
                          ),
                          Row(
                            children: [
                              buildTrailerButton(),
                              const SizedBox(
                                width: SizeManager.horizontalPadding,
                              ),
                              Text("164 mins",
                                  style: Theme.of(context).textTheme.bodySmall)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  buildPosterImage(
                      width: MediaQuery.of(context).size.width * 0.3,
                      posterPath: "/8RW2runSEc34IwKN2D1aPcJd2UL.jpg")
                ],
              ),
              const SizedBox(
                height: SizeManager.horizontalPadding,
              ),
              Text(
                "BEFORE THE FALL OF THE BERLIN WALL, EAST GERMANY'S SECRET POLICE LISTENED TO YOUR SECRETS",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: FontSizeManager.s14, letterSpacing: 1.1),
              ),
              const SizedBox(
                height: SizeManager.horizontalPadding * 0.6,
              ),
              Text(
                key: _myWidgetKey,
                "A tragic love story set in East Berlin with the backdrop of an undercover Stasi controlled culture. Stasi captain Wieler is ordered to follow author Dreyman and plunges deeper and deeper into his life until he reaches the threshold of doubting the system." *
                    2,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: FontSizeManager.s14),
              ),
            ],
          ),
        ),
      );
    });
  }
}

Widget buildTrailerButton() {
  return Builder(builder: (context) {
    return MaterialButton(
        color: ColorManager.primaryColor6,
        padding: const EdgeInsets.symmetric(horizontal: 22),
        visualDensity: VisualDensity.compact,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        onPressed: () {},
        child: Text("▶ TRAILER", style: Theme.of(context).textTheme.bodySmall));
  });
}

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Stream<double> _opacityStream;

  MyHeaderDelegate(this._opacityStream);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print("rebuilding");
    // Your custom header content goes here
    return StreamBuilder<double>(
        stream: _opacityStream,
        builder: (context, snapshot) {
          return Opacity(
            opacity: snapshot.data ?? 0.0,
            child: Container(
              child: Container(
                color: ColorManager.alternateColor4,
                alignment: Alignment.center,
                child: SafeArea(
                  bottom: false,
                  child: Text(
                    'Persistent Header',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  double get maxExtent => 90; // The maximum height of the header

  @override
  double get minExtent => 90; // The minimum height of the header

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true; // Set to true if your header content needs to be updated
  }
}
