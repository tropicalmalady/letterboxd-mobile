import 'package:json_annotation/json_annotation.dart';
import 'package:letterboxd/data/response/_base.dart';
import 'package:letterboxd/domain/models/_models.dart';
part "tmdb.g.dart";

@JsonSerializable()
class SearchMovieResponse implements BaseResponse<MoviesPreviewModel> {
  @override
  int? status;
  int page;
  @JsonKey(name: "total_pages")
  int totalPages;
  @JsonKey(name: "total_results")
  int totalResults;
  List<MoviePreviewResponse> results;

  SearchMovieResponse(
      this.status, this.page, this.totalPages, this.totalResults, this.results);

  factory SearchMovieResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchMovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMovieResponseToJson(this);

  @override
  toDomain() => MoviesPreviewModel(
      page: page,
      results: results
          .map((MoviePreviewResponse preview) => preview.toDomain())
          .toList(),
      totalPages: totalPages,
      totalResults: totalResults);
}

@JsonSerializable()
class MoviePreviewResponse implements BaseResponse<MoviePreviewModel> {
  @override
  int? status;
  bool? adult;
  @JsonKey(name: "backdrop_path")
  String? backdropPath;
  List<String>? genres;
  int? id;
  @JsonKey(name: "original_language")
  String? originalLanguage;
  @JsonKey(name: "original_title")
  String? originalTitle;
  String? overview;
  double? popularity;
  @JsonKey(name: "poster_path")
  String? posterPath;
  @JsonKey(name: "release_date")
  String? releaseDate;
  String? title;
  bool? video;
  @JsonKey(name: "vote_average")
  double? voteAverage;
  @JsonKey(name: "vote_count")
  int? voteCount;

  MoviePreviewResponse(
      this.status,
      this.posterPath,
      this.originalTitle,
      this.releaseDate,
      this.title,
      this.adult,
      this.backdropPath,
      this.genres,
      this.id,
      this.originalLanguage,
      this.overview,
      this.popularity,
      this.video,
      this.voteAverage,
      this.voteCount);

  factory MoviePreviewResponse.fromJson(Map<String, dynamic> json) =>
      _$MoviePreviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MoviePreviewResponseToJson(this);

  @override
  toDomain() => MoviePreviewModel(
      adult: adult ?? false,
      backdropPath: backdropPath,
      genres: genres ?? [],
      id: id ?? -1,
      originalLanguage: originalLanguage ?? "",
      originalTitle: originalTitle ?? "",
      overview: overview ?? "",
      popularity: popularity ?? 0,
      posterPath: posterPath,
      releaseDate: releaseDate,
      title: title ?? "",
      video: video,
      voteAverage: voteAverage ?? 0,
      voteCount: voteCount ?? 0);
}
