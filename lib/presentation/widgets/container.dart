import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';

final buildEmptyContainer = Container();
const buildEmptySliverContainer = SliverToBoxAdapter();

class BuildAccordionContainer extends StatefulWidget {
  final double offset;
  final Color color;
  final double gradientPlaceholderHeight;
  final List<double> gradientStops;
  final Widget firstChild;
  final Widget secondChild;
  const BuildAccordionContainer({
    super.key,
    required this.firstChild,
    required this.secondChild,
    required this.color,
    this.offset = 150,
    this.gradientPlaceholderHeight = 50,
    this.gradientStops = const [0, 0.4, 1],
  });

  @override
  State<BuildAccordionContainer> createState() =>
      _BuildAccordionContainerState();
}

class _BuildAccordionContainerState extends State<BuildAccordionContainer> {
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

Widget buildGradientContainer(
    {required Widget child, required List<double> stops, Color? color}) {
  color ??= ColorManager.primaryColor;
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [color, color.withOpacity(0.7), color.withOpacity(0)],
            stops: stops)),
    child: child,
  );
}
