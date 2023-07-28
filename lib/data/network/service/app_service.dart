import 'package:dio/dio.dart';
import 'package:letterboxd/app/utils/constants.dart';
import 'package:letterboxd/data/response/auth/auth.dart';
import 'package:letterboxd/data/response/tmdb/tmdb.dart';
import 'package:retrofit/retrofit.dart';

part "app_service.g.dart";

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("auth/sign-up")
  Future<SignUpResponse> signUp(
    @Field("username") String username,
    @Field("email") String email,
    @Field("password") String password,
  );

  @GET("auth/username-check/{username}")
  Future<UsernameCheckResponse> usernameCheck(
      @Path("username") String username);

  @GET("tmdb/search-movies")
  Future<SearchMovieResponse> searchMovies(
      @Query("query") String query, @Query("page") int page);
}
