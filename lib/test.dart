import 'package:flutter/material.dart';

class AppTest extends StatelessWidget {
  const AppTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTest();
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
