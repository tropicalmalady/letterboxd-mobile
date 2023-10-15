import 'package:flutter/material.dart';
import 'package:letterboxd/domain/models/_models.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';
import 'package:letterboxd/presentation/views/app/movie_details/view/data_section/cast.dart';
import 'package:letterboxd/presentation/views/app/movie_details/view/data_section/crew.dart';
import 'package:letterboxd/presentation/views/app/movie_details/view/data_section/details.dart';
import 'package:letterboxd/presentation/views/app/movie_details/view/data_section/genres.dart';
import 'package:letterboxd/presentation/views/app/movie_details/view/data_section/similar_films.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';
import 'package:letterboxd/presentation/widgets/button.dart';

class BuildMovieDetailsDataSection extends StatefulWidget {
  final MovieDetailsModel state;
  const BuildMovieDetailsDataSection({Key? key, required this.state})
      : super(key: key);

  @override
  State<BuildMovieDetailsDataSection> createState() =>
      _BuildMovieDetailsDataSectionState();
}

class _BuildMovieDetailsDataSectionState
    extends State<BuildMovieDetailsDataSection>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final Map<String, Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = {
      "Cast": BuildMovieDetailsCast(
        state: widget.state.credits,
      ),
      "Crew": BuildMovieDetailsCrew(state: widget.state.credits),
      "Details": const BuildMovieDetailsDetails(),
      "Genres":const BuildMovieDetailsGenres()
    };
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final double viewportHeight = MediaQuery.of(context).size.height;
    const double tabHeadingHeight = 34;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SpacingManager.md),
          child: Container(
            decoration: BoxDecoration(
                color: ColorManager.alternateColor4,
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            height: tabHeadingHeight,
            child: TabBar(
                onTap: (index) {
                  setState(() {});
                },
                controller: _tabController,
                overlayColor:
                    getIntrinsicButtonStyle(backgroundColor: Colors.transparent)
                        .backgroundColor,
                labelPadding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(),
                indicator: BoxDecoration(
                  color: ColorManager.primaryColor6,
                  borderRadius: BorderRadius.circular(12),
                ),
                labelColor: Colors.white,
                labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeightManager.bold,
                    ),
                unselectedLabelStyle:
                    Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeightManager.bold,
                        ),
                unselectedLabelColor: ColorManager.onPrimaryColor,
                tabs: List.generate(
                  _tabs.length,
                  (index) => Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: SpacingManager.xs),
                    child: Container(
                      decoration: BoxDecoration(
                          border: index == _tabs.length - 1 ||
                                  _tabController.index == index ||
                                  _tabController.index - 1 == index
                              ? null
                              : Border(
                                  right: BorderSide(
                                      color: ColorManager.primaryColor4,
                                      width: 1))),
                      child: Align(
                        alignment: Alignment.center,
                        child: Tab(
                          text: _tabs.entries.toList()[index].key,
                        ),
                      ),
                    ),
                  ),
                ).toList()),
          ),
        ),
        Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: SpacingManager.md),
                child: buildDivider()),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: AnimatedSwitcher(
                reverseDuration: const Duration(milliseconds: 900),
                layoutBuilder: (widget, list) =>
                    Stack(children: [widget!, ...list]),
                switchInCurve: Curves.easeInSine,
                switchOutCurve: Curves.easeOutSine,
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return animation.status == AnimationStatus.dismissed
                      ? SlideTransition(
                          position: Tween<Offset>(
                                  begin: const Offset(0, 1),
                                  end: const Offset(0, 0))
                              .animate(animation),
                          child:
                              FadeTransition(opacity: animation, child: child))
                      : SizeTransition(
                          sizeFactor: animation,
                          axis: Axis.vertical,
                          axisAlignment: 10,
                          child: child);
                },
                child: Container(
                  key: ValueKey(_tabController.index),
                  child: _tabs.entries.toList()[_tabController.index].value,
                ),
              ),
            ),
          ],
        ),
        const BuildMovieDetailsSimilarFilms()
      ],
    );
  }
}
