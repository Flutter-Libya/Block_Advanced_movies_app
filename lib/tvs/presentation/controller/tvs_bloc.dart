import 'dart:async';
import 'package:movies_app/core/use_case/base_use_case.dart';
import 'package:movies_app/core/utils/enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/tvs/domain/usecases/get_airing_today_tvs_usecases.dart';
import 'package:movies_app/tvs/domain/usecases/get_on_air_tvs_usecases.dart';
import 'package:movies_app/tvs/domain/usecases/get_popular_tvs_usecases.dart';
import 'package:movies_app/tvs/domain/usecases/get_top_rated_tvs_usecases.dart';
import 'package:movies_app/tvs/presentation/controller/tvs_events.dart';
import 'package:movies_app/tvs/presentation/controller/tvs_states.dart';

class TvsBloc extends Bloc<TvsEvent, TvsStates> {
  final GetOnTheAirTvsUseCase getOnTheAirTvsUseCase;
  final GetAiringTodayTvsUseCase getAiringTodayTvsUseCase;

  final GetPopularTvsUseCase getPopularTvsUseCase;
  final GetTopRatedTvsUseCase getTopRatedTvsUseCase;

  TvsBloc(this.getOnTheAirTvsUseCase, this.getAiringTodayTvsUseCase,
      this.getPopularTvsUseCase, this.getTopRatedTvsUseCase)
      : super(const TvsStates()) {
    on<GetOnTheAirTvsEvent>(_getOnTheAirTvs);
    on<GetAiringTodayTvsEvent>(_getAiringTodayTvs);

    on<GetPopularTvsEvent>(_getPopularTvs);

    on<GetTopRatedTvsEvent>(_getTopRatedTvs);
  }

  FutureOr<void> _getOnTheAirTvs(
      GetOnTheAirTvsEvent event, Emitter<TvsStates> emit) async {
    final result = await getOnTheAirTvsUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            onTheAirState: RequestState.error, onTheAirMessage: l.message)),
        (r) => emit(state.copyWith(
            onTheAirState: RequestState.loaded, onTheAirTvs: r)));
  }

  FutureOr<void> _getAiringTodayTvs(
      GetAiringTodayTvsEvent event, Emitter<TvsStates> emit) async {
    final result = await getAiringTodayTvsUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            airingTodayState: RequestState.error,
            airingTodayMessage: l.message)),
        (r) => emit(state.copyWith(
            airingTodayState: RequestState.loaded, airingTodayTvs: r)));
  }

  FutureOr<void> _getPopularTvs(
      GetPopularTvsEvent event, Emitter<TvsStates> emit) async {
    final result = await getPopularTvsUseCase(const NoParameters());
    result.fold(
        (l) => emit(state.copyWith(
            popularState: RequestState.error, popularMessage: l.message)),
        (r) => emit(
            state.copyWith(popularState: RequestState.loaded, popularTvs: r)));
  }

  FutureOr<void> _getTopRatedTvs(
      GetTopRatedTvsEvent event, Emitter<TvsStates> emit) async {
    final result = await getTopRatedTvsUseCase(const NoParameters());
    result.fold(
        (l) => emit(state.copyWith(
            topRatedStates: RequestState.error, topRatedMessage: l.message)),
        (r) => emit(state.copyWith(
            topRatedStates: RequestState.loaded, topRatedTvs: r)));
  }
}
