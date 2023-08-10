import 'package:equatable/equatable.dart';
import 'package:movies_app/core/utils/enum.dart';
import 'package:movies_app/tvs/domain/entities/tv_details.dart';
import 'package:movies_app/tvs/domain/entities/tv_recommendation.dart';
import 'package:movies_app/tvs/domain/entities/tv_similar.dart';

class TvsDetailsStates extends Equatable {
  final TvDetails? tvsDetails;
  final RequestState tvsDetailsStates;
  final String tvsDetailsMessage;

  final List<TvsRecommendation> tvsRecommendation;
  final RequestState tvsRecommendationStates;
  final String tvsRecommendationMessage;

  final List<TvsSimilar> tvsSimilar;
  final RequestState tvsSimilarStates;
  final String tvsSimilarMessage;

  const TvsDetailsStates({
    this.tvsDetails,
    this.tvsDetailsStates = RequestState.loading,
    this.tvsDetailsMessage = "",
    this.tvsRecommendation = const [],
    this.tvsRecommendationStates = RequestState.loading,
    this.tvsRecommendationMessage = "",
    this.tvsSimilar = const [],
    this.tvsSimilarStates = RequestState.loading,
    this.tvsSimilarMessage = "",
  });

  TvsDetailsStates copyWith({
    TvDetails? tvsDetails,
    RequestState? tvsDetailsStates,
    String? tvsDetailsMessage,
    List<TvsRecommendation>? tvsRecommendation,
    RequestState? tvsRecommendationStates,
    String? tvsRecommendationMessage,
    List<TvsSimilar>? tvsSimilar,
    RequestState? tvsSimilarStates,
    String? tvsSimilarMessage,
  }) {
    return TvsDetailsStates(
      tvsDetailsMessage: tvsDetailsMessage ?? this.tvsDetailsMessage,
      tvsDetails: tvsDetails ?? this.tvsDetails,
      tvsDetailsStates: tvsDetailsStates ?? this.tvsDetailsStates,
      tvsRecommendation: tvsRecommendation ?? this.tvsRecommendation,
      tvsRecommendationStates:
          tvsRecommendationStates ?? this.tvsRecommendationStates,
      tvsRecommendationMessage:
          tvsRecommendationMessage ?? this.tvsRecommendationMessage,
      tvsSimilar: tvsSimilar ?? this.tvsSimilar,
      tvsSimilarStates: tvsSimilarStates ?? this.tvsSimilarStates,
      tvsSimilarMessage: tvsSimilarMessage ?? this.tvsSimilarMessage,
    );
  }

  @override
  List<Object?> get props =>
      [
        tvsDetails,
        tvsDetailsMessage,
        tvsDetailsStates,
        tvsRecommendation,
        tvsRecommendationMessage,
        tvsRecommendationStates,
        tvsSimilar,
        tvsSimilarMessage,
        tvsSimilarStates,
      ];
}
