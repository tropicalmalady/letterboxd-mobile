class TickerModel {
  final int _durationInMilliSeconds;
  late bool _shouldTick = true;
  TickerModel({int durationInMilliSeconds = 1000})
      : _durationInMilliSeconds = durationInMilliSeconds;

  Stream<int> infiniteTick() async* {
    int i = 0;
    while (_shouldTick) {
      yield i++;
      await Future.delayed(Duration(milliseconds: _durationInMilliSeconds));
    }
  }

  void stopTicker() {
    _shouldTick = false;
  }
}
