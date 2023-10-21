import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letterboxd/app/utils/functions.dart';
import 'package:letterboxd/presentation/managers/_managers.dart';
import 'package:letterboxd/presentation/views/app/search/bloc/bloc.dart';
import 'package:letterboxd/presentation/views/app/search/bloc/event.dart';
import 'package:letterboxd/presentation/views/app/search/bloc/state.dart';

const curve = Curves.easeInOut;
const animationDuration = Duration(milliseconds: 300);
const List<String> searchParameters = [
  "Films",
  "Reviews",
  "Lists",
  "Cast,Crew or Studios",
  "Members or HQs",
  "Stories",
  "Journal article",
  "Podcast episodes",
  "All"
];

class BuildAppBarSearchBar extends StatefulWidget {
  const BuildAppBarSearchBar({Key? key}) : super(key: key);

  @override
  State<BuildAppBarSearchBar> createState() => _BuildAppBarSearchBarState();
}

class _BuildAppBarSearchBarState extends State<BuildAppBarSearchBar>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<Offset> _verticalTransitionAnimation;
  late Animation<num> _horizontalTransitionAnimation;
  bool _searchBarHasFocus = false;
  String _currentSearchParameter = searchParameters.elementAt(0);
  bool _hasText = false;
  final debounce = Debounce(milliseconds: 700);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: animationDuration)
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.forward) {
          _searchBarHasFocus = true;
        }
        if (status == AnimationStatus.reverse) {
          _searchBarHasFocus = false;
          _searchController.clear();
          FocusScope.of(context).requestFocus(FocusNode());
        }
      })
      ..addListener(() {
        setState(() {});

        _searchController.addListener(() {
          if (_searchController.text.isEmpty) {
            context.read<SearchBloc>().add(SearchReset());
          } else {
            debounce.run(() {
              context
                  .read<SearchBloc>()
                  .add(SearchQueryChanged(_searchController.text));
            });
          }
        });
      });

    _verticalTransitionAnimation = Tween<Offset>(
      begin: const Offset(0, 27),
      end: const Offset(0, -7),
    ).animate(CurvedAnimation(parent: _animationController, curve: curve));
    _horizontalTransitionAnimation = Tween(begin: 1, end: 0.8)
        .animate(CurvedAnimation(parent: _animationController, curve: curve));

    _searchController.addListener(() {
      setState(() {
        if (_searchController.text.isNotEmpty) {
          _hasText = true;
        } else {
          _hasText = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: OverflowBox(
        maxHeight: double.infinity,
        child: AnimatedBuilder(
            animation: _animationController,
            child: Column(
              children: [
                Column(mainAxisSize: MainAxisSize.min, children: [
                  Flexible(
                    child: SizedBox(
                      height: 55,
                      child: OverflowBox(
                        maxWidth: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AnimatedBuilder(
                                animation: _animationController,
                                child: _buildSearchInputField(),
                                builder: (context, child) {
                                  return SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          _horizontalTransitionAnimation.value,
                                      child: child);
                                }),
                            _buildSearchCancelButton(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(child: _buildSearchOptions()),
                ]),
              ],
            ),
            builder: (context, child) {
              return Transform.translate(
                offset: _verticalTransitionAnimation.value,
                child: Container(color: Colors.transparent, child: child),
              );
            }),
      ),
    );
  }

  Widget _buildSearchInputField() {
    final cursorColor = _searchBarHasFocus
        ? ColorManager.onPrimaryColor
        : ColorManager.onPrimaryColor4;
    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus && _searchController.text.isEmpty) {
          _animationController.forward();
          context
              .read<SearchBloc>()
              .add(SearchContentChanged(SearchContent.recentSearches));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SpacingManager.lg),
        child: TextFormField(
          cursorColor: cursorColor,
          controller: _searchController,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: ColorManager.primaryColor4),
          decoration: InputDecoration(
              enabledBorder: border,
              focusedBorder: border,
              hintText: "Find films, reviews, lists, people...",
              hintStyle: Theme.of(context)
                  .inputDecorationTheme
                  .hintStyle
                  ?.copyWith(color: cursorColor, fontSize: FontSizeManager.s14),
              prefixIcon: Icon(
                Icons.search,
                size: 24,
                color: cursorColor,
              ),
              suffixIcon: _hasText
                  ? IconButton(
                      constraints: const BoxConstraints(),
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.cancel_rounded,
                          size: 24, color: cursorColor),
                      onPressed: () {
                        _searchController.clear();
                      },
                    )
                  : null,
              suffixIconConstraints: BoxConstraints.tight(const Size(34, 24)),
              prefixIconConstraints: BoxConstraints.tight(const Size(34, 24)),
              fillColor: _searchBarHasFocus
                  ? ColorManager.onPrimaryColor5
                  : ColorManager.primaryColor9,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                  vertical: SpacingManager.md, horizontal: SpacingManager.sm)),
        ),
      ),
    );
  }

  Widget _buildSearchCancelButton() {
    return TextButton(
        onPressed: () {
          _animationController.reverse();
          context
              .read<SearchBloc>()
              .add(SearchContentChanged(SearchContent.categories));
        },
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: Text(
          "Cancel",
          style: Theme.of(context).textTheme.bodyLarge,
        ));
  }

  Widget _buildSearchOptions() {
    return Padding(
      padding: const EdgeInsets.only(top: SpacingManager.xs),
      child: SizedBox(
        height: 32,
        child: ListView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: SpacingManager.lg),
          children: searchParameters
              .map((item) => Padding(
                    padding: const EdgeInsets.only(right: SpacingManager.lg),
                    child: _buildSearchOption(
                        text: item,
                        isActive: _searchBarHasFocus &&
                            (_currentSearchParameter == item),
                        onPressed: () {
                          setState(() {
                            _currentSearchParameter = item;
                          });
                        }),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildSearchOption(
      {bool isActive = false, VoidCallback? onPressed, required String text}) {
    return GestureDetector(
      onTapUp: (details) {
        onPressed?.call();
        const curve = Curves.linear;
        final offset = _scrollController.offset;
        final listWidth = _scrollController.position.maxScrollExtent;
        final phoneWidth = MediaQuery.of(context).size.width;
        final widgetWidth = 10 * _currentSearchParameter.length;
        final widgetHorizontalGlobalPosition = details.globalPosition.dx;
        final widgetHorizontalLocalPosition = details.localPosition.dx;

        if (_scrollController.offset > 0 &&
            widgetHorizontalLocalPosition > widgetHorizontalGlobalPosition) {
          _scrollController.animateTo(-widgetWidth + _scrollController.offset,
              duration: animationDuration, curve: curve);
        }

        if (phoneWidth <
                widgetHorizontalGlobalPosition +
                    (widgetWidth - widgetHorizontalLocalPosition) &&
            (offset < listWidth)) {
          _scrollController.animateTo(widgetWidth + _scrollController.offset,
              duration: animationDuration, curve: curve);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: isActive ? ColorManager.accentColor1 : Colors.transparent),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 0, horizontal: SpacingManager.md),
          child: Align(
            alignment: Alignment.center,
            child: Text(text,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: isActive
                          ? ColorManager.onPrimaryColor5
                          : ColorManager.onPrimaryColor,
                    )),
          ),
        ),
      ),
    );
  }
}

OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(width: 0));
