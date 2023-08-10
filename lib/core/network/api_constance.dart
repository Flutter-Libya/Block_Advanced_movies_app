class ApiConstance {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String appKey = "f9f2187654bf478a79a1bda499324c2c";
  static const String baseProfileUrl = 'https://image.tmdb.org/t/p/w300';
  static const String baseStillUrl = 'https://image.tmdb.org/t/p/w500';
  static const String baseAvatarUrl = 'https://image.tmdb.org/t/p/w185';
  static const String baseVideoUrl = 'https://www.youtube.com/watch?v=';
  static const String baseImageURL = "https://image.tmdb.org/t/p/w500";

  static const String castPlaceHolder =
      'https://palmbayprep.org/wp-content/uploads/2015/09/user-icon-placeholder.png';

  static const String avatarPlaceHolder =
      'https://cdn.pixabay.com/photo/2018/11/13/21/43/avatar-3814049__480.png';

  /// API Constance For Movies
  static const String nowPlayingMoviesPath =
      "$baseUrl/movie/now_playing?api_key=$appKey";

  static const String upcomingMoviesPath =
      "$baseUrl/movie/upcoming?api_key=$appKey";

  static const String popularMoviesPath =
      "$baseUrl/movie/popular?api_key=$appKey";

  static const String topRatedMoviesPath =
      "$baseUrl/movie/top_rated?api_key=$appKey";

  static String movieDetailsPath(int movieID) =>
      "$baseUrl/movie/$movieID?api_key=$appKey&append_to_response=videos,credits,reviews,similar";

  static String movieRecommendationPath(int movieID) =>
      "$baseUrl/movie/$movieID/recommendations?api_key=$appKey";

  static String movieSimilarPath(int movieID) =>
      "$baseUrl/movie/$movieID/similar?api_key=$appKey";

  static String getAllPopularMoviesPath(int page) {
    return '$baseUrl/movie/popular?api_key=$appKey&page=$page';
  }

  static String getAllTopRatedMoviesPath(int page) {
    return '$baseUrl/movie/top_rated?api_key=$appKey&page=$page';
  }

  /// API Constance For Base Image URL
  static String imageURL(String imagePath) => '$baseImageURL$imagePath';

  /// API Constance For TV
  static const String onTheAirTvPath =
      "$baseUrl/tv/on_the_air?api_key=$appKey&with_original_language=en";

  static const String airingTodayTvPath =
      "$baseUrl/tv/airing_today?api_key=$appKey&page=2";

  static const String popularTvsPath =
      "$baseUrl/tv/popular?api_key=$appKey&with_original_language=en";

  static const String topRatedTvsPath =
      "$baseUrl/tv/top_rated?api_key=$appKey&with_original_language=en";

  static String tvDetailsPath(int tvID) =>
      "$baseUrl/tv/$tvID?api_key=$appKey&append_to_response=similar,videos";

  static String tvRecommendationPath(int tvID) =>
      "$baseUrl/tv/$tvID/recommendations?api_key=$appKey";

  static String tvSimilarPath(int tvID) =>
      "$baseUrl/tv/$tvID/similar?api_key=$appKey";

  static String tvSeasonPath(int tvID, int numberOfSeason) =>
      "$baseUrl/tv/$tvID/season/$numberOfSeason?api_key=$appKey";

  /// API Constance For Search
  static String getSearchPath(String title) {
    return '$baseUrl/search/multi?api_key=$appKey&query=$title';
  }
}
