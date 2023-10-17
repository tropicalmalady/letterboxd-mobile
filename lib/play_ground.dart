import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterboxd/app/utils/functions.dart';
import 'package:letterboxd/domain/models/_models.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';
import 'package:letterboxd/presentation/views/app/movie_details/bloc/bloc.dart';
import 'package:letterboxd/presentation/views/app/search/bloc/state.dart';
import 'package:letterboxd/presentation/views/app/search/view/appbar_searchbar.dart';
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
    return Container();
  }
}

