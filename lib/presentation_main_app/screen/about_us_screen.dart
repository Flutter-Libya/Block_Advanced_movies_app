import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/components/size_box.dart';
import 'package:movies_app/core/global/app_string/app_string.dart';
import 'package:movies_app/core/global/theme/app_color/app_color_dark.dart';
import 'package:movies_app/core/global/theme/theme_data/theme_data.dart';
import 'package:movies_app/core/utils/enum.dart';
import 'package:movies_app/generated/assets.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = getThemeData[AppTheme.darkTheme]!.textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 20, bottom: 20).r,
              child: CircleAvatar(
                maxRadius: 93.r,
                minRadius: 93.r,
                backgroundColor: AppColorsDark.primaryGreenColor,
                child: CircleAvatar(
                  maxRadius: 90.r,
                  minRadius: 90.r,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(95).r,
                    child: Image.asset(
                      Assets.imagesLogo,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: 200.h,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              AppString.aboutUs,
              style: textTheme.titleLarge,
            ),
            Space(height: 10.h, width: 0),
            Container(
              padding: const EdgeInsets.all(4).r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15).r,
                border: Border.all(
                  color: AppColorsDark.primaryGreenColor,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(16).r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15).r,
                  border: Border.all(
                    color: AppColorsDark.primaryGreenColor,
                  ),
                ),
                child: Text(
                  AppString.aboutUsBody,
                  style: textTheme.labelMedium,
                  maxLines: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
