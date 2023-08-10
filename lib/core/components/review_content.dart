import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/components/circle_avatar.dart';
import 'package:movies_app/movies/domain/entities/review.dart';

class ReviewContent extends StatelessWidget {
  const ReviewContent({
    super.key,
    required this.review,
  });

  final Review review;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16).r,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 6).r,
                  child: Avatar(avatarUrl: review.avatarUrl),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.authorName,
                      style: textTheme.bodyMedium,
                    ),
                    Text(
                      review.authorUserName,
                      style: textTheme.bodyLarge,
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10).r,
              child: Text(
                review.content,
                style: textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
