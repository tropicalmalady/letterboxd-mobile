import 'package:json_annotation/json_annotation.dart';
import 'package:letterboxd/app/utils/constants.dart';
import 'package:letterboxd/data/response/_base.dart';
import 'package:letterboxd/data/response/shared.dart';
import 'package:letterboxd/domain/models/_models.dart';
import 'package:letterboxd/domain/models/tmdb/shared.dart';
part "tmdb.g.dart";

@JsonSerializable()
class MoviesPreviewResponse implements BaseResponse<MoviesPreviewModel> {
  @override
  int status;
  int page;
  @JsonKey(name: "total_pages")
  int totalPages;
  @JsonKey(name: "total_results")
  int totalResults;
  List<MoviesPreviewResultsResponse> results;

  MoviesPreviewResponse(
      this.status, this.page, this.totalPages, this.totalResults, this.results);

  factory MoviesPreviewResponse.fromJson(Map<String, dynamic> json) =>
      _$MoviesPreviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MoviesPreviewResponseToJson(this);

  @override
  toDomain() => MoviesPreviewModel(
      page: page,
      results: results.map((e) => e.toDomain()).toList(),
      totalPages: totalPages,
      totalResults: totalResults);
}

@JsonSerializable()
class MoviesPreviewResultsResponse
    implements BaseResponseField<MoviesPreviewResultsModel> {
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

  MoviesPreviewResultsResponse(
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

  factory MoviesPreviewResultsResponse.fromJson(Map<String, dynamic> json) =>
      _$MoviesPreviewResultsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MoviesPreviewResultsResponseToJson(this);

  @override
  toDomain() => MoviesPreviewResultsModel(
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

//----------------------------------------------------------------------------------

@JsonSerializable()
class GetMovieDetailsResponse implements BaseResponse<MovieDetailsModel> {
  @override
  int status;
  GetMovieDetailsResultResponse result;

  GetMovieDetailsResponse(this.status, this.result);

  factory GetMovieDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMovieDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMovieDetailsResponseToJson(this);

  @override
  toDomain() => result.toDomain();
}

@JsonSerializable()
class GetMovieDetailsResultResponse
    implements BaseResponseField<MovieDetailsModel> {
  @JsonKey(name: "backdrop_path")
  String? backdropPath;
  @JsonKey(name: "release_date")
  String? releaseDate;
  String? directorName;
  String? overview;
  @JsonKey(name: "original_title")
  String? originalTitle;
  String? title;
  String? tagline;
  @JsonKey(name: "poster_path")
  String? posterPath;
  int? runtime;
  String? trailer;
  GetMovieDetailsResultCreditsResponse? credits;
  List<DetailableIntResponse>? studios;
  List<DetailableStringResponse>? countries;
  @JsonKey(name: "original_language")
  DetailableStringResponse? originalLanguage;
  @JsonKey(name: "alternative_titles")
  List<String>? alternativeTitles;
  List<DetailableIntResponse>? genres;
  MoviesPreviewResponse similar;

  GetMovieDetailsResultResponse(
      this.backdropPath,
      this.releaseDate,
      this.directorName,
      this.overview,
      this.originalTitle,
      this.title,
      this.tagline,
      this.posterPath,
      this.runtime,
      this.trailer,
      this.credits,
      this.studios,
      this.countries,
      this.originalLanguage,
      this.alternativeTitles,
      this.genres,
      this.similar);

  factory GetMovieDetailsResultResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMovieDetailsResultResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMovieDetailsResultResponseToJson(this);

  @override
  toDomain() => MovieDetailsModel(
      backdropPath: backdropPath,
      releaseDate: releaseDate,
      originalTitle: originalTitle,
      tagline: tagline,
      directorName: directorName,
      posterPath: posterPath,
      runtime: runtime,
      trailer: trailer,
      overview: overview ?? Empty.string,
      title: title ?? Empty.string,
      credits: credits?.toDomain() ?? const MovieDetailsCreditsModel.initial(),
      studios: studios?.map((e) => e.toDomain()).toList() ?? [],
      countries: countries?.map((e) => e.toDomain()).toList() ?? [],
      originalLanguage:
          originalLanguage?.toDomain() ?? const DetailableStringModel.initial(),
      alternativeTitles: alternativeTitles ?? [],
      genres: genres?.map((e) => e.toDomain()).toList() ?? [],
    similar: MoviesPreviewModel(page: similar.page, results:
    similar.results.map((e) => e.toDomain()).toList(), totalPages:
    similar.totalPages, totalResults: similar.totalResults)

  );
}

@JsonSerializable()
class GetMovieDetailsResultCreditsResponse
    implements BaseResponseField<MovieDetailsCreditsModel> {
  List<GetMovieDetailsResultCreditsCastResponse> cast;
  List<GetMovieDetailsResultCreditsCrewResponse> crew;

  GetMovieDetailsResultCreditsResponse(this.cast, this.crew);

  factory GetMovieDetailsResultCreditsResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetMovieDetailsResultCreditsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetMovieDetailsResultCreditsResponseToJson(this);

  @override
  toDomain() => MovieDetailsCreditsModel(
      cast: cast.map((e) => e.toDomain()).toList(),
      crew: crew.map((e) => e.toDomain()).toList());
}

@JsonSerializable()
class GetMovieDetailsResultCreditsCastResponse
    implements BaseResponseField<MovieDetailsCreditsCastModel> {
  int? id;
  String? name;
  String? character;
  @JsonKey(name: "profile_path")
  String? profilePath;

  GetMovieDetailsResultCreditsCastResponse(
      this.id, this.name, this.character, this.profilePath);

  factory GetMovieDetailsResultCreditsCastResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetMovieDetailsResultCreditsCastResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetMovieDetailsResultCreditsCastResponseToJson(this);

  @override
  toDomain() => MovieDetailsCreditsCastModel(
      id: id ?? Empty.integer,
      name: name ?? Empty.string,
      character: character ?? Empty.string,
      profilePath: profilePath);
}

@JsonSerializable()
class GetMovieDetailsResultCreditsCrewResponse
    implements BaseResponseField<MovieDetailsCreditsCrewModel> {
  dynamic id;
  String? name;
  String? job;
  @JsonKey(name: "profile_path")
  String? profilePath;

  GetMovieDetailsResultCreditsCrewResponse(
      this.id, this.name, this.job, this.profilePath);

  factory GetMovieDetailsResultCreditsCrewResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetMovieDetailsResultCreditsCrewResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetMovieDetailsResultCreditsCrewResponseToJson(this);

  @override
  toDomain() => MovieDetailsCreditsCrewModel(
      id: id,
      name: name ?? Empty.string,
      job: job ?? Empty.string,
      profilePath: profilePath);
}
