import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/use_case/base_use_case.dart';
import 'package:movies_app/core/utils/enum.dart';
import 'package:movies_app/movies/domain/usecases/get_all_popular_movies_usecase.dart';
import 'package:movies_app/movies/domain/usecases/get_all_top_rated_movies_usecase.dart';
import 'package:movies_app/movies/domain/usecases/get_now_playing_movies_usecases.dart';
import 'package:movies_app/movies/domain/usecases/get_up_coming_movies_usecases.dart';
import 'package:movies_app/movies/presentation/controller/movies_events.dart';
import 'package:movies_app/movies/presentation/controller/movies_states.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesStates> {
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetUpcomingMoviesUseCase getUpcomingMoviesUseCase;
  final GetAllPopularMoviesUseCase allPopularMoviesUseCase;
  final GetAllTopRatedMoviesUseCase allTopRatedMoviesUseCase;

  // final GetPopularMoviesUseCase getPopularMoviesUseCase;
  MoviesBloc(
      this.getNowPlayingMoviesUseCase,
      this.getUpcomingMoviesUseCase,
      // this.getPopularMoviesUseCase,
      this.allTopRatedMoviesUseCase,
      this.allPopularMoviesUseCase)
      : super(const MoviesStates()) {
    on<GetNowPlayingMoviesEvent>(_getNowPlayingMovies);
    on<GetUpcomingMoviesEvent>(_getUpcomingMovies);
    // on<GetPopularMoviesEvent>(_getPopularMovies);
    on<GetPopularMoviesEvent>(_getAllPopularMovies);
    on<GetTopRatedMoviesEvent>(_getAllTopRatedMovies);
    on<FetchMorePopularMoviesEvent>(_fetchMoreMovies);
    on<FetchMoreTopRatedMoviesEvent>(_fetchMoreTopRatedMovies);
  }

  FutureOr<void> _getNowPlayingMovies(
      GetNowPlayingMoviesEvent event, Emitter<MoviesStates> emit) async {
    final result = await getNowPlayingMoviesUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            nowPlayingState: RequestState.error, nowPlayingMessage: l.message)),
        (r) => emit(state.copyWith(
            nowPlayingState: RequestState.loaded, nowPlayingMovies: r)));
  }

  FutureOr<void> _getUpcomingMovies(
      GetUpcomingMoviesEvent event, Emitter<MoviesStates> emit) async {
    final result = await getUpcomingMoviesUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            upcomingState: RequestState.error, upcomingMessage: l.message)),
        (r) => emit(state.copyWith(
            upcomingState: RequestState.loaded, upcomingMovies: r)));
  }

  // FutureOr<void> _getPopularMovies(
  //     GetPopularMoviesEvent event, Emitter<MoviesStates> emit) async {
  //   final result = await getPopularMoviesUseCase(const NoParameters());
  //   result.fold(
  //       (l) => emit(state.copyWith(
  //           popularState: GetAllRequestStatus.error,
  //           popularMessage: l.message)),
  //       (r) => emit(state.copyWith(
  //           popularState: GetAllRequestStatus.loaded, popularMovies: r)));
  // }

  int page = 1;

  Future<void> _getAllPopularMovies(
      GetPopularMoviesEvent event, Emitter<MoviesStates> emit) async {
    if (state.popularState == GetAllRequestStatus.loading) {
      await _getMoviesPopular(emit);
    } else if (state.popularMovies == GetAllRequestStatus.loaded) {
      await _getMoviesPopular(emit);
    } else {
      emit(
        state.copyWith(
          popularState: GetAllRequestStatus.loading,
        ),
      );
      await _getMoviesPopular(emit);
    }
  }

  Future<void> _getMoviesPopular(Emitter<MoviesStates> emit) async {
    final result = await allPopularMoviesUseCase(page);
    result.fold(
      (l) => emit(
        state.copyWith(
          popularState: GetAllRequestStatus.error,
        ),
      ),
      (r) {
        page++;
        emit(
          state.copyWith(
            popularState: GetAllRequestStatus.loaded,
            popularMovies: state.popularMovies + r,
          ),
        );
      },
    );
  }

  Future<void> _fetchMoreMovies(
      FetchMorePopularMoviesEvent event, Emitter<MoviesStates> emit) async {
    final result = await allPopularMoviesUseCase(page);
    result.fold(
      (l) => emit(
        state.copyWith(
          popularState: GetAllRequestStatus.fetchMoreError,
        ),
      ),
      (r) {
        page++;
        return emit(
          state.copyWith(
            popularState: GetAllRequestStatus.fetchMoreError,
            popularMovies: state.popularMovies + r,
          ),
        );
      },
    );
  }

  // FutureOr<void> _getTopRatedMovies(
  //     GetTopRatedMoviesEvent event, Emitter<MoviesStates> emit) async {
  //   final result = await getTopRatedMoviesUseCase(const NoParameters());
  //   result.fold(
  //       (l) => emit(state.copyWith(
  //           topRatedStates: GetAllRequestStatus.error,
  //           topRatedMessage: l.message)),
  //       (r) => emit(state.copyWith(
  //           topRatedStates: GetAllRequestStatus.loaded, topRatedMovies: r)));
  // }

  Future<void> _getAllTopRatedMovies(
      GetTopRatedMoviesEvent event, Emitter<MoviesStates> emit) async {
    if (state.topRatedStates == GetAllRequestStatus.loading) {
      await _getTopRatedMovies(emit);
    } else if (state.topRatedMovies == GetAllRequestStatus.loaded) {
      await _getTopRatedMovies(emit);
    } else {
      emit(
        state.copyWith(
          topRatedStates: GetAllRequestStatus.loading,
        ),
      );
      await _getTopRatedMovies(emit);
    }
  }

  Future<void> _getTopRatedMovies(Emitter<MoviesStates> emit) async {
    final result = await allTopRatedMoviesUseCase(page);
    result.fold(
      (l) => emit(
        state.copyWith(
          topRatedStates: GetAllRequestStatus.error,
        ),
      ),
      (r) {
        page++;
        emit(
          state.copyWith(
            topRatedStates: GetAllRequestStatus.loaded,
            topRatedMovies: state.topRatedMovies + r,
          ),
        );
      },
    );
  }

  Future<void> _fetchMoreTopRatedMovies(
      FetchMoreTopRatedMoviesEvent event, Emitter<MoviesStates> emit) async {
    final result = await allTopRatedMoviesUseCase(page);
    result.fold(
      (l) => emit(
        state.copyWith(
          topRatedStates: GetAllRequestStatus.fetchMoreError,
        ),
      ),
      (r) {
        page++;
        return emit(
          state.copyWith(
            topRatedStates: GetAllRequestStatus.fetchMoreError,
            topRatedMovies: state.topRatedMovies + r,
          ),
        );
      },
    );
  }
}
