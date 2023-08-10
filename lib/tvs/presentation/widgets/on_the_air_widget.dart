import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/components/image_shimmer.dart';
import 'package:movies_app/core/components/loading_indicator.dart';
import 'package:movies_app/core/components/size_box.dart';
import 'package:movies_app/core/global/app_string/app_string.dart';
import 'package:movies_app/core/global/theme/app_color/app_color_dark.dart';
import 'package:movies_app/core/global/theme/theme_data/theme_data.dart';
import 'package:movies_app/core/network/api_constance.dart';
import 'package:movies_app/core/utils/enum.dart';
import 'package:movies_app/tvs/presentation/controller/tvs_bloc.dart';
import 'package:movies_app/tvs/presentation/controller/tvs_states.dart';
import 'package:movies_app/tvs/presentation/screens/tvs_details_screen.dart';

class OnTheAirWidget extends StatelessWidget {
  const OnTheAirWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = getThemeData[AppTheme.darkTheme]!.textTheme;
    return BlocBuilder<TvsBloc, TvsStates>(
      buildWhen: (previous, current) =>
          previous.onTheAirState != current.onTheAirState,
      builder: (context, state) {
        switch (state.onTheAirState) {
          case RequestState.loading:
            return SizedBox(
              height: 300.h,
              child: const LoadingIndicator(),
            );

          case RequestState.loaded:
            return FadeIn(
              duration: const Duration(milliseconds: 500),
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  height: 300.h,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {},
                ),
                items: state.onTheAirTvs.map(
                  (item) {
                    return GestureDetector(
                      key: const Key('openMovieMinimalDetail'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return TvsDetailsScreen(tvsID: item.id);
                            },
                          ),
                        );
                        if (kDebugMode) {
                          print(item.id);
                        }
                      },
                      child: Stack(
                        children: [
                          ShaderMask(
                            shaderCallback: (rect) {
                              return const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  // fromLTRB
                                  Colors.transparent,
                                  Colors.black,
                                  Colors.black,
                                  Colors.transparent,
                                ],
                                stops: [0, 0.3, 0.5, 1],
                              ).createShader(
                                Rect.fromLTRB(0, 0, rect.width, rect.height),
                              );
                            },
                            blendMode: BlendMode.dstIn,
                            child: ImageWithShimmer(
                              boxFit: BoxFit.fill,
                              imageUrl:
                                  ApiConstance.imageURL(item.backdropPath),
                              width: double.infinity,
                              height: 560.h,
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 40),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(70).r,
                                    child: ImageWithShimmer(
                                      boxFit: BoxFit.fill,
                                      imageUrl: ApiConstance.imageURL(
                                        item.posterPath,
                                      ),
                                      width: 110.w,
                                      height: 100.h,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16).r,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color:
                                                AppColorsDark.primaryRedColor,
                                            size: 16.sp,
                                          ),
                                          Space(height: 0, width: 4.w),
                                          Text(
                                            AppString.onAir.toUpperCase(),
                                            style: textTheme.bodyLarge,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16).r,
                                      child: Text(
                                        item.name,
                                        textAlign: TextAlign.center,
                                        style: textTheme.titleLarge,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
              ),
            );

          case RequestState.error:
            return SizedBox(
              height: 300.h,
              child: Center(
                child: Text(
                  state.onTheAirMessage,
                  style: textTheme.labelLarge,
                ),
              ),
            );
        }
      },
    );
  }
}
