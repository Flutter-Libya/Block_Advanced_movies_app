import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/components/image_shimmer.dart';
import 'package:movies_app/core/components/size_box.dart';
import 'package:movies_app/core/global/theme/app_color/app_color_dark.dart';
import 'package:movies_app/core/global/theme/theme_data/theme_data.dart';
import 'package:movies_app/core/network/api_constance.dart';
import 'package:movies_app/core/utils/enum.dart';
import 'package:movies_app/tvs/domain/entities/tvs.dart';
import 'package:movies_app/tvs/presentation/screens/tvs_details_screen.dart';

class SeeMoreScreen extends StatelessWidget {
  const SeeMoreScreen({Key? key, required this.tvsList, required this.name})
      : super(key: key);

  final List<Tvs> tvsList;
  final String name;

  @override
  Widget build(BuildContext context) {
    final textTheme = getThemeData[AppTheme.darkTheme]!.textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColorsDark.greyDarkColor,
        elevation: 0,
        title: Text(
          "$name Tvs".toUpperCase(),
          style: textTheme.labelLarge,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(horizontal: 12).r,
        itemCount: tvsList.length,
        itemBuilder: (context, index) {
          final tv = tvsList[index];
          return Container(
            decoration: BoxDecoration(
              color: AppColorsDark.darkPrimary,
              borderRadius: BorderRadius.circular(10).r,
            ),
            padding: const EdgeInsets.all(10).r,
            margin: const EdgeInsets.symmetric(vertical: 10).r,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TvsDetailsScreen(
                        tvsID: tv.id,
                      );
                    },
                  ),
                );
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ).r,
                    child: ImageWithShimmer(
                      imageUrl: ApiConstance.imageURL(tv.backdropPath),
                      width: 120.w,
                      height: 140.h,
                    ),
                  ),
                  Space(height: 0, width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tv.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: textTheme.labelLarge,
                        ),
                        Space(height: 5.h, width: 0),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2.0,
                                horizontal: 8.0,
                              ).r,
                              decoration: BoxDecoration(
                                color: AppColorsDark.primaryRedColor,
                                borderRadius: BorderRadius.circular(4.0).r,
                              ),
                              child: Text(
                                tv.firstAirDate.split('-')[0],
                                style: textTheme.titleSmall,
                              ),
                            ),
                            Space(height: 0, width: 16.w),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: AppColorsDark.iconRateColor,
                                  size: 20.sp,
                                ),
                                Space(height: 0, width: 4.w),
                                Text(
                                  (tv.voteAverage).toStringAsFixed(1),
                                  style: textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Space(height: 10.h, width: 0),
                        Text(
                          tvsList[index].overview,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.titleMedium,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
