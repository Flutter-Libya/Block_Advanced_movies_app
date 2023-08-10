import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/components/image_shimmer.dart';
import 'package:movies_app/core/global/theme/theme_data/theme_data.dart';
import 'package:movies_app/core/network/api_constance.dart';
import 'package:movies_app/core/utils/enum.dart';
import 'package:movies_app/movies/presentation/screens/movie_details_screen.dart';
import 'package:movies_app/search/domain/entities/search_result_item.dart';
import 'package:movies_app/tvs/presentation/screens/tvs_details_screen.dart';

class GridViewCard extends StatelessWidget {
  const GridViewCard({
    super.key,
    required this.item,
  });

  final SearchResultItem item;

  @override
  Widget build(BuildContext context) {
    final textTheme = getThemeData[AppTheme.darkTheme]!.textTheme;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            item.isMovie
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsScreen(
                        movieID: item.id,
                      ),
                    ),
                  )
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TvsDetailsScreen(
                        tvsID: item.id,
                      ),
                    ),
                  );
          },
          child: AspectRatio(
            aspectRatio: 2 / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8).r,
              child: ImageWithShimmer(
                imageUrl: ApiConstance.imageURL(item.posterUrl),
                width: double.infinity,
                height: 150.h,
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            item.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
