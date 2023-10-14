import 'package:equatable/equatable.dart';
import 'package:letterboxd/app/utils/constants.dart';
import 'package:letterboxd/domain/models/_models.dart';
import 'package:letterboxd/domain/models/tmdb/shared.dart';

class MovieDetailsModel extends Equatable {
  final String? backdropPath;
  final String? releaseDate;
  final String overview;
  final String? originalTitle;
  final String title;
  final String? tagline;
  final String? posterPath;
  final int? runtime;
  final String? trailer;
  final String? directorName;
  final MovieDetailsCreditsModel credits;
  final List<DetailableIntModel> studios;
  final List<DetailableStringModel> countries;
  final DetailableStringModel originalLanguage;
  final List<String> alternativeTitles;
  final List<DetailableIntModel> genres;
  final MoviesPreviewModel similar;

   const MovieDetailsModel.initial()
      : this(
            overview: Empty.string,
            title: Empty.string,
            credits: const MovieDetailsCreditsModel.initial(),
            studios: const [],
            countries: const [],
            originalLanguage: const DetailableStringModel.initial(),
            alternativeTitles: const [],
            genres: const [],
    similar: const MoviesPreviewModel.initial()
  );

  const MovieDetailsModel(
      {this.backdropPath,
      this.directorName,
      this.releaseDate,
      required this.overview,
      this.originalTitle,
      required this.title,
      this.tagline,
      this.posterPath,
      this.runtime,
      this.trailer,
      required this.credits,
      required this.studios,
      required this.countries,
      required this.originalLanguage,
      required this.alternativeTitles,
      required this.genres,
        required this.similar
      });

  @override
  List<Object?> get props => [
        backdropPath,
        releaseDate,
        overview,
        originalTitle,
        title,
        tagline,
        posterPath,
        runtime,
        trailer,
        credits,
        directorName,
        studios,
        countries,
        originalLanguage,
        alternativeTitles,
        genres
      ];
}

class MovieDetailsCreditsModel extends Equatable {
  final List<MovieDetailsCreditsCastModel> cast;
  final List<MovieDetailsCreditsCrewModel> crew;

  const MovieDetailsCreditsModel({required this.cast, required this.crew});

  const MovieDetailsCreditsModel.initial()
      : this(cast: const [], crew: const []);

  @override
  List<Object?> get props => [cast, crew];
}

class MovieDetailsCreditsCastModel extends Equatable {
  final int id;
  final String name;
  final String character;
  final String? profilePath;

  const MovieDetailsCreditsCastModel(
      {required this.id,
      required this.name,
      required this.character,
      this.profilePath});

  const MovieDetailsCreditsCastModel.initial()
      : this(id: Empty.integer, name: Empty.string, character: Empty.string);

  @override
  List<Object?> get props => [id, name, character, profilePath];
}

class MovieDetailsCreditsCrewModel extends Equatable {
  final int id;
  final String name;
  final String job;
  final String? profilePath;

  const MovieDetailsCreditsCrewModel(
      {required this.id,
      required this.name,
      required this.job,
      this.profilePath});

  const MovieDetailsCreditsCrewModel.initial()
      : this(id: Empty.integer, name: Empty.string, job: Empty.string);

  @override
  List<Object?> get props => [id, name, job, profilePath];
}
