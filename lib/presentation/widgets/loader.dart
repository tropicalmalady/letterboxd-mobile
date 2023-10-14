import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:letterboxd/domain/models/ticker.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';

Widget buildFullscreenLoader() =>
    Center(child: BuildLoader(withBackdrop: false));

class BuildLoader extends StatefulWidget {
  final Color _frontColor;
  final Color _rearColor;
  final double _fraction;
  final bool _withBackdrop;

  BuildLoader({Key? key, frontColor, rearColor, fraction, withBackdrop})
      : _frontColor = frontColor ?? ColorManager.errorColor,
        _rearColor = rearColor ?? ColorManager.accentColor,
        _fraction = fraction ?? 1,
        _withBackdrop = withBackdrop ?? true,
        super(key: key);

  @override
  State<BuildLoader> createState() => _BuildLoaderState();
}

class _BuildLoaderState extends State<BuildLoader> {
  late bool _showFrontSide;
  TickerModel ticker = TickerModel(durationInMilliSeconds: 700);
  late final StreamSubscription<int> subscription;

  @override
  void initState() {
    super.initState();
    _showFrontSide = true;
    subscription = ticker.infiniteTick().listen((event) {
      setState(() {
        _showFrontSide = !_showFrontSide;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: !widget._withBackdrop
          ? _flipAnimationWidget()
          : Container(
              width: 125,
              height: 115,
              decoration: BoxDecoration(
                  color: ColorManager.alternateColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Center(child: _flipAnimationWidget())),
    );
  }

  Widget _flipAnimationWidget() {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: _transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
        child: _showFrontSide
            ? _loaderCircleWidget(
                key: const ValueKey(true), color: widget._frontColor)
            : _loaderCircleWidget(
                key: const ValueKey(false), color: widget._rearColor));
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget?.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: (Matrix4.rotationY(value)..setEntry(3, 0, tilt)),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  Widget _loaderCircleWidget({required Key key, required Color color}) {
    return Container(
      width: 50 * widget._fraction,
      height: 50 * widget._fraction,
      key: key,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
