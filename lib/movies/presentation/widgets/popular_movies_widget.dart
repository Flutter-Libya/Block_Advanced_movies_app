import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/components/horizontal_listview.dart';
import 'package:movies_app/core/components/listview_card.dart';
import 'package:movies_app/core/components/loading_indicator.dart';
import 'package:movies_app/core/global/app_string/app_string.dart';
import 'package:movies_app/core/global/theme/app_color/app_color_dark.dart';
import 'package:movies_app/core/global/theme/theme_data/theme_data.dart';
import 'package:movies_app/core/utils/enum.dart';
import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:movies_app/movies/presentation/controller/movies_bloc.dart';
import 'package:movies_app/movies/presentation/controller/movies_events.dart';
import 'package:movies_app/movies/presentation/controller/movies_states.dart';
import 'package:movies_app/movies/presentation/screens/see_more.dart';

class PopularMoviesWidget extends StatelessWidget {
  const PopularMoviesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = getThemeData[AppTheme.darkTheme]!.textTheme;
    return BlocBuilder<MoviesBloc, MoviesStates>(
      buildWhen: (previous, current) =>
          previous.popularState != current.popularState,
      builder: (context, state) {
        switch (state.popularState) {
          case GetAllRequestStatus.loading:
            return SizedBox(
              height: 130.h,
              child: const LoadingIndicator(),
            );
          case GetAllRequestStatus.loaded:
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0).r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppString.popular,
                        style: textTheme.labelLarge,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return SeeMoreScreen(
                                  movieList: state.popularMovies,
                                  title: AppString.popular,
                                );
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0).r,
                          child: Row(
                            children: [
                              Text(
                                AppString.seeMore,
                                style: textTheme.labelSmall,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16.sp,
                                color: AppColorsDark.iconColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                PopularWidget(movies: state.popularMovies),
              ],
            );
          case GetAllRequestStatus.error:
            return SizedBox(
              height: 300.h,
              child: Center(
                child: Text(
                  state.popularMessage,
                  style: textTheme.labelLarge,
                ),
              ),
            );
          case GetAllRequestStatus.fetchMoreError:
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0).r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppString.popular,
                        style: textTheme.labelLarge,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return SeeMoreScreen(
                                  movieList: state.popularMovies,
                                  title: AppString.popular,
                                );
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0).r,
                          child: Row(
                            children: [
                              Text(
                                AppString.seeMore,
                                style: textTheme.labelSmall,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16.sp,
                                color: AppColorsDark.iconColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                PopularWidget(movies: state.popularMovies),
              ],
            );
        }
      },
    );
  }
}

class PopularWidget extends StatelessWidget {
  const PopularWidget({
    required this.movies,
    super.key,
  });

  final List<Movies> movies;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesStates>(
      builder: (context, state) {
        return HorizontalListView(
          itemCount: movies.length + 1,
          itemBuilder: (context, index) {
            if (index < movies.length) {
              return HorizontalListViewCard(movies: movies[index]);
            } else {
              return const LoadingIndicator();
            }
          },
          addEvent: () {
            context.read<MoviesBloc>().add(FetchMorePopularMoviesEvent());
          },
        );
      },
    );
  }
}
