// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesPreviewResponse _$MoviesPreviewResponseFromJson(
        Map<String, dynamic> json) =>
    MoviesPreviewResponse(
      json['status'] as int?,
      json['page'] as int,
      json['total_pages'] as int,
      json['total_results'] as int,
      (json['results'] as List<dynamic>)
          .map((e) =>
              MoviesPreviewResultsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MoviesPreviewResponseToJson(
        MoviesPreviewResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'page': instance.page,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
      'results': instance.results,
    };

MoviesPreviewResultsResponse _$MoviesPreviewResultsResponseFromJson(
        Map<String, dynamic> json) =>
    MoviesPreviewResultsResponse(
      json['poster_path'] as String?,
      json['original_title'] as String?,
      json['release_date'] as String?,
      json['title'] as String?,
      json['adult'] as bool?,
      json['backdrop_path'] as String?,
      (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['id'] as int?,
      json['original_language'] as String?,
      json['overview'] as String?,
      (json['popularity'] as num?)?.toDouble(),
      json['video'] as bool?,
      (json['vote_average'] as num?)?.toDouble(),
      json['vote_count'] as int?,
    );

Map<String, dynamic> _$MoviesPreviewResultsResponseToJson(
        MoviesPreviewResultsResponse instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genres': instance.genres,
      'id': instance.id,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };

GetMovieDetailsResponse _$GetMovieDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    GetMovieDetailsResponse(
      json['status'] as int?,
      GetMovieDetailsResultResponse.fromJson(
          json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetMovieDetailsResponseToJson(
        GetMovieDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
    };

GetMovieDetailsResultResponse _$GetMovieDetailsResultResponseFromJson(
        Map<String, dynamic> json) =>
    GetMovieDetailsResultResponse(
      json['backdrop_path'] as String?,
      json['release_date'] as String?,
      json['directorName'] as String?,
      json['overview'] as String?,
      json['original_title'] as String?,
      json['title'] as String?,
      json['tagline'] as String?,
      json['poster_path'] as String?,
      json['runtime'] as int?,
      json['trailer'] as String?,
      json['credits'] == null
          ? null
          : GetMovieDetailsResultCreditsResponse.fromJson(
              json['credits'] as Map<String, dynamic>),
      (json['studios'] as List<dynamic>?)
          ?.map(
              (e) => DetailableIntResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['countries'] as List<dynamic>?)
          ?.map((e) =>
              DetailableStringResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['original_language'] == null
          ? null
          : DetailableStringResponse.fromJson(
              json['original_language'] as Map<String, dynamic>),
      (json['alternative_titles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      (json['genres'] as List<dynamic>?)
          ?.map(
              (e) => DetailableIntResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      MoviesPreviewResponse.fromJson(
          json['recommendations'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetMovieDetailsResultResponseToJson(
        GetMovieDetailsResultResponse instance) =>
    <String, dynamic>{
      'backdrop_path': instance.backdropPath,
      'release_date': instance.releaseDate,
      'directorName': instance.directorName,
      'overview': instance.overview,
      'original_title': instance.originalTitle,
      'title': instance.title,
      'tagline': instance.tagline,
      'poster_path': instance.posterPath,
      'runtime': instance.runtime,
      'trailer': instance.trailer,
      'credits': instance.credits,
      'studios': instance.studios,
      'countries': instance.countries,
      'original_language': instance.originalLanguage,
      'alternative_titles': instance.alternativeTitles,
      'genres': instance.genres,
      'recommendations': instance.similar,
    };

GetMovieDetailsResultCreditsResponse
    _$GetMovieDetailsResultCreditsResponseFromJson(Map<String, dynamic> json) =>
        GetMovieDetailsResultCreditsResponse(
          (json['cast'] as List<dynamic>)
              .map((e) => GetMovieDetailsResultCreditsCastResponse.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          (json['crew'] as List<dynamic>)
              .map((e) => GetMovieDetailsResultCreditsCrewResponse.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$GetMovieDetailsResultCreditsResponseToJson(
        GetMovieDetailsResultCreditsResponse instance) =>
    <String, dynamic>{
      'cast': instance.cast,
      'crew': instance.crew,
    };

GetMovieDetailsResultCreditsCastResponse
    _$GetMovieDetailsResultCreditsCastResponseFromJson(
            Map<String, dynamic> json) =>
        GetMovieDetailsResultCreditsCastResponse(
          json['id'] as int?,
          json['name'] as String?,
          json['character'] as String?,
          json['profile_path'] as String?,
        );

Map<String, dynamic> _$GetMovieDetailsResultCreditsCastResponseToJson(
        GetMovieDetailsResultCreditsCastResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'character': instance.character,
      'profile_path': instance.profilePath,
    };

GetMovieDetailsResultCreditsCrewResponse
    _$GetMovieDetailsResultCreditsCrewResponseFromJson(
            Map<String, dynamic> json) =>
        GetMovieDetailsResultCreditsCrewResponse(
          json['id'],
          json['name'] as String?,
          json['job'] as String?,
          json['profile_path'] as String?,
        );

Map<String, dynamic> _$GetMovieDetailsResultCreditsCrewResponseToJson(
        GetMovieDetailsResultCreditsCrewResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'job': instance.job,
      'profile_path': instance.profilePath,
    };
