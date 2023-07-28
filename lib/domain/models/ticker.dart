class TickerModel {
  final int durationInMilliSeconds;
  const TickerModel({this.durationInMilliSeconds=1000});

  Stream<int> infiniteTick() async* {
    int i = 0;
    while (true) {
      yield i++;
      await Future.delayed(Duration(milliseconds: durationInMilliSeconds));
    }
  }


}
