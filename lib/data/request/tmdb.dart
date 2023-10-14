class MoviesPreviewRequest {
  String query;
  int page;
  MoviesPreviewRequest(this.query, this.page);
}

class GetMovieDetailsRequest {
  int movieId;
  GetMovieDetailsRequest(this.movieId);
}
