import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';
import 'package:letterboxd/presentation/widgets/_widgets.dart';

class BuildPlayGround extends StatelessWidget {
  const BuildPlayGround({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: BuildApp());
  }
}

class BuildApp extends StatefulWidget {
  const BuildApp({Key? key}) : super(key: key);

  @override
  State<BuildApp> createState() => _BuildAppState();
}

class _BuildAppState extends State<BuildApp> {
  @override
  Widget build(BuildContext context) {
    return buildTitledListTiles(
        title: "Hey Gyp", items: {"one": () {}, "two": () {}});
  }


}
