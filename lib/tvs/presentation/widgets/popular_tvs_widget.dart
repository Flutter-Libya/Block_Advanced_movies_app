import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/components/image_shimmer.dart';
import 'package:movies_app/core/components/loading_indicator.dart';
import 'package:movies_app/core/global/app_string/app_string.dart';
import 'package:movies_app/core/global/theme/app_color/app_color_dark.dart';
import 'package:movies_app/core/global/theme/theme_data/theme_data.dart';
import 'package:movies_app/core/network/api_constance.dart';
import 'package:movies_app/core/utils/enum.dart';
import 'package:movies_app/tvs/presentation/controller/tvs_bloc.dart';
import 'package:movies_app/tvs/presentation/controller/tvs_states.dart';
import 'package:movies_app/tvs/presentation/screens/see_more.dart';
import 'package:movies_app/tvs/presentation/screens/tvs_details_screen.dart';

class PopularTvsWidget extends StatelessWidget {
  const PopularTvsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = getThemeData[AppTheme.darkTheme]!.textTheme;

    return BlocBuilder<TvsBloc, TvsStates>(
      buildWhen: (previous, current) =>
          previous.popularState != current.popularState,
      builder: (context, state) {
        switch (state.popularState) {
          case RequestState.loading:
            return SizedBox(
              height: 130.h,
              child: const LoadingIndicator(),
            );
          case RequestState.loaded:
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(
                    16.0,
                    24.0,
                    16.0,
                    8.0,
                  ).r,
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
                                  tvsList: state.popularTvs,
                                  name: AppString.popular,
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
                FadeIn(
                  duration: const Duration(milliseconds: 500),
                  child: SizedBox(
                    height: 130.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16).r,
                      itemCount: state.popularTvs.length,
                      itemBuilder: (context, index) {
                        final tvs = state.popularTvs[index];
                        return Container(
                          padding: const EdgeInsets.only(right: 8).r,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TvsDetailsScreen(
                                    tvsID: tvs.id,
                                  ),
                                ),
                              );
                              if (kDebugMode) {
                                print(tvs.id);
                              }
                            },
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0))
                                      .r,
                              child: ImageWithShimmer(
                                imageUrl:
                                    ApiConstance.imageURL(tvs.backdropPath),
                                width: 120.w,
                                height: double.infinity,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          case RequestState.error:
            return SizedBox(
              height: 300.h,
              child: Center(
                child: Text(
                  state.popularMessage,
                  style: textTheme.labelLarge,
                ),
              ),
            );
        }
      },
    );
  }
}
