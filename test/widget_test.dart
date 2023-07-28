// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:letterboxd/app/utils/functions.dart';
import 'package:letterboxd/domain/models/carousel.dart';
import 'package:letterboxd/domain/models/ticker.dart';

import 'package:letterboxd/main.dart';

void main() {
  group("tests", () {
    late final CarouselMovieObjectModel objectOne;
    late final CarouselMovieObjectModel objectTwo;
    late final CarouselModel carouselOne;
    late final CarouselModel carouselTwo;
    late final TickerModel t;
    setUp((){
       objectOne=CarouselMovieObjectModel(movieImage: "", movieName: "");
       objectTwo=CarouselMovieObjectModel(movieImage: "", movieName: "");
       carouselOne=CarouselModel(data: [objectTwo,objectOne], currentIndex: 0);
       carouselTwo=CarouselModel(data: [objectOne,objectTwo], currentIndex: 0);
       t=const TickerModel(durationInSeconds: 1);


    });

    test("test for equality of movie object",(){
     // expect(objectOne, equals(objectTwo));
     expect(carouselOne, equals(carouselTwo));
    });

  });
}
