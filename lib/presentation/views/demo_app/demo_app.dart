import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/views/onboarding/view/onboarding.dart';

class DemoAppView extends StatefulWidget {
  const DemoAppView({Key? key}) : super(key: key);

  @override
  State<DemoAppView> createState() => _DemoAppViewState();
}

class _DemoAppViewState extends State<DemoAppView> {
  var _currentIndex = 0;

  _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> pages = [
    const OnBoardingView(),
    const OnBoardingView(),
    const OnBoardingView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.amp_stories_rounded), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
        ],
      ),
    );
  }
}
