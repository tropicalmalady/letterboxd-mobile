// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchMovieResponse _$SearchMovieResponseFromJson(Map<String, dynamic> json) =>
    SearchMovieResponse(
      json['status'] as int?,
      json['page'] as int,
      json['total_pages'] as int,
      json['total_results'] as int,
      (json['results'] as List<dynamic>)
          .map((e) => MoviePreviewResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchMovieResponseToJson(
        SearchMovieResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'page': instance.page,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
      'results': instance.results,
    };

MoviePreviewResponse _$MoviePreviewResponseFromJson(
        Map<String, dynamic> json) =>
    MoviePreviewResponse(
      json['status'] as int?,
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

Map<String, dynamic> _$MoviePreviewResponseToJson(
        MoviePreviewResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
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
