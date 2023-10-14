import 'dart:async';
import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';
import 'package:letterboxd/presentation/views/app/movie_details/view/intro_section/poster_hero.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';
import 'package:sliver_tools/sliver_tools.dart';

//life in loops
//the great love
//bonsoir
//kolp
//captain fracasse

class BuildMovieDetailsIntroSection extends StatefulWidget {
  final String? backdropPath;
  final String? posterPath;
  final String title;
  final String? originalTitle;
  final String? releaseDate;
  final int? runtime;
  final String? directorName;
  final String? tagLine;
  final String synopsis;
  final String? trailerLink;
  final Widget child;
  final bool isHeroWidget;
  final double initialScrollOffset;

  const BuildMovieDetailsIntroSection(
      {super.key,
      this.backdropPath,
      this.posterPath,
      required this.title,
      this.originalTitle,
      this.releaseDate,
      this.runtime,
      this.directorName,
      this.tagLine,
      required this.synopsis,
      this.trailerLink,
      required this.child,
      this.initialScrollOffset = 0,
      this.isHeroWidget = false});

  @override
  State<BuildMovieDetailsIntroSection> createState() => _BuildMovieDetailsIntroSectionState();
}

class _BuildMovieDetailsIntroSectionState extends State<BuildMovieDetailsIntroSection>
    with SingleTickerProviderStateMixin {
  final GlobalKey _myWidgetKey = GlobalKey();
  late ScrollController _scrollController;
  final StreamController<double> _opacityController =
      StreamController.broadcast();
  double _opacity = 0.0;
  late AnimationController _accordionAnimationController;
  late Animation<double> _accordionAnimation;
  late double _accordionOffset;

  void _animateAccordion() {
    if (_accordionAnimationController.status == AnimationStatus.completed) {
      _accordionAnimationController.reverse();
    } else {
      _accordionAnimationController.forward();
    }
  }

  void _updateOpacity(double opacity) {
    if (_opacity != opacity) {
      _opacity = opacity;
      _opacityController.sink.add(opacity);
    }
  }

  void _onScroll() {
    print(_scrollController.offset);
    double animationStartPosition = widget.backdropPath == null
        ? 0
        : (_scrollController.position.viewportDimension / 6.5);
    double animationEndPosition = widget.backdropPath == null
        ? (_scrollController.position.viewportDimension / 10)
        : (_scrollController.position.viewportDimension / 4.5);
    double scrollOffset = _scrollController.offset;

    double opacity = scrollOffset < animationStartPosition
        ? 0
        : scrollOffset > animationEndPosition
            ? 1
            : ((scrollOffset - animationStartPosition) /
                (animationEndPosition - animationStartPosition));

    _updateOpacity(opacity);
  }

  @override
  void initState() {
    super.initState();

    _accordionAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..addListener(() {
        setState(() {});
      });
    _accordionAnimation =
        Tween(begin: 1.0, end: 0.0).animate(_accordionAnimationController);

    _scrollController = ScrollController()..addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.initialScrollOffset > 0) {
        _scrollController.animateTo(widget.initialScrollOffset,
            duration: const Duration(milliseconds: 1), curve: Curves.linear);
      }
    });
  }

  @override
  void dispose() {
    _opacityController.close();
    _accordionAnimationController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _accordionOffset =
        (widget.synopsis.length / MediaQuery.of(context).size.width) * 130;

    final viewportHeight = MediaQuery.of(context).size.height;

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
                stretch: true,
                automaticallyImplyLeading: false,
                expandedHeight: widget.backdropPath == null
                    ? viewportHeight * 0.1
                    : viewportHeight * 0.3,
                flexibleSpace: widget.backdropPath == null
                    ? Container(color: ColorManager.primaryColor)
                    : FlexibleSpaceBar(
                        background: buildBackdropImage(
                            backdropPath: widget.backdropPath)),
              ),
              SliverToBoxAdapter(
                  child: buildGradientContainer(
                stops: [0.67, 0.8, 1],
                child: SizedBox(height: MediaQuery.of(context).size.height),
              )),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.only(
                        top: widget.backdropPath == null
                            ? (viewportHeight * 0.23)
                            : (viewportHeight * 0.43)),
                    child: Transform.translate(
                      offset: Offset(0, -viewportHeight * 0.1349),
                      child: Column(
                        children: [
                          _details(),
                          AnimatedBuilder(
                              animation: _accordionAnimationController,
                              builder: (context, child) {
                                return Transform.translate(
                                    offset: Offset(
                                        0,
                                        ((-_accordionOffset) *
                                                _accordionAnimation.value) +
                                            (viewportHeight * 0.0224) -
                                            ((1 - _accordionAnimation.value) *
                                                30)),
                                    child: child);
                              },
                              child: _buildSlidingContainer())
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            widget.isHeroWidget? buildEmptySliverContainer :SliverPersistentHeader(
                  pinned: true,
                  delegate: AppBarDelegate(
                      opacityStream: _opacityController.stream,
                      title: widget.title)),
            ],
          )
        ],
      ),
    );
  }

  Widget _details() {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(
            left: SpacingManager.md, right: SpacingManager.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: SpacingManager.xs, right: SpacingManager.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        StreamBuilder<double>(
                            stream: _opacityController.stream,
                            builder: (context, snapshot) {
                              return Opacity(
                                opacity: 1 - (snapshot.data ?? 0.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: SpacingManager.xs),
                                  child: Text(
                                    widget.title,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                              );
                            }),
                        widget.originalTitle == null
                            ? Container()
                            : Text(widget.originalTitle!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontStyle: FontStyle.italic)),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: SpacingManager.md,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              widget.releaseDate == null
                                  ? buildEmptyContainer
                                  : Text(widget.releaseDate!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                              widget.releaseDate == null ||
                                      widget.directorName == null
                                  ? buildEmptyContainer
                                  : Text(" • ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontSize: FontSizeManager.s20)),
                              widget.directorName == null
                                  ? buildEmptyContainer
                                  : Text("DIRECTED BY",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: SpacingManager.lg),
                          child: widget.directorName == null
                              ? buildEmptyContainer
                              : Text(
                                  widget.directorName!,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                        ),
                        Row(
                          children: [
                            widget.trailerLink == null
                                ? buildEmptyContainer
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        right: SpacingManager.md),
                                    child: _buildTrailerButton(),
                                  ),
                            widget.runtime == null
                                ? buildEmptyContainer
                                : Text("${widget.runtime} mins",
                                    style:
                                        Theme.of(context).textTheme.bodySmall)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                widget.isHeroWidget
                    ? buildEmptyContainer
                    : GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.movieDetailsPosterHeroRoute,
                              arguments: PosterHeroPageArguments(
                                  scrollOffset: _scrollController.offset,
                                  posterPath: widget.posterPath));
                        },
                        child: Hero(
                            tag: "poster_image",
                            child: buildPosterImage(
                                width: 100, posterPath: widget.posterPath)))
              ],
            ),
            const SizedBox(
              height: SpacingManager.md,
            ),
            widget.tagLine == null
                ? buildEmptyContainer
                : Text(
                    widget.tagLine!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(letterSpacing: 0.9),
                  ),
            GestureDetector(
              onTap: _animateAccordion,
              child: Padding(
                padding: const EdgeInsets.only(top: SpacingManager.sm),
                child: Text(
                  widget.synopsis,
                  key: _myWidgetKey,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTrailerButton() {
    return Builder(builder: (context) {
      return MaterialButton(
          color: ColorManager.primaryColor6,
          padding: const EdgeInsets.symmetric(
              horizontal: SpacingManager.xs + SpacingManager.lg),
          visualDensity: VisualDensity.compact,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          onPressed: () {},
          child:
              Text("▶ TRAILER", style: Theme.of(context).textTheme.bodySmall));
    });
  }

  Widget _buildSlidingContainer() {
    return Builder(builder: (context) {
      return Stack(
        children: [
          GestureDetector(
            onTapUp: (details) {
              if (details.localPosition.dy < 50) {
                _animateAccordion();
              }
            },
            child: buildGradientContainer(
                stops: [0.6, 0.62, 1],
                child: SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                        alignment: Alignment.center, child: buildDivider()))),
          ),
          Container(
            padding: const EdgeInsets.only(top: 80),
            child: Container(
              width: double.infinity,
              color: ColorManager.primaryColor,
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: (_accordionOffset - 200) > 0
                          ? _accordionOffset - 200
                          : _accordionOffset),
                  child: widget.child),
            ),
          ),
        ],
      );
    });
  }
}

class AppBarDelegate extends SliverPersistentHeaderDelegate {
  final Stream<double> _opacityStream;
  final String _title;

  AppBarDelegate({required Stream<double> opacityStream, required String title})
      : _opacityStream = opacityStream,
        _title = title;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return StreamBuilder<double>(
        stream: _opacityStream,
        builder: (context, snapshot) {
          return Stack(
            children: [
              Opacity(
                opacity: snapshot.data ?? 0.0,
                child: Container(
                  color: ColorManager.alternateColor4,
                  alignment: Alignment.center,
                ),
              ),
              SafeArea(
                bottom: false,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: SpacingManager.md),
                  child: Row(
                    children: [
                      Container(
                        decoration: _buildCircularBox(),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_sharp,
                              size: 20,
                            )),
                      ),
                      Expanded(
                        child: Opacity(
                          opacity: snapshot.data ?? 0.0,
                          child: Text(
                            _title,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(),
                          ),
                        ),
                      ),
                      Container(
                          decoration: _buildCircularBox(),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_horiz, size: 24)))
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }

  @override
  double get maxExtent => 90;

  @override
  double get minExtent => 90;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  BoxDecoration _buildCircularBox() => const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(0, 0, 0, 0.4),
      );
}
