import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/components/cast_card.dart';
import 'package:movies_app/core/components/image_shimmer.dart';
import 'package:movies_app/core/components/loading_indicator.dart';
import 'package:movies_app/core/components/review_card.dart';
import 'package:movies_app/core/components/size_box.dart';
import 'package:movies_app/core/global/app_string/app_string.dart';
import 'package:movies_app/core/global/theme/app_color/app_color_dark.dart';
import 'package:movies_app/core/global/theme/theme_data/theme_data.dart';
import 'package:movies_app/core/network/api_constance.dart';
import 'package:movies_app/core/services/services_locator.dart';
import 'package:movies_app/core/utils/enum.dart';
import 'package:movies_app/core/utils/function.dart';
import 'package:movies_app/movies/domain/entities/cast.dart';
import 'package:movies_app/movies/domain/entities/genres.dart';
import 'package:movies_app/movies/domain/entities/review.dart';
import 'package:movies_app/movies/presentation/controller/movies_details_bloc.dart';
import 'package:movies_app/movies/presentation/controller/movies_details_events.dart';
import 'package:movies_app/movies/presentation/controller/movies_details_states.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieID;

  const MovieDetailsScreen({Key? key, required this.movieID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MoviesDetailsBloc>()
        ..add(GetMoviesDetailsEvent(movieID))
        ..add(GetMoviesRecommendationEvent(movieID))
        ..add(GetMoviesSimilarEvent(movieID)),
      child: const Scaffold(
        body: MovieDetailContent(),
      ),
    );
  }
}

class MovieDetailContent extends StatelessWidget {
  const MovieDetailContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = getThemeData[AppTheme.darkTheme]!.textTheme;

