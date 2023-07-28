import 'package:equatable/equatable.dart';

class MoviesPreviewModel extends Equatable {
  final int page;
  final List<MoviePreviewModel> results;
  final int totalPages;
  final int totalResults;

  const MoviesPreviewModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  MoviesPreviewModel.initial()
      : this(page: 1, totalResults: 0, totalPages: 0, results: []);

  MoviesPreviewModel copyWith({int? page, List<MoviePreviewModel>? results,int ? totalPages}) =>
      MoviesPreviewModel(
          page: page ?? this.page,
          results: results ?? this.results,
          totalPages: totalPages ?? this.totalPages,
          totalResults: totalResults);

  @override
  List<Object?> get props => [page, results,totalPages];
}

class MoviePreviewModel {
  final bool adult;
  final String? backdropPath;
  final List<String> genres;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String? releaseDate;
  final String title;
  final bool? video;
  final double voteAverage;
  final int voteCount;

  const MoviePreviewModel ({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  // @override
  // List<Object?> get props => [
  //       adult,
  //       backdropPath,
  //       genres,
  //       id,
  //       originalLanguage,
  //       originalTitle,
  //       overview,
  //       popularity,
  //       posterPath,
  //       releaseDate,
  //       title,
  //       video,
  //       voteAverage,
  //       voteCount
  //     ];
}
