import 'package:flutter/material.dart';
import 'package:letterboxd/presentation/managers/managers.dart';
import 'package:letterboxd/presentation/views/app/search/view/appbar_searchbar.dart';

PreferredSize buildCustomAppBar(BuildContext context){
  return  PreferredSize(
    preferredSize: const Size.fromHeight(115),
    child: Container(
      padding: const EdgeInsets.only(top: 16),
      color: ColorManager.alternateColor4,
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Search",
                  style: Theme.of(context).textTheme.headlineLarge,
                )),
            const BuildAppBarSearchBar(),
          ],
        ),
      ),
    ),
  );
}