    return BlocBuilder<MoviesDetailsBloc, MoviesDetailsStates>(
      builder: (context, state) {
        switch (state.moviesDetailsStates) {
          case RequestState.loading:
            return SizedBox(height: 250.h, child: const LoadingIndicator());

          case RequestState.loaded:
            return SingleChildScrollView(
              key: const Key('movieDetailScrollView'),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ImageWithShimmer(
                        imageUrl: ApiConstance.imageURL(
                            state.moviesDetails!.backdropPath),
                        width: double.infinity,
                        height: 250.h,
                        boxFit: BoxFit.fill,
                      ),
                      FadeInUp(
                        from: 20,
                        duration: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0).r,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10).r,
                                      border: Border.all(
                                        color: AppColorsDark.borderColor,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16).r,
                                      child: ImageWithShimmer(
                                        imageUrl: ApiConstance.imageURL(
                                          state.moviesDetails!.posterPath,
                                        ),
                                        width: 120.w,
                                        height: 150.h,
                                      ),
                                    ),
                                  ),
                                  Space(height: 0, width: 16.w),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 19.r,
                                          backgroundColor:
                                              AppColorsDark.primaryRedColor,
                                          child: IconButton(
                                            onPressed: () {
                                              urlLauncher(
                                                Uri.parse(
                                                  state.moviesDetails
                                                          ?.trailerUrl ??
                                                      '',
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.play_circle,
                                              color: AppColorsDark.iconColor,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          state.moviesDetails!.title,
                                          style: textTheme.titleLarge,
                                        ),
                                        Space(height: 8.h, width: 0),
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 2.0,
                                                horizontal: 8.0,
                                              ).r,
                                              decoration: BoxDecoration(
                                                color:
                                                    AppColorsDark.greyDarkColor,
                                                borderRadius:
                                                    BorderRadius.circular(4.0)
                                                        .r,
                                              ),
                                              child: Text(
                                                state.moviesDetails!.releaseDate
                                                    .split('-')[0],
                                                style: textTheme.labelMedium,
                                              ),
                                            ),
                                            Space(height: 0, width: 16.w),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: AppColorsDark
                                                      .iconRateColor,
                                                  size: 20.0.sp,
                                                ),
                                                Space(height: 0, width: 4.w),
                                                Text(
                                                  (state.moviesDetails!
                                                          .voteAverage)
                                                      .toStringAsFixed(1),
                                                  style: textTheme.labelMedium,
                                                ),
                                              ],
                                            ),
                                            Space(height: 0, width: 16.w),
                                            Expanded(
                                              child: Text(
                                                _showDuration(state
                                                    .moviesDetails!.runtime),
                                                style: textTheme.labelMedium!
                                                    .copyWith(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0).r,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.moviesDetails!.overview,
                                      style: textTheme.titleMedium,
                                    ),
                                    Space(height: 8.h, width: 0),
                                    Text(
                                      'Genres: ${_showGenres(state.moviesDetails!.genres)}',
                                      style: textTheme.labelSmall!.copyWith(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      FadeInUp(
                        from: 20,
                        duration: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: const EdgeInsets.all(12).r,
                          child: Text(
                            AppString.cast,
                            style: textTheme.labelLarge,
                          ),
                        ),
                      ),
                      _getCast(state.moviesDetails!.cast),
                      FadeInUp(
                        from: 20,
                        duration: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: const EdgeInsets.all(12).r,
                          child: Text(
                            AppString.reviews,
                            style: textTheme.labelLarge,
                          ),
                        ),
                      ),
                      _getReviews(state.moviesDetails!.reviews),
                      Space(height: 18.h, width: 0),
                      FadeInUp(
                        from: 20,
                        duration: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: const EdgeInsets.all(12).r,
                          child: Text(
                            AppString.recommendations,
                            style: textTheme.labelLarge,
                          ),
                        ),
                      ),
                      _showRecommendations(),
                      Space(height: 18.h, width: 0),
                      FadeInUp(
                        from: 20,
                        duration: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0).r,
                          child: Text(
                            AppString.moreLikeThis,
                            style: textTheme.labelLarge,
                          ),
                        ),
                      ),
                      _showSimilar(),
                      Space(height: 20.h, width: 0),
                    ],
                  ),
                  Positioned(
                    top: 40.h,
                    left: 10.w,
                    child: CircleAvatar(
                      backgroundColor: AppColorsDark.primaryRedColor,
                      radius: 20.r,
                      child: IconButton(
                        alignment: Alignment.center,
                        onPressed: () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        },
                        icon: Icon(
                          Icons.arrow_circle_left_rounded,
                          color: AppColorsDark.iconColor,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          case RequestState.error:
            return SizedBox(
              height: 300.h,
              child: Center(
                child: Text(
                  state.moviesDetailsMessage,
                  style: textTheme.titleLarge,
                ),
              ),
            );
        }
      },
    );
  }

  String _showGenres(List<Genres> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  Widget _showRecommendations() {
    final textTheme = getThemeData[AppTheme.darkTheme]!.textTheme;

    return BlocBuilder<MoviesDetailsBloc, MoviesDetailsStates>(
      builder: (context, state) {
        switch (state.moviesRecommendationStates) {
          case RequestState.loading:
            return SizedBox(height: 300.h, child: const LoadingIndicator());
          case RequestState.loaded:
            return FadeIn(
              duration: const Duration(milliseconds: 500),
              child: SizedBox(
                height: 170.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16).r,
                  itemCount: state.moviesRecommendation.length,
                  itemBuilder: (context, index) {
                    final recommendation = state.moviesRecommendation[index];
                    return Container(
                      padding: const EdgeInsets.only(right: 8).r,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailsScreen(
                                movieID: recommendation.id,
                              ),
                            ),
                          );
                          if (kDebugMode) {
                            print(recommendation.id);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10).r,
                            border: Border.all(
                              color: AppColorsDark.borderColor,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ).r,
                            child: ImageWithShimmer(
                              imageUrl: ApiConstance.imageURL(
                                  recommendation.backdropPath!),
                              width: 120.w,
                              height: double.infinity,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          case RequestState.error:
            return SizedBox(
              height: 300.h,
              child: Center(
                child: Text(
                  state.moviesRecommendationMessage,
                  style: textTheme.titleLarge,
                ),
              ),
            );
        }
      },
    );
  }

  Widget _showSimilar() {
    final textTheme = getThemeData[AppTheme.darkTheme]!.textTheme;
    return BlocBuilder<MoviesDetailsBloc, MoviesDetailsStates>(
      builder: (context, state) {
        switch (state.moviesSimilarStates) {
          case RequestState.loading:
            return SizedBox(
              height: 300.h,
              child: const LoadingIndicator(),
            );
          case RequestState.loaded:
            return FadeIn(
              duration: const Duration(milliseconds: 500),
              child: SizedBox(
                height: 170.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16).r,
                  itemCount: state.moviesSimilar.length,
                  itemBuilder: (context, index) {
                    final similar = state.moviesSimilar[index];
                    return Container(
                      padding: const EdgeInsets.only(right: 8).r,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailsScreen(
                                movieID: similar.id,
                              ),
                            ),
                          );
                          if (kDebugMode) {
                            print(similar.id);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10).r,
                            border: Border.all(
                              color: AppColorsDark.borderColor,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ).r,
                            child: ImageWithShimmer(
                              imageUrl:
                                  ApiConstance.imageURL(similar.backdropPath!),
                              width: 120.w,
                              height: double.infinity,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          case RequestState.error:
            return SizedBox(
              height: 300.h,
              child: Center(
                child: Text(
                  state.moviesSimilarMessage,
                  style: textTheme.titleLarge,
                ),
              ),
            );
        }
      },
    );
  }

  Widget _getCast(List<Cast>? cast) {
    if (cast != null && cast.isNotEmpty) {
      return SectionListView(
        height: 140.h,
        itemCount: cast.length,
        itemBuilder: (context, index) => CastCard(
          cast: cast[index],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _getReviews(List<Review>? reviews) {
    if (reviews != null && reviews.isNotEmpty) {
      return SectionListView(
        height: 150.h,
        itemCount: reviews.length,
        itemBuilder: (context, index) => ReviewCard(
          review: reviews[index],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}

class SectionListView extends StatelessWidget {
  final int itemCount;
  final double height;
  final Widget Function(BuildContext context, int index) itemBuilder;

  const SectionListView({
    required this.height,
    required this.itemCount,
    required this.itemBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16).r,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        itemBuilder: itemBuilder,
        separatorBuilder: (context, index) => SizedBox(width: 10.w),
      ),
    );
  }
}
