import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';

class BuildAccordion extends StatefulWidget {
  final double offset;
  final Color color;
  final double gradientPlaceholderHeight;
  final List<double> gradientStops;
  final Widget firstChild;
  final Widget secondChild;
  const BuildAccordion({
    super.key,
    required this.firstChild,
    required this.secondChild,
    required this.color,
    this.offset = 150,
    this.gradientPlaceholderHeight = 50,
    this.gradientStops = const [0, 0.4, 1],
  });

  @override
  State<BuildAccordion> createState() => _BuildAccordionState();
}

class _BuildAccordionState extends State<BuildAccordion> {
  final GlobalKey _firstChildRef = GlobalKey();
  late final double _offset;
  late final Color _color;
  late final double _gradientPlaceholderHeight;
  late final List<double> _gradientStops;
  num _scrollTo = 0;
  bool _isToggled = false;

  void _toggleAccordion() {
    if (_scrollTo > _offset) {
      setState(() {
        _isToggled = !_isToggled;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _offset = widget.offset;
    _color = widget.color;
    _gradientPlaceholderHeight = widget.gradientPlaceholderHeight;
    _gradientStops = widget.gradientStops;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _scrollTo = _firstChildRef.currentContext?.size?.height ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceAppBarHeight =
        Scaffold.of(context).appBarMaxHeight?.toDouble() ?? 0;

    return Container(
      color: _color,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  key: _firstChildRef,
                  child: widget.firstChild,
                ),
                AnimatedPadding(
                    padding: EdgeInsets.only(
                        top: !_isToggled ? _offset : _scrollTo.toDouble()),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _toggleAccordion,
                          child: buildGradientContainer(
                            stops: _gradientStops,
                            color: _color,
                            child: Container(
                              height: _gradientPlaceholderHeight,
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: _scrollTo <
                                      deviceHeight -
                                          _offset -
                                          deviceAppBarHeight -
                                          _gradientPlaceholderHeight
                                  ? deviceHeight -
                                      _offset -
                                      deviceAppBarHeight -
                                      _gradientPlaceholderHeight
                                  : _offset +
                                      _scrollTo -
                                      _gradientPlaceholderHeight),
                          child: Container(
                            color: _color,
                            child: widget.secondChild,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildUserDetailsAccordion(
    {String? posterPath, String? bio = "", Widget? child}) {
  return BuildAccordion(
    color: ColorManager.primaryColor4,
    firstChild: Padding(
      padding: const EdgeInsets.only(
          left: SpacingManager.md,
          right: SpacingManager.md,
          top: SpacingManager.xlg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildPosterImage(width: 100, posterPath: posterPath),
          const SizedBox(
            width: SpacingManager.md,
          ),
          Expanded(
            child: Text(bio!),
          )
        ],
      ),
    ),
    offset: (100 / 0.67) + SpacingManager.xlg,
    secondChild: Column(
      children: [
        buildDivider(color: ColorManager.primaryColor5, thickness: 0.3),
        child ?? buildEmptyContainer
      ],
    ),
  );
}